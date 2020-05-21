//
//  FSAPMManager.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSAPMManager.h"
#import "FSFPSMonitor.h"
#import "FSBatteryMonitor.h"
#import "FSANRMonitor.h"
#import "FSCrashMonitor.h"
#import "FSBayMaxProtector.h"
#import "FSAPMHttpDNS.h"
#import "FSNetworkMonitor.h"
#import "FSSystemMonitor.h"

@interface FSAPMManager () <FSFPSMonitorDelegate, FSBatteryMonitorDelegate, FSANRMonitorDelegate, FSCrashMonitorDelegate, FSBayMaxProtectorDelegate, FSAPMHttpDNSDelegate, FSNetworkMonitorDelegate, FSSystemMonitorDelegate>

/**
 应用启动时间
 */
@property (nonatomic, assign) NSTimeInterval startupTime;

@end

@implementation FSAPMManager

#pragma mark - Life Cycle
/**
 单例对象

 @return FSAPMManager
 */
+ (FSAPMManager *)sharedInstance {
    static FSAPMManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化
 
 @return FSNetworkMonitor
 */
- (instancetype)init {
    if (self = [super init]) {
        _startupTime = [[[NSUserDefaults standardUserDefaults] objectForKey:kFSAPMNotification_startupTime] doubleValue];
    }
    return self;
}

#pragma mark - Public Method
/**
 开启管理
 */
- (void)start {
    FSSystemMonitor *system = [FSSystemMonitor sharedInstance];
    [system start];
    [system addDelegate:self];
    
    FSFPSMonitor *fps = [FSFPSMonitor sharedInstance];
    [fps start];
    [fps addDelegate:self];
    
    FSBatteryMonitor *battery = [FSBatteryMonitor sharedInstance];
    [battery start];
    [battery addDelegate:self];
    
    FSANRMonitor *anr = [FSANRMonitor sharedInstance];
    [anr start];
    [anr addDelegate:self];
    
    FSCrashMonitor *crash = [FSCrashMonitor sharedInstance];
    [crash start];
    [crash addDelegate:self];
    
    FSBayMaxProtector *bayMax = [FSBayMaxProtector sharedInstance];
    [bayMax configBayMaxProtectorType:FSProtectorAll];
    [bayMax start];
    [bayMax addDelegate:self];
    
    FSNetworkMonitor *network = [FSNetworkMonitor sharedInstance];
    [network start];
    [network addDelegate:self];
    
    FSAPMHttpDNS *httpDNS = [FSAPMHttpDNS sharedInstance];
    [httpDNS addDelegate:self];
}

/**
 关闭管理
 */
- (void)stop {
    [[FSSystemMonitor sharedInstance] stop];
    [[FSFPSMonitor sharedInstance] stop];
    [[FSBatteryMonitor sharedInstance] stop];
    [[FSANRMonitor sharedInstance] stop];
    [[FSCrashMonitor sharedInstance] stop];
    [[FSBayMaxProtector sharedInstance] stop];
    [[FSNetworkMonitor sharedInstance] stop];
    
    FSAPMHttpDNS *httpDNS = [FSAPMHttpDNS sharedInstance];
    [httpDNS removeDelegate:self];
}

#pragma mark - Private Method

#pragma mark - FSFPSMonitorDelegate
/**
 FPS 更新回调
 
 @param FPSMoitor 监控对象
 @param fps 刷新率
 */
- (void)FPSMoitor:(FSFPSMonitor *)FPSMoitor didUpdateFPS:(float)fps {
    
}

#pragma mark - FSBatteryMonitorDelegate
/**
 电池更新回调
 
 @param batteryMoitor 监控对象
 @param battery 电池信息
 */
- (void)batteryMoitor:(FSBatteryMonitor *)batteryMoitor didUpdateBattery:(FSBatteryInfo *)battery {
    
}

#pragma mark - FSANRMonitorDelegate
/**
 卡顿回调
 
 @param ANRMonitor 卡顿对象
 @param ANRInfo 卡顿日志
 */
- (void)ANRMonitor:(FSANRMonitor *)ANRMonitor didRecievedANRInfo:(FSANRInfo *)ANRInfo {
    
}

#pragma mark - FSCrashMonitorDelegate
/**
 闪退回调
 
 @param crashMonitor 闪退监控对象
 @param exceptionInfo 闪退日志
 */
- (void)crashMonitor:(FSCrashMonitor *)crashMonitor didCatchExceptionInfo:(FSCrashInfo *)exceptionInfo {
    
}

#pragma mark - FSBayMaxProtectorDelegate
/**
 捕捉到防护 Crash 日志回调
 
 @param bayMaxProtector 返回对象
 @param crashInfo 异常对象
 */
- (void)bayMaxProtector:(FSBayMaxProtector *)bayMaxProtector handleCrashInfo:(FSBayMaxCrashInfo *)crashInfo {
    
}

#pragma mark - FSAPMHttpDNSDelegate
/**
 上报失效域名
 
 @param url 失败域名地址
 @param count 失败次数
 */
- (void)reportDNSFailedUrl:(NSString *)url withFailedCount:(int64_t)count {
    
}

#pragma mark - FSNetworkMonitorDelegate
/**
 网络监控回调
 
 @param monitor 监控对象
 @param networkInfo 流量数据
 */
- (void)networkMonitor:(FSNetworkMonitor *)monitor didCatchNetworkInfo:(FSNetworkInfo *)networkInfo {
    
}

#pragma mark - FSSystemMonitorDelegate
/**
 系统监控已回调
 
 @param systemMonitor 系统监控
 */
- (void)systemMonitorDidUpdateUsage:(FSSystemMonitor *)systemMonitor {
    
}

/**
 CPU 使用情况回调
 
 @param systemMonitor 系统监控
 @param app_cpu_usage 应用 CPU 使用情况
 @param system_cpu_usage 系统 CPU 使用情况
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateAppCPUUsage:(fs_app_cpu_usage)app_cpu_usage systemCPUUsage:(fs_system_cpu_usage)system_cpu_usage {
    
}

/**
 RAM 使用情况回调
 
 @param systemMonitor 系统监控
 @param app_ram_usage 应用 RAM 使用情况
 @param system_ram_usage 系统 RAM 使用情况
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateAppRamUsage:(unsigned long long)app_ram_usage systemRamUsage:(fs_system_ram_usage)system_ram_usage {
    
}

/**
 磁盘 使用情况回调
 
 @param systemMonitor 系统监控
 @param disk_used_size 磁盘使用大小
 @param disk_free_size 磁盘剩余大小
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdatetDiskUsedSize:(unsigned long long)disk_used_size diskFreeSize:(unsigned long long)disk_free_size {
    
}

/**
 网络流量监控
 
 @param systemMonitor 系统监控
 @param sent 上行 byte/timeInterval
 @param received received 下行 byte/timeInterval
 @param total 流量结构体
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateNetworkFlowSent:(unsigned int)sent received:(unsigned int)received total:(fs_flow_IOBytes)total {
    
}

/**
 网络状态更新
 "无网络"、"蜂窝流量"、"Wifi"
 
 @param systemMonitor 系统监控
 @param state 网络状态
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateNetworkState:(NSString *)state {
    
}

/**
 fps 刷新率
 
 @param systemMonitor 系统监控
 @param fps 刷新率
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateFPS:(CGFloat)fps {
    
}

/**
 电池状态更新
 
 @param systemMonitor 系统监控
 @param battery 电池实体类
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateBattery:(FSBatteryInfo *)battery {
    
}

@end
