//
//  FSBayMaxProtector.h
//  FSAPMSDK
//
//  实现来源:https://github.com/jezzmemo/JJException/blob/master/JJExceptionPrinciple.md、https://neyoufan.github.io/2017/01/13/ios/BayMax_HTSafetyGuard
//
//  Created by fengs on 2019/1/25.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBayMaxCrashInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FSBayMaxProtectorDelegate;
@interface FSBayMaxProtector : NSObject

/**
 是否启动防护
 */
@property (nonatomic, assign, readonly) BOOL isRunning;

/**
 防护级别
 */
@property (nonatomic, assign, readonly) FSProtectorCategory protectorType;

/**
 单例对象
 
 @return FSANRMonitor
 */
+ (FSBayMaxProtector *)sharedInstance;

/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSBayMaxProtectorDelegate>)delegate;

/**
 委托对象去除监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSBayMaxProtectorDelegate>)delegate;

/**
 开启监控
 */
- (void)start;

/**
 关闭监控
 */
- (void)stop;

/**
 配置 Crash 防护级别
 
 @param protectorType Crash 防护级别
 */
- (void)configBayMaxProtectorType:(FSProtectorCategory)protectorType;

/**
 设置类野指针黑名单，自己添加的类野指针防护
 作用：一些特定的类是不适用于添加到zombie机制的，会发生崩溃（例如：NSBundle）
 使用：[self addZombieProtectorOnClasses:@[TestZombie.class]];
 
 @param objectClasses 要忽略的类的集合
 */
- (void)addZombieProtectorOnClasses:(NSArray *_Nonnull)objectClasses;

@end

@protocol FSBayMaxProtectorDelegate <NSObject>

/**
 捕捉到防护 Crash 日志回调

 @param bayMaxProtector 返回对象
 @param crashInfo 异常对象
 */
- (void)bayMaxProtector:(FSBayMaxProtector *)bayMaxProtector handleCrashInfo:(FSBayMaxCrashInfo *)crashInfo;

@end

NS_ASSUME_NONNULL_END
