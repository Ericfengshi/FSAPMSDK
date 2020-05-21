//
//  SystemMonitorViewModel.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SystemMonitorViewModel.h"
#import <FSAPMSDK/FSAPMSDK.h>

#pragma mark - static const/#define
NSString *const kSystemMonitorViewModelInfoKey   = @"infoKey";
NSString *const kSystemMonitorViewModelInfoValue = @"infoValue";

#define iS_KB_Unit(x) [NSString stringWithFormat:@"%.2fkB", (x/1024.0)]
#define iS_KB_Speed_Unit(x) [NSString stringWithFormat:@"%.2fkB/s", (x/1024.0)]
#define iS_MB_Unit(x) [NSString stringWithFormat:@"%.2fMB", (x/1024.0/1024.0)]
#define iS_GB_Unit(x) [NSString stringWithFormat:@"%.2fGB", (x/1024.0/1024.0/1024.0)]
#define iS_Percent_Unit(x) [NSString stringWithFormat:@"%.2f%%", x]
#define iS_MA_Unit(x) [NSString stringWithFormat:@"%.0fMA", (x/1.0)]

@interface SystemMonitorViewModel ()<FSSystemMonitorDelegate, FSFPSMonitorDelegate, FSBatteryMonitorDelegate>

/**
 委托回调对象集合
 */
@property (nonatomic, strong) NSHashTable *hashTable;

/**
 监控类型
 */
@property (nonatomic, strong, readwrite) NSMutableArray *sysInfoArray;

@end

@implementation SystemMonitorViewModel

#pragma mark - Life Cycle
/**
 单例对象
 
 @return SystemMonitorViewModel
 */
+ (instancetype)sharedInstance {
    static SystemMonitorViewModel *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化

 @return SystemMonitorViewModel
 */
- (instancetype)init {
    if (self = [super init]) {
        [[FSSystemMonitor sharedInstance] addDelegate:self];
        [[FSFPSMonitor sharedInstance] addDelegate:self];
        [[FSBatteryMonitor sharedInstance] addDelegate:self];
    }
    return self;
}

/**
 对象释放
 */
- (void)dealloc {
    [[FSSystemMonitor sharedInstance] removeDelegate:self];
    [[FSFPSMonitor sharedInstance] removeDelegate:self];
    [[FSBatteryMonitor sharedInstance] removeDelegate:self];
    [self p_removeAllDelegates];
}

#pragma mark - Public Methods

#pragma mark - FSBatteryMonitorDelegate
/**
 电池更新回调
 
 @param batteryMoitor 监控对象
 @param battery 电池信息
 */
- (void)batteryMoitor:(FSBatteryMonitor *)batteryMoitor didUpdateBattery:(FSBatteryInfo *)battery {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"Total Capacity",
                           kSystemMonitorViewModelInfoValue : iS_MA_Unit(battery.totalCapacity),
                           }];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"Current Capacity",
                           kSystemMonitorViewModelInfoValue : iS_MA_Unit(battery.currentCapacity),
                           }];
    NSString *currentPercent = battery.currentPercent == -100 ? @"-1" : iS_Percent_Unit((float)battery.currentPercent);
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"Current Percent",
                           kSystemMonitorViewModelInfoValue : currentPercent,
                           }];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"Status",
                           kSystemMonitorViewModelInfoValue : battery.status,
                           }];
    for (id<SystemMonitorViewModelDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(updateMonitorType:forData:)]) {
            [delegate updateMonitorType:SystemMonitorBatteryType forData:dataArray];
        }
    }
}

#pragma mark - FSFPSMonitorDelegate
/**
 FPS 更新回调
 
 @param FPSMoitor 监控对象
 @param fps 刷新率
 */
- (void)FPSMoitor:(FSFPSMonitor *)FPSMoitor didUpdateFPS:(float)fps {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"FPS",
                           kSystemMonitorViewModelInfoValue : [@((int)fps) stringValue],
                           }];
    for (id<SystemMonitorViewModelDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(updateMonitorType:forData:)]) {
            [delegate updateMonitorType:SystemMonitorFPSType forData:dataArray];
        }
    }
}

