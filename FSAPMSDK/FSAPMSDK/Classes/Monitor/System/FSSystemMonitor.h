//
//  FSSystemMonitor.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSCPUUsage.h"
#import "FSRAMUsage.h"
#import "FSDiskUsage.h"
#import "FSNetworkFlow.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FSSystemMonitorDelegate;
@interface FSSystemMonitor : NSObject

/**
 监控间隔
 */
@property (nonatomic, assign) float timeInterval;

/**
 单例对象
 
 @return FSSystemMonitor
 */
+ (FSSystemMonitor *)sharedInstance;

/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSSystemMonitorDelegate>)delegate;

/**
 委托对象去掉监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSSystemMonitorDelegate>)delegate;

/**
 开启监控
 */
- (void)start;

/**
 关闭监控
 */
- (void)stop;

@end

@protocol FSSystemMonitorDelegate <NSObject>

@optional
/**
 系统监控已回调

 @param systemMonitor 系统监控
 */
- (void)systemMonitorDidUpdateUsage:(FSSystemMonitor *)systemMonitor;

/**
 CPU 使用情况回调

 @param systemMonitor 系统监控
 @param app_cpu_usage 应用 CPU 使用情况
 @param system_cpu_usage 系统 CPU 使用情况
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateAppCPUUsage:(fs_app_cpu_usage)app_cpu_usage systemCPUUsage:(fs_system_cpu_usage)system_cpu_usage;

/**
 RAM 使用情况回调

 @param systemMonitor 系统监控
 @param app_ram_usage 应用 RAM 使用情况
 @param system_ram_usage 系统 RAM 使用情况
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateAppRamUsage:(unsigned long long)app_ram_usage systemRamUsage:(fs_system_ram_usage)system_ram_usage;

/**
 磁盘 使用情况回调

 @param systemMonitor 系统监控
 @param disk_used_size 磁盘使用大小
 @param disk_free_size 磁盘剩余大小
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdatetDiskUsedSize:(unsigned long long)disk_used_size diskFreeSize:(unsigned long long)disk_free_size;

/**
 网络流量监控

 @param systemMonitor 系统监控
 @param sent 上行 byte/timeInterval
 @param received received 下行 byte/timeInterval
 @param total 流量结构体
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateNetworkFlowSent:(unsigned int)sent received:(unsigned int)received total:(fs_flow_IOBytes)total;

/**
 网络状态更新
 "无网络"、"蜂窝流量"、"Wifi"
 
 @param systemMonitor 系统监控
 @param state 网络状态
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateNetworkState:(NSString *)state;

@end

NS_ASSUME_NONNULL_END
