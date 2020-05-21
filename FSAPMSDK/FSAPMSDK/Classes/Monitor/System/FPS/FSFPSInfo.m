//
//  FSFPSInfo.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSFPSInfo.h"

@interface FSFPSInfo ()<FSFPSMonitorDelegate>

/**
 委托回调对象集合
 */
@property (nonatomic, strong) NSHashTable *hashTable;

/**
 FPS 监听对象
 */
@property (nonatomic, strong) FSFPSMonitor *fpsMonitor;

@end

@implementation FSFPSInfo

#pragma mark - Life Cycle
/**
 单例对象
 
 @return FSFPSInfo
 */
+ (instancetype)sharedInstance {
    static FSFPSInfo *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化

 @return FSFPSInfo
 */
- (instancetype)init {
    if (self = [super init]) {
        // 添加 FPS 监视器
        [self p_addFPSMonitor];
        // 添加应用进入前后台通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(applicationDidBecomeActiveNotification)
                                                     name: UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(applicationWillResignActiveNotification)
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: nil];
    }
    return self;
}

/**
 对象释放
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_fpsMonitor stop];
    [self p_removeAllDelegates];
}

#pragma mark - NSNotificationCenter
/**
 应用进入前台，开启监听 FPS
 */
- (void)applicationDidBecomeActiveNotification {
    [_fpsMonitor start];
}

/**
 应用进入后台，关闭监听 FPS
 */
- (void)applicationWillResignActiveNotification {
    [_fpsMonitor stop];
}

#pragma mark - Public Method
/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSFPSMonitorDelegate>)delegate {
    [self.hashTable addObject:delegate];
}

/**
 委托对象去除监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSFPSMonitorDelegate>)delegate {
    if ([self.hashTable containsObject:delegate]) {
        [self.hashTable removeObject:delegate];
    }
}

/**
 开启检测 FPS
 */
- (void)start {
    [_fpsMonitor start];
}

/**
 关闭检测 FPS
 */
- (void)stop {
    [_fpsMonitor stop];
}

#pragma mark - Private Method
/**
 添加 FPS 监视器
 */
- (void)p_addFPSMonitor {
    FSFPSMonitor *fpsMonitor = [[FSFPSMonitor alloc] init];
    [fpsMonitor addDelegate:self];
    _fpsMonitor = fpsMonitor;
}

/**
 关闭所有委托对象
 */
- (void)p_removeAllDelegates {
    [self.hashTable removeAllObjects];
}

#pragma mark - FSFPSMonitorDelegate
/**
 FPS 更新回调
 
 @param FPSMoitor 监控对象
 @param fps 刷新率
 */
- (void)FPSMoitor:(FSFPSMonitor *)FPSMoitor didUpdateFPS:(float)fps {
    _fps = fps;
    for (id<FSFPSMonitorDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(FPSMoitor:didUpdateFPS:)]) {
            [delegate FPSMoitor:FPSMoitor didUpdateFPS:fps];
        }
    }
}

#pragma mark - Getters and Setters
/**
 委托回调对象集合
 
 @return NSHashTable
 */
- (NSHashTable *)hashTable {
    if (!_hashTable) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    return _hashTable;
}

@end