#pragma mark - FSSystemMonitorDelegate
/**
 CPU 使用情况回调
 
 @param systemMonitor 系统监控
 @param app_cpu_usage 应用 CPU 使用情况
 @param system_cpu_usage 系统 CPU 使用情况
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateAppCPUUsage:(fs_app_cpu_usage)app_cpu_usage systemCPUUsage:(fs_system_cpu_usage)system_cpu_usage {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"APP Use Percent",
                           kSystemMonitorViewModelInfoValue : iS_Percent_Unit(app_cpu_usage.cpu_usage),
                           }];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"System Use Percent",
                           kSystemMonitorViewModelInfoValue : iS_Percent_Unit(system_cpu_usage.total),
                           }];
    for (id<SystemMonitorViewModelDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(updateMonitorType:forData:)]) {
            [delegate updateMonitorType:SystemMonitorCPUType forData:dataArray];
        }
    }
}

/**
 RAM 使用情况回调
 
 @param systemMonitor 系统监控
 @param app_ram_usage 应用 RAM 使用情况
 @param system_ram_usage 系统 RAM 使用情况
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateAppRamUsage:(unsigned long long)app_ram_usage systemRamUsage:(fs_system_ram_usage)system_ram_usage {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"APP Use",
                           kSystemMonitorViewModelInfoValue : iS_MB_Unit(app_ram_usage),
                           }];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"System Used",
                           kSystemMonitorViewModelInfoValue : iS_GB_Unit(system_ram_usage.used_size),
                           }];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"System Free",
                           kSystemMonitorViewModelInfoValue : iS_GB_Unit(system_ram_usage.available_size),
                           }];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"System Total",
                           kSystemMonitorViewModelInfoValue : iS_GB_Unit(system_ram_usage.total_size),
                           }];
    for (id<SystemMonitorViewModelDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(updateMonitorType:forData:)]) {
            [delegate updateMonitorType:SystemMonitorRAMType forData:dataArray];
        }
    }
}

/**
 磁盘 使用情况回调
 
 @param systemMonitor 系统监控
 @param disk_used_size 磁盘使用大小
 @param disk_free_size 磁盘剩余大小
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdatetDiskUsedSize:(unsigned long long)disk_used_size diskFreeSize:(unsigned long long)disk_free_size {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"Use size",
                           kSystemMonitorViewModelInfoValue : iS_GB_Unit(disk_used_size),
                           }];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"Free size",
                           kSystemMonitorViewModelInfoValue : iS_GB_Unit(disk_free_size),
                           }];
    for (id<SystemMonitorViewModelDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(updateMonitorType:forData:)]) {
            [delegate updateMonitorType:SystemMonitorDiskType forData:dataArray];
        }
    }
}

/**
 网络流量监控
 
 @param systemMonitor 系统监控
 @param sent 上行 byte/timeInterval
 @param received received 下行 byte/timeInterval
 @param total 流量结构体
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateNetworkFlowSent:(unsigned int)sent received:(unsigned int)received total:(fs_flow_IOBytes)total {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"Sent spped",
                           kSystemMonitorViewModelInfoValue : iS_KB_Speed_Unit(sent),
                           }];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"Recieve spped",
                           kSystemMonitorViewModelInfoValue : iS_KB_Speed_Unit(received),
                           }];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"Send total",
                           kSystemMonitorViewModelInfoValue : iS_MB_Unit(total.total_sent),
                           }];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"Recieve total",
                           kSystemMonitorViewModelInfoValue : iS_MB_Unit(total.total_received),
                           }];
    for (id<SystemMonitorViewModelDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(updateMonitorType:forData:)]) {
            [delegate updateMonitorType:SystemMonitorNetworkFlowType forData:dataArray];
        }
    }
}

/**
 网络状态更新
 "无网络"、"蜂窝流量"、"Wifi"
 
 @param systemMonitor 系统监控
 @param state 网络状态
 */
- (void)systemMonitor:(FSSystemMonitor *)systemMonitor didUpdateNetworkState:(NSString *)state {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:@{kSystemMonitorViewModelInfoKey : @"State",
                           kSystemMonitorViewModelInfoValue : state,
                           }];
    for (id<SystemMonitorViewModelDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(updateMonitorType:forData:)]) {
            [delegate updateMonitorType:SystemMonitorNetworkStateType forData:dataArray];
        }
    }
}

#pragma mark - Public Methods
/**
 加载列表数据
 */
- (void)loadData {
    [self sysInfoArray];
}

/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<SystemMonitorViewModelDelegate>)delegate {
    [self.hashTable addObject:delegate];
}

/**
 委托对象去除监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<SystemMonitorViewModelDelegate>)delegate {
    if ([self.hashTable containsObject:delegate]) {
        [self.hashTable removeObject:delegate];
    }
}

#pragma mark - Private Method
/**
 关闭所有委托对象
 */
- (void)p_removeAllDelegates {
    [self.hashTable removeAllObjects];
}

#pragma mark - Getters and Setters
/**
 列表数据

 @return NSMutableArray
 */
- (NSMutableArray *)sysInfoArray {
    if (!_sysInfoArray) {
        NSMutableArray *sysInfoArray = [NSMutableArray array];
        
        NSDictionary *dict1 = @{
                                kSystemMonitorViewModelInfoKey   : @(SystemMonitorCPUType),
                                kSystemMonitorViewModelInfoValue : @"CPU"
                                };
        [sysInfoArray addObject:dict1];
        
        NSDictionary *dict2 = @{
                                kSystemMonitorViewModelInfoKey   : @(SystemMonitorRAMType),
                                kSystemMonitorViewModelInfoValue : @"Memory"
                                };
        [sysInfoArray addObject:dict2];
        
        NSDictionary *dict3 = @{
                                kSystemMonitorViewModelInfoKey   : @(SystemMonitorDiskType),
                                kSystemMonitorViewModelInfoValue : @"Disk"
                                };
        [sysInfoArray addObject:dict3];
        
        NSDictionary *dict4 = @{
                                kSystemMonitorViewModelInfoKey   : @(SystemMonitorBatteryType),
                                kSystemMonitorViewModelInfoValue : @"Battery"
                                };
        [sysInfoArray addObject:dict4];
        
        NSDictionary *dict5 = @{
                                kSystemMonitorViewModelInfoKey   : @(SystemMonitorNetworkFlowType),
                                kSystemMonitorViewModelInfoValue : @"Network Flow"
                                };
        [sysInfoArray addObject:dict5];
        
        NSDictionary *dict6 = @{
                                kSystemMonitorViewModelInfoKey   : @(SystemMonitorNetworkStateType),
                                kSystemMonitorViewModelInfoValue : @"Network State"
                                };
        [sysInfoArray addObject:dict6];
        
        NSDictionary *dict7 = @{
                                kSystemMonitorViewModelInfoKey   : @(SystemMonitorFPSType),
                                kSystemMonitorViewModelInfoValue : @"FPS"
                                };
        [sysInfoArray addObject:dict7];
        
        _sysInfoArray = sysInfoArray;
    }
    return _sysInfoArray;
}

/**
 委托回调对象集合
 
 @return NSHashTable
 */
- (NSHashTable *)hashTable {
    if (!_hashTable) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    return _hashTable;
}

@end
