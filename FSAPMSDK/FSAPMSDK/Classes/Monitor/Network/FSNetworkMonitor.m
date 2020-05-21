//
//  FSNetworkMonitor.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/29.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSNetworkMonitor.h"
#import "FSURLProtocol.h"

@interface FSNetworkMonitor () <FSURLProtocolDelegate>

/**
 委托回调对象集合
 */
@property (nonatomic, strong) NSHashTable *hashTable;

/**
 是否启动
 */
@property (nonatomic, assign, readwrite) BOOL isRunning;

@end

@implementation FSNetworkMonitor

#pragma mark - Life Cycle
/**
 单例对象
 
 @return FSNetworkMonitor
 */
+ (FSNetworkMonitor *)sharedInstance  {
    static FSNetworkMonitor *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化

 @return FSNetworkMonitor
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
 开启网络监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSNetworkMonitorDelegate>)delegate {
    [self.hashTable addObject:delegate];
}

/**
 关闭网络监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSNetworkMonitorDelegate>)delegate {
    if ([self.hashTable containsObject:delegate]) {
        [self.hashTable removeObject:delegate];
    }
}

/**
 开启网络监控
 */
- (void)start {
    if (_isRunning) {
        return;
    }
    _isRunning = YES;
    [FSURLProtocol addDelegate:self];
}

/**
 关闭网络监控
 */
- (void)stop {
    if (!_isRunning) {
        return;
    }
    _isRunning = NO;
    [FSURLProtocol removeDelegate:self];
}

#pragma mark - Private Method
/**
 关闭所有委托对象
 */
- (void)p_removeAllDelegates {
    [self.hashTable removeAllObjects];
}

#pragma mark -FSURLProtocolDelegate
/**
 获取流量请求监控
 
 @param URLProtocol 连接协议对象
 */
- (void)URLProtocolDidCatchURLRequest:(FSURLProtocol *)URLProtocol {
    if (!_hashTable) {
        return;
    }
    FSNetworkInfo *info = [[FSNetworkInfo alloc]init];
    info.startDate = URLProtocol.startDate;
    info.endDate = URLProtocol.endDate;
    info.time = URLProtocol.startDate.timeIntervalSince1970;
    info.during = [URLProtocol.endDate timeIntervalSinceDate:URLProtocol.startDate];
    info.request = URLProtocol.fs_request;
    info.response = (NSHTTPURLResponse *)URLProtocol.fs_response;
    info.data = [URLProtocol.fs_receive_data copy];
    
    for (id<FSNetworkMonitorDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(networkMonitor:didCatchNetworkInfo:)]) {
            [delegate networkMonitor:self didCatchNetworkInfo:info];
        }
    }
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

@end
