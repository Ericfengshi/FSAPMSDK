//
//  FSFPSInfo.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSFPSMonitor.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSFPSInfo : NSObject

/**
 FPS 刷新率
 */
@property (nonatomic, assign) CGFloat fps;

/**
 单例对象
 
 @return FSFPSInfo
 */
+ (instancetype)sharedInstance;

/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSFPSMonitorDelegate>)delegate;

/**
 委托对象去掉监控
 
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
