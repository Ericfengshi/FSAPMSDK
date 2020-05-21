//
//  FSBatteryMonitor.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBatteryInfo.h"

NS_ASSUME_NONNULL_BEGIN

@class FSBatteryMonitor;
@protocol FSBatteryMonitorDelegate <NSObject>

/**
 电池更新回调
 
 @param batteryMoitor 监控对象
 @param battery 电池信息
 */
- (void)batteryMoitor:(FSBatteryMonitor *)batteryMoitor didUpdateBattery:(FSBatteryInfo *)battery;

@end

@interface FSBatteryMonitor : NSObject

/**
 单例对象
 
 @return FSBatteryMonitor
 */
+ (instancetype)sharedInstance;

/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSBatteryMonitorDelegate>)delegate;

/**
 委托对象去掉监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSBatteryMonitorDelegate>)delegate;

/**
 开启检测电池
 */
- (void)start;

/**
 关闭检测电池
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
