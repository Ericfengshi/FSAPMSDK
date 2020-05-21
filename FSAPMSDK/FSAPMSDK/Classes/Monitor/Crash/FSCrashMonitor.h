//
//  FSCrashMonitor.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSCrashInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FSCrashMonitorDelegate;
@interface FSCrashMonitor : NSObject

/**
 是否启动
 */
@property (nonatomic, assign, readonly) BOOL isRunning;

/**
 单例对象
 
 @return FSCrashMonitor
 */
+ (FSCrashMonitor *)sharedInstance;

/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSCrashMonitorDelegate>)delegate;

/**
 委托对象去掉监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSCrashMonitorDelegate>)delegate;

/**
 开启监控闪退
 */
- (void)start;

/**
 关闭监控闪退
 */
- (void)stop;

@end

@protocol FSCrashMonitorDelegate <NSObject>

/**
 闪退回调

 @param crashMonitor 闪退监控对象
 @param exceptionInfo 闪退日志
 */
- (void)crashMonitor:(FSCrashMonitor *)crashMonitor didCatchExceptionInfo:(FSCrashInfo *)exceptionInfo;

@end

NS_ASSUME_NONNULL_END
