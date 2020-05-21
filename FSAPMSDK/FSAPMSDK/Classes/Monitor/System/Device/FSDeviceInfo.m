//
//  FSDeviceInfo.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSDeviceInfo.h"
#import "FSHardcodeDeviceInfo.h"
#import "sys/utsname.h"

@implementation FSDeviceInfo

/**
 获取设备型号
 
 @return NSString
 */
+ (NSString *)getDeviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceModel;
}

/**
 获取系统版本
 
 @return NSString
 */
+ (NSString *)getSystemVersion {
    return [UIDevice currentDevice].systemVersion;
}

/**
 获取设备名称 e.g. "My iPhone"
 
 @return NSString
 */
+ (NSString *)getIPhoneName {
    return [UIDevice currentDevice].name;
}

/**
 获取系统名称
 
 @return NSString
 */
+ (NSString *)getSystemName {
    return [UIDevice currentDevice].systemName;
}

/**
 获取系统启动时间
 
 @return NSDate
 */
+ (NSDate *)getSystemStartUpTime {
    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    return [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
}

/**
 获取系统信息
 
 @return struct
 */
+ (struct utsname)getSystemInfo {
    struct utsname systemInfo;
    uname(&systemInfo);
    return systemInfo;
}

/**
 获取应用名称
 
 @return NSString
 */
+ (NSString *)getBundleDisplayName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

/**
 获取应用版本号
 
 @return NSString
 */
+ (NSString *)getBundleShortVersionString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

/**
 获取内部版本号
 
 @return NSString
 */
+ (NSString *)getBundleVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

/**
 获取屏幕像素
 
 @return NSString 320 × 480
 */
+ (NSString *)getScreenPixel {
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *screenPixel = [NSString stringWithFormat:@"%.f × %.f", size.width * scale, size.height * scale];
    return screenPixel;
}

#pragma mark -判断设备是否越狱
#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

/**
 判断设备是否越狱
 
 @return BOOL
 */
+ (BOOL)isJailBreak {
    for (int i = 0; i < ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Hardcode Method
/**
 获取设备名称
 
 @return NSString
 */
+ (const NSString *)getDeviceName {
    return [[FSHardcodeDeviceInfo machineHardcodedDeviceInfo] getDeviceName];
}

/**
 获取 CPU 名称
 
 @return NSString
 */
+ (const NSString *)getCPUName {
    return [[FSHardcodeDeviceInfo machineHardcodedDeviceInfo] getCPUName];
}

/**
 获取 CPU 频率
 
 @return NSUInteger
 */
+ (NSUInteger)getCPUFrequency {
    return [[FSHardcodeDeviceInfo machineHardcodedDeviceInfo] getCPUFrequency];
}

/**
 获取 协处理器 名称
 
 @return NSString
 */
+ (const NSString *)getCoprocessorName {
    return [[FSHardcodeDeviceInfo machineHardcodedDeviceInfo] getCoprocessorName];
}

/**
 获取电池容量
 
 @return NSUInteger
 */
+ (NSUInteger)getBatteryCapacity {
    return [[FSHardcodeDeviceInfo machineHardcodedDeviceInfo] getBatteryCapacity];
}

/**
 获取电池电压
 
 @return CGFloat
 */
+ (CGFloat)getBatteryVoltage {
    return [[FSHardcodeDeviceInfo machineHardcodedDeviceInfo] getBatteryVoltage];
}

/**
 获取屏幕尺寸
 
 @return CGFloat 英寸
 */
+ (CGFloat)getScreenSize {
    return [[FSHardcodeDeviceInfo machineHardcodedDeviceInfo] getScreenSize];
}

/**
 获取屏幕 PPI
 
 @return NSUInteger
 */
+ (NSUInteger)getPPI {
    return [[FSHardcodeDeviceInfo machineHardcodedDeviceInfo] getPPI];
}

@end
