//
//  FSRAMUsage.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSRAMUsage.h"
#import <mach/mach.h>
#import <sys/sysctl.h>
#import <mach-o/arch.h>

@implementation FSRAMUsage

/**
 获取APP内存使用量
 
 @return byte
 */
+ (unsigned long long)getAppRAMUsage {
    struct mach_task_basic_info info;
    mach_msg_type_number_t count = MACH_TASK_BASIC_INFO_COUNT;
    
    kern_return_t kr = task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)&info, &count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    return info.resident_size;
}

/**
 获取系统内存使用量
 
 @return byte
 */
+ (unsigned long long)getSystemRAMUsage {
    fs_system_ram_usage system_ram_usage = [self getSystemRamUsageStruct];
    return system_ram_usage.used_size;
}

/**
 获取系统可用内存量
 
 @return byte
 */
+ (unsigned long long)getSystemRAMAvailable {
    fs_system_ram_usage system_ram_usage = [self getSystemRamUsageStruct];
    return system_ram_usage.available_size;
}

/**
 获取系统内存总量
 
 @return byte
 */
+ (unsigned long long)getSystemRAMTotal {
    return [NSProcessInfo processInfo].physicalMemory;
}

/**
 获取内存使用结构体
 
 @return fs_system_ram_usage
 */
+ (fs_system_ram_usage)getSystemRamUsageStruct {
    vm_statistics64_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kr = host_statistics(mach_host_self(),
                                       HOST_VM_INFO,
                                       (host_info_t)&vmStats,
                                       &infoCount);
    
    fs_system_ram_usage system_memory_usage = {0, 0, 0};
    if (kr != KERN_SUCCESS) {
        return system_memory_usage;
    }
    system_memory_usage.used_size = (vmStats.active_count + vmStats.wire_count + vmStats.inactive_count) * vm_kernel_page_size;
    system_memory_usage.available_size = (vmStats.free_count) * vm_kernel_page_size;
    system_memory_usage.total_size = [NSProcessInfo processInfo].physicalMemory;
    return system_memory_usage;
}

@end
