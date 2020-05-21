//
//  FSANRMonitor.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/24.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSANRInfo.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FSANRMonitorDelegate;
@interface FSANRMonitor : NSObject

/**
 是否启动卡顿
 */
@property (nonatomic, assign, readonly) BOOL isRunning;

/**
 记录日志-卡顿时间阈值，默认0.2s
 */
@property (nonatomic, assign, readonly) NSTimeInterval timeOutInterval;

/**
 记录日志-卡顿次数阈值，默认5次
 */
@property (nonatomic, assign, readonly) NSInteger timeOutCount;

/**
 单例对象

 @return FSANRMonitor
 */
+ (FSANRMonitor *)sharedInstance;

/**
 初始化，设置阈值

 @param timeOutInterval 记录日志-卡顿时间阈值
 @param timeOutCount 记录日志-卡顿次数阈值
 @return instancetype
 */
- (instancetype)initWithTimeOutInterval:(double)timeOutInterval timeOutCount:(NSInteger)timeOutCount;

/**
 初始化

 @return instancetype
 */
- (instancetype)init;

/**
 委托对象添加监控

 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSANRMonitorDelegate>)delegate;

/**
 委托对象去掉监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSANRMonitorDelegate>)delegate;

/**
 开启监控卡顿
 */
- (void)start;

/**
 关闭监控卡顿
 */
- (void)stop;

@end

@protocol FSANRMonitorDelegate <NSObject>

/**
 卡顿回调
 
 @param ANRMonitor 卡顿对象
 @param ANRInfo 卡顿日志
 */
- (void)ANRMonitor:(FSANRMonitor *)ANRMonitor didRecievedANRInfo:(FSANRInfo *)ANRInfo;

@end

NS_ASSUME_NONNULL_END
