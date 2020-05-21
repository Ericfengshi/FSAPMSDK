//
//  FSANRMonitor.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/24.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSANRMonitor.h"
#import "FSBackTraceInfo.h"

@interface FSANRMonitor ()

/**
 卡顿委托回调对象集合
 */
@property (nonatomic, strong) NSHashTable *hashTable;

/**
 信号量
 */
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

/**
 主线程观察
 */
@property (nonatomic, assign) CFRunLoopObserverRef observer;

/**
 RunLoop处于状态值
 */
@property (nonatomic, assign) CFRunLoopActivity activity;

/**
 操作队列：自定义串行队列
 */
@property (nonatomic, strong) dispatch_queue_t queue;

/**
 记录日志-卡顿时间阈值，默认0.2s
 */
@property (nonatomic, assign, readwrite) NSTimeInterval timeOutInterval;

/**
 记录日志-卡顿次数阈值，默认5次
 */
@property (nonatomic, assign, readwrite) NSInteger timeOutCount;

/**
 是否启动卡顿
 */
@property (nonatomic, assign, readwrite) BOOL isRunning;

/**
 当前记录的卡顿次数
 */
@property (nonatomic, assign) NSInteger curTimeOutCount;

@end

/**
 创建 RunLoop observer对象

 @param observer observer对象
 @param activity runloop观察状态
 @param info 信息
 */
static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    FSANRMonitor *monitor =  (__bridge FSANRMonitor*)info;
    monitor.activity = activity;
    dispatch_semaphore_signal(monitor.semaphore);
}

@implementation FSANRMonitor

#pragma mark - Life Cycle
/**
 单例对象
 
 @return FSANRMonitor
 */
+ (FSANRMonitor *)sharedInstance  {
    static FSANRMonitor *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化，设置阈值
 
 @param timeOutInterval 记录日志-卡顿时间阈值
 @param timeOutCount 记录日志-卡顿次数阈值
 @return instancetype
 */
- (instancetype)initWithTimeOutInterval:(double)timeOutInterval timeOutCount:(NSInteger)timeOutCount {
    if (self = [super init]) {
        _curTimeOutCount = 0;
        _timeOutInterval = timeOutInterval;
        _timeOutCount = timeOutCount;
        _queue = dispatch_queue_create("com.fengs.TTYYANRMonitor", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

/**
 初始化
 
 @return instancetype
 */
- (instancetype)init {
    return [self initWithTimeOutInterval:0.2 timeOutCount:5];
}

/**
 释放
 */
- (void)dealloc {
    [self stop];
    [self p_removeAllDelegates];
}

#pragma mark - Public Method
/**
 开启监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSANRMonitorDelegate>)delegate {
    [self.hashTable addObject:delegate];
}

/**
 关闭监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSANRMonitorDelegate>)delegate {
    if ([self.hashTable containsObject:delegate]) {
        [self.hashTable removeObject:delegate];
    }
}

/**
 开启监控卡顿
 */
- (void)start {
    if (_observer) {
        return;
    }
    _semaphore = dispatch_semaphore_create(0);
    CFRunLoopObserverContext context = {0, (__bridge void*)self, &CFRetain, &CFRelease};
    _observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopAllActivities, true, 0, &runLoopObserverCallBack, &context);
    // 观察主线程卡顿
    CFRunLoopAddObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(_queue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        while (YES) {
            long st = dispatch_semaphore_wait(strongSelf.semaphore, dispatch_time(DISPATCH_TIME_NOW, strongSelf.timeOutInterval*1000*NSEC_PER_MSEC));
            if (st != 0) {
                if (!strongSelf.observer) {
                    strongSelf.curTimeOutCount = 0;
                    strongSelf.activity = 0;
                    strongSelf.semaphore = nil;
                    return ;
                }
                // 超时
                if (strongSelf.activity == kCFRunLoopBeforeSources || strongSelf.activity == kCFRunLoopAfterWaiting) {
                    if (++strongSelf.curTimeOutCount < strongSelf.timeOutCount) {
                        continue;
                    }
                    // 超时5*200ms
                    [strongSelf p_handleANRTimeOut];
                }
            }
            strongSelf.curTimeOutCount = 0;
        }
    });
}

/**
 关闭监控卡顿
 */
- (void)stop {
    if (!_observer) {
        return;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    CFRelease(_observer);
    _observer = NULL;
    _curTimeOutCount = 0;
    _activity = 0;
}

#pragma mark - Private Method
/**
 去除所有委托对象
 */
- (void)p_removeAllDelegates {
    [self.hashTable removeAllObjects];
}

/**
 记录卡顿
 */
- (void)p_handleANRTimeOut {
    if (!_hashTable) {
        return;
    }
    FSANRInfo *ANRInfo = [[FSANRInfo alloc]init];
    ANRInfo.content = [self p_getCurrentTrackInfo];
    ANRInfo.date = [NSDate date];
    ANRInfo.time = [ANRInfo.date timeIntervalSince1970];
    for (id<FSANRMonitorDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(ANRMonitor:didRecievedANRInfo:)]) {
            [delegate ANRMonitor:self didRecievedANRInfo:ANRInfo];
        }
    }
}

/**
 当前卡顿线程

 @return NSString
 */
- (NSString *)p_getCurrentTrackInfo {
    NSString *content = [FSBackTraceInfo fs_backtraceOfAllThread];
    return content;
}

#pragma mark - Getters and Setters
/**
 卡顿委托回调对象集合

 @return NSHashTable
 */
- (NSHashTable *)hashTable {
    if (!_hashTable) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    return _hashTable;
}

/**
 是否处于观察卡顿状态

 @return BOOL
 */
- (BOOL)isRunning {
    return _observer != NULL;
}

@end
