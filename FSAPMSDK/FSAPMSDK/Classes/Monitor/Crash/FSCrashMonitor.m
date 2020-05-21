//
//  FSCrashMonitor.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSCrashMonitor.h"

/**
 上一个异常处理 handler
 */
static NSUncaughtExceptionHandler *oldUncaughtExceptionHandler = NULL;

/**
 是否设置异常处理 handler
 */
static BOOL isSetUncaughtHandler = NO;

@interface FSCrashMonitor ()

/**
 委托回调对象集合
 */
@property (nonatomic, strong) NSHashTable *hashTable;

/**
 是否启动防护
 */
@property (nonatomic, assign, readwrite) BOOL isRunning;

@end

@implementation FSCrashMonitor

#pragma mark - Life Cycle
/**
 单例对象
 
 @return FSCrashMonitor
 */
+ (FSCrashMonitor *)sharedInstance  {
    static FSCrashMonitor *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化
 
 @return instancetype
 */
- (instancetype)init {
    if (self = [super init]) {
        _isRunning = NO;
    }
    return self;
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
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSCrashMonitorDelegate>)delegate {
    [self.hashTable addObject:delegate];
}

/**
 委托对象去除监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSCrashMonitorDelegate>)delegate {
    if ([self.hashTable containsObject:delegate]) {
        [self.hashTable removeObject:delegate];
    }
}

/**
 开启监控
 */
- (void)start {
    if (_isRunning) {
        return;
    }
    _isRunning = YES;
    fs_hashTableAddObject(self);
}

/**
 关闭监控
 */
- (void)stop {
    if (!_isRunning) {
        return;
    }
    _isRunning = NO;
    fs_hashTableRemoveObject(self);
}

#pragma mark - Private Method
/**
 关闭所有委托对象
 */
- (void)p_removeAllDelegates {
    [self.hashTable removeAllObjects];
}

/**
 信号名称

 @param signal 信号类型
 @return NSString
 */
- (NSString *)signalName:(int)signal {
    switch (signal) {
        case SIGABRT:
            return @"SIGABRT";
        case SIGILL:
            return @"SIGILL";
        case SIGSEGV:
            return @"SIGSEGV";
        case SIGFPE:
            return @"SIGFPE";
        case SIGBUS:
            return @"SIGBUS";
        case SIGPIPE:
            return @"SIGPIPE";
        default:
            return @"UNKNOWN";
    }
}

#pragma mark -NSHashTable
/**
 类方法-委托回调对象集合

 @return NSHashTable
 */
+ (NSHashTable *)classHashTable {
    static NSHashTable<FSCrashMonitor *> *hashTable = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hashTable = [NSHashTable weakObjectsHashTable];
    });
    return hashTable;
}

/**
 开启捕捉闪退
 */
void fs_startUncaughtCrashHandlerIfNeed() {
    if ([FSCrashMonitor classHashTable].count > 0) {
        fs_installUncaughtCrashHandler();
    }
}

/**
 关闭捕捉闪退
 */
void fs_stopUncaughtCrashHandlerIfNeed() {
    if ([FSCrashMonitor classHashTable].count == 0) {
        fs_uninstallUncaughtCrashHandler();
    }
}

/**
 新增捕捉的闪退

 @param object FSCrashMonitor
 */
void fs_hashTableAddObject(FSCrashMonitor *object) {
    if (object) {
        [[FSCrashMonitor classHashTable] addObject:object];
        fs_startUncaughtCrashHandlerIfNeed();
    }
}

/**
 移除捕捉的闪退
 
 @param object FSCrashMonitor
 */
void fs_hashTableRemoveObject(FSCrashMonitor *object) {
    if (object) {
        [[FSCrashMonitor classHashTable] removeObject:object];
        fs_stopUncaughtCrashHandlerIfNeed();
    }
}

#pragma mark -uncaughtCrashHandler 异常处理
/**
 开启捕捉闪退handler
 */
void fs_installUncaughtCrashHandler() {
    if (isSetUncaughtHandler) {
        return;
    }
    isSetUncaughtHandler = YES;
    
    oldUncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
    NSSetUncaughtExceptionHandler (p_uncaughtExceptionHandler);
    
    signal(SIGABRT, p_uncaughtSignalHandler);
    signal(SIGILL, p_uncaughtSignalHandler);
    signal(SIGSEGV, p_uncaughtSignalHandler);
    signal(SIGFPE, p_uncaughtSignalHandler);
    signal(SIGBUS, p_uncaughtSignalHandler);
    signal(SIGPIPE, p_uncaughtSignalHandler);
}

/**
 关闭捕捉闪退handler
 */
void fs_uninstallUncaughtCrashHandler() {
    if (!isSetUncaughtHandler) {
        return;
    }
    isSetUncaughtHandler = NO;
    
    NSSetUncaughtExceptionHandler (oldUncaughtExceptionHandler);
    
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
}

/**
 异常处理 handler

 @param exception NSException
 */
void p_uncaughtExceptionHandler(NSException *exception) {
    if (oldUncaughtExceptionHandler) {
        oldUncaughtExceptionHandler(exception);
    }
    
    for (FSCrashMonitor *monitor in [FSCrashMonitor classHashTable]) {
        if (monitor.isRunning && [monitor respondsToSelector:@selector(p_uncaughtExceptionHandler:)]) {
            [monitor p_uncaughtExceptionHandler:exception];
        }
    }
}

/**
 异常信号处理

 @param signal 信号
 */
void p_uncaughtSignalHandler(int signal) {
    for (FSCrashMonitor *monitor in [FSCrashMonitor classHashTable]) {
        if (monitor.isRunning && [monitor respondsToSelector:@selector(p_uncaughtSignalHandler:)]) {
            [monitor p_uncaughtSignalHandler:signal];
        }
    }
}

/**
 异常处理回调

 @param exception NSException
 */
- (void)p_uncaughtExceptionHandler:(NSException *)exception {
    if (!_hashTable) {
        return;
    }
    FSCrashInfo *info = [[FSCrashInfo alloc] init];
    info.date = [NSDate date];
    info.signal = kFSCrashException;
    info.exception = exception;
    info.name = exception.name;
    info.reason = exception.reason;
    info.callBackTrace = [exception.callStackSymbols componentsJoinedByString:@"\n"];
    for (id<FSCrashMonitorDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(crashMonitor:didCatchExceptionInfo:)]) {
            [delegate crashMonitor:self didCatchExceptionInfo:info];
        }
    }
}

/**
 异常信号处理回调

 @param signal 信号类型
 */
- (void)p_uncaughtSignalHandler:(int)signal {
    if (!_hashTable) {
        return;
    }
    NSMutableArray *callStackSymbols = [[NSThread callStackSymbols] mutableCopy];
    if (callStackSymbols.count > 2) {
        [callStackSymbols removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]];
    }
    FSCrashInfo *info = [[FSCrashInfo alloc]init];
    info.date = [NSDate date];
    info.signal = signal;
    info.name = [self signalName:signal];
    info.reason = [NSString stringWithFormat:@"Signal %@ crash.",
                   [self signalName:signal]];
    info.callBackTrace = [callStackSymbols componentsJoinedByString:@"\n"];
    for (id<FSCrashMonitorDelegate>delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(crashMonitor:didCatchExceptionInfo:)]) {
            [delegate crashMonitor:self didCatchExceptionInfo:info];
        }
    }
    [self stop];
    kill(getpid(), SIGKILL);
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
