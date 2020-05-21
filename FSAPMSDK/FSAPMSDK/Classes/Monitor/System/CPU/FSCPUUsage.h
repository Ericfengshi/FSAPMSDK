//
//  FSCPUUsage.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 APP 使用 CPU 情况
 */
typedef struct {
    long user_time;     /* user run time */
    long system_time;   /* system run time */
    float cpu_usage;    /* cpu usage percentage */
}fs_app_cpu_usage;

/**
 系统使用 CPU 情况
 */
typedef struct {
    float user;         /* user state cpu usage percentage*/
    float system;
    float nice;
    float idle;
    float total;        /* total cpu usage percentage, use it */
}fs_system_cpu_usage;

@interface FSCPUUsage : NSObject

/**
 APP CPU 使用率

 @return float 获取失败返回 0
 */
+ (float)getAppCPUUsage;

/**
 系统 CPU 使用率

 @return float 获取失败返回 0
 */
+ (float)getSystemCPUUsage;

/**
 CPU 内核数

 @return NSInteger
 */
+ (NSInteger)getCPUCoreNumber;

/**
 CPU 频率

 @return NSUInteger
 */
+ (NSUInteger)getCPUFrequency;

/**
 CPU 架构 (processor architecture)

 @return NSString
 */
+ (NSString *)getCPUArchitectureString;

/**
 APP 使用 CPU 情况

 @return fs_app_cpu_usage
 */
+ (fs_app_cpu_usage)getAppCPUUsageStruct;

/**
 系统使用 CPU 情况

 @return fs_system_cpu_usage
 */
+ (fs_system_cpu_usage)getSystemCPUUsageStruct;

@end

NS_ASSUME_NONNULL_END
