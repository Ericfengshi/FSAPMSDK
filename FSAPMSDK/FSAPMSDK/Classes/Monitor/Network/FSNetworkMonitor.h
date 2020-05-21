//
//  FSNetworkMonitor.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/29.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSNetworkInfo.h"

NS_ASSUME_NONNULL_BEGIN

@class FSNetworkMonitor;
@protocol FSNetworkMonitorDelegate <NSObject>

/**
 网络监控回调

 @param monitor 监控对象
 @param networkInfo 流量数据
 */
- (void)networkMonitor:(FSNetworkMonitor *)monitor didCatchNetworkInfo:(FSNetworkInfo *)networkInfo;

@end

@interface FSNetworkMonitor : NSObject

/**
 是否启动
 */
@property (nonatomic, assign, readonly) BOOL isRunning;

/**
 单例对象
 
 @return FSNetworkMonitor
 */
+ (FSNetworkMonitor *)sharedInstance;

/**
 委托对象添加网络
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSNetworkMonitorDelegate>)delegate;

/**
 委托对象去掉网络
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSNetworkMonitorDelegate>)delegate;

/**
 开启监控网络
 */
- (void)start;

/**
 关闭监控网络
 */
- (void)stop;

@end


NS_ASSUME_NONNULL_END
