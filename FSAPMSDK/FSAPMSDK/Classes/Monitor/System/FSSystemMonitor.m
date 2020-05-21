//
//  FSSystemMonitor.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSSystemMonitor.h"
#import "FSWeakProxy.h"
#import "Reachability.h"

@interface FSSystemMonitor () {
    struct {
        unsigned int didUpdateUsage        :1;
        unsigned int didUpdateCPUUsage     :1;
        unsigned int didUpdateRamUsage     :1;
        unsigned int didUpdateDiskUsage    :1;
        unsigned int didUpdateNetworkFlow  :1;
        unsigned int didUpdateNetworkState :1;
    } _delegateFlags;
    fs_flow_IOBytes _networkFlow;
    fs_flow_IOBytes _startNetworkFlow;
    BOOL _isFisrtGetNetworkFlow;
}

/**
 委托回调对象集合
 */
@property (nonatomic, strong) NSHashTable *hashTable;

/**
 定时器
 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FSSystemMonitor

#pragma mark - Life Cycle
/**
 单例对象
 
 @return FSSystemMonitor
 */
+ (FSSystemMonitor *)sharedInstance  {
    static FSSystemMonitor *sharedInstance = nil;
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
        _timeInterval = 1.0;
        _isFisrtGetNetworkFlow = YES;
    }
    return self;
}

/**
 释放对象
 */
- (void)dealloc {
    [self stop];
    [self p_removeAllDelegates];
}

#pragma mark - Action Method
/**
 定时操作
 */
- (void)timerFire {
    // CPU
    fs_app_cpu_usage app_cpu_usage = [FSCPUUsage getAppCPUUsageStruct];
    fs_system_cpu_usage system_cpu_usage = [FSCPUUsage getSystemCPUUsageStruct];

    // RAM
    unsigned long long appRamUsage = [FSRAMUsage getAppRAMUsage];
    fs_system_ram_usage system_ram_usage = [FSRAMUsage getSystemRamUsageStruct];
    
    // disk
    unsigned long long diskUsedSize = [FSDiskUsage getDiskUsedSize];
    unsigned long long diskFreeSize = [FSDiskUsage getDiskFreeSize];
    
    // NetworkFlow
    fs_flow_IOBytes networkFlow = [FSNetworkFlow getFlowIOBytes];
    fs_flow_IOBytes startNetworkFlow;
    startNetworkFlow.wifi_received = networkFlow.wifi_received - _startNetworkFlow.wifi_received;
    startNetworkFlow.wifi_sent = networkFlow.wifi_sent - _startNetworkFlow.wifi_sent;
    startNetworkFlow.cellular_sent = networkFlow.cellular_sent - _startNetworkFlow.cellular_sent;
    startNetworkFlow.cellular_received = networkFlow.cellular_received - _startNetworkFlow.cellular_received;
    startNetworkFlow.total_received = networkFlow.total_received - _startNetworkFlow.total_received;
    startNetworkFlow.total_sent = networkFlow.total_sent - _startNetworkFlow.total_sent;
    
    for (id<FSSystemMonitorDelegate> delegate in _hashTable) {
        BOOL didUpdateUsage = [delegate respondsToSelector:@selector(systemMonitorDidUpdateUsage:)];
        BOOL didUpdateCPUUsage = [delegate respondsToSelector:@selector(systemMonitor:didUpdateAppCPUUsage:systemCPUUsage:)];
        BOOL didUpdateRamUsage = [delegate respondsToSelector:@selector(systemMonitor:didUpdateAppRamUsage:systemRamUsage:)];
        BOOL didUpdateDiskUsage = [delegate respondsToSelector:@selector(systemMonitor:didUpdatetDiskUsedSize:diskFreeSize:)];
        BOOL didUpdateNetworkFlow = [delegate respondsToSelector:@selector(systemMonitor:didUpdateNetworkFlowSent:received:total:)];
        BOOL didUpdateNetworkState = [delegate respondsToSelector:@selector(systemMonitor:didUpdateNetworkState:)];
        
        if (didUpdateUsage) {
            [delegate systemMonitorDidUpdateUsage:self];
        }
        if (didUpdateCPUUsage) {
            [delegate systemMonitor:self didUpdateAppCPUUsage:app_cpu_usage systemCPUUsage:system_cpu_usage];
        }
        if (didUpdateRamUsage) {
            [delegate systemMonitor:self didUpdateAppRamUsage:appRamUsage systemRamUsage:system_ram_usage];
        }
        if (didUpdateDiskUsage) {
            [delegate systemMonitor:self didUpdatetDiskUsedSize:diskUsedSize diskFreeSize:diskFreeSize];
        }
        
        if (didUpdateNetworkFlow) {
            if (_isFisrtGetNetworkFlow) {
                _isFisrtGetNetworkFlow = NO;
            } else {
                [delegate systemMonitor:self didUpdateNetworkFlowSent:networkFlow.total_sent - _networkFlow.total_sent received:networkFlow.total_received - _networkFlow.total_received total:startNetworkFlow];
            }
            _networkFlow = networkFlow;
        }
        
        // networkState
        NSString *networkState = [FSSystemMonitor p_getNetworkState];
        if (didUpdateNetworkState) {
            [delegate systemMonitor:self didUpdateNetworkState:networkState];
        }
    }
}

#pragma mark - Public Method
/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSSystemMonitorDelegate>)delegate {
    [self.hashTable addObject:delegate];
}

/**
 委托对象去掉监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSSystemMonitorDelegate>)delegate {
    if ([self.hashTable containsObject:delegate]) {
        [self.hashTable removeObject:delegate];
    }
}

/**
 开启监控
 */
- (void)start {
    if (!_timer) {
        _startNetworkFlow = [FSNetworkFlow getFlowIOBytes];
    }
    [self p_addTimer];
}

/**
 关闭监控
 */
- (void)stop {
    [self p_removeTimer];
}

#pragma mark - Private Method
/**
 去除所有委托对象
 */
- (void)p_removeAllDelegates {
    [self.hashTable removeAllObjects];
}

/**
 开启定时器
 */
- (void)p_addTimer {
    if (_timer) {
        [self p_removeTimer];
    }
    _timer = [NSTimer timerWithTimeInterval:_timeInterval target:[FSWeakProxy proxyWithTarget:self] selector:@selector(timerFire) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 关闭定时器
 */
- (void)p_removeTimer {
    if (!_timer) {
        return;
    }
    [_timer invalidate];
    _timer = nil;
}

/**
 获取设备网络状态

 @return NSString
 */
+ (NSString *)p_getNetworkState {
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    NSString *state = @"无网络";
    if (status == NotReachable) {
        
    } else if (status == ReachableViaWiFi) {
        state = @"WiFi";
    } else if (status == ReachableViaWWAN) {
        state = @"蜂窝流量";
    }
    return state;
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
