//
//  FSDeviceInfo.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSDeviceInfo : NSObject

/**
 获取设备型号

 @return NSString
 */
+ (NSString *)getDeviceModel;

/**
 获取系统版本

 @return NSString
 */
+ (NSString *)getSystemVersion;

/**
 获取设备名称 e.g. "My iPhone"
 
 @return NSString
 */
+ (NSString *)getIPhoneName;

/**
 获取系统名称

 @return NSString
 */
+ (NSString *)getSystemName;

/**
 获取系统启动时间

 @return NSDate
 */
+ (NSDate *)getSystemStartUpTime;

/**
 获取系统信息

 @return struct
 */
+ (struct utsname)getSystemInfo;

/**
 获取应用名称
 
 @return NSString
 */
+ (NSString *)getBundleDisplayName;

/**
 获取应用版本号
 
 @return NSString
 */
+ (NSString *)getBundleShortVersionString;

/**
 获取内部版本号
 
 @return NSString
 */
+ (NSString *)getBundleVersion;

/**
 获取屏幕像素
 
 @return NSString 320 × 480
 */
+ (NSString *)getScreenPixel;

/**
 判断设备是否越狱
 
 @return BOOL
 */
+ (BOOL)isJailBreak;

#pragma mark - Hardcode Method
/**
 获取设备名称
 
 @return NSString
 */
+ (const NSString *)getDeviceName;

/**
 获取 CPU 名称
 
 @return NSString
 */
+ (const NSString *)getCPUName;

/**
 获取 CPU 频率
 
 @return NSUInteger
 */
+ (NSUInteger)getCPUFrequency;

/**
 获取 协处理器 名称
 
 @return NSString
 */
+ (const NSString *)getCoprocessorName;

/**
 获取电池容量
 
 @return NSUInteger
 */
+ (NSUInteger)getBatteryCapacity;

/**
 获取电池电压
 
 @return CGFloat
 */
+ (CGFloat)getBatteryVoltage;

/**
 获取屏幕尺寸
 
 @return CGFloat 英寸
 */
+ (CGFloat)getScreenSize;

/**
 获取屏幕 PPI
 
 @return NSUInteger
 */
+ (NSUInteger)getPPI;

@end

NS_ASSUME_NONNULL_END
