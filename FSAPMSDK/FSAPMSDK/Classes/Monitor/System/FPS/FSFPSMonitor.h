//
//  FSFPSMonitor.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FSFPSMonitor;
@protocol FSFPSMonitorDelegate <NSObject>

/**
 FPS 更新回调

 @param FPSMoitor 监控对象
 @param fps 刷新率
 */
- (void)FPSMoitor:(FSFPSMonitor *)FPSMoitor didUpdateFPS:(float)fps;

@end

@interface FSFPSMonitor : NSObject

/**
 FPS 检测间隔时间默认1s
 */
@property (nonatomic, assign) NSTimeInterval updateFPSInterval;

/**
 单例对象
 
 @return FSFPSMonitor
 */
+ (instancetype)sharedInstance;

/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSFPSMonitorDelegate>)delegate;

/**
 委托对象去除监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSFPSMonitorDelegate>)delegate;

/**
 开启检测 FPS
 */
- (void)start;

/**
 关闭检测 FPS
 */
- (void)stop;

@end


NS_ASSUME_NONNULL_END
