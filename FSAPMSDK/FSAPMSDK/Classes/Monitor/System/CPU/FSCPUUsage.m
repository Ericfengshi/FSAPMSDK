//
//  FSCPUUsage.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSCPUUsage.h"
#import "FSHardcodeDeviceInfo.h"
#import <mach/mach.h>
#import <sys/sysctl.h>
#import <mach-o/arch.h>

@implementation FSCPUUsage

#pragma mark - Public Methods
/**
 APP 使用 CPU 情况
 
 @return fs_app_cpu_usage
 */
+ (fs_app_cpu_usage)getAppCPUUsageStruct {
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count = TASK_INFO_MAX;
    fs_app_cpu_usage app_cpu_usage = {0, 0, 0};
    
    // mach_task_self 当前应用所在进程
    kern_return_t kr = task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return app_cpu_usage;
    }
    
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    thread_basic_info_t    basic_info_th;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return app_cpu_usage;
    }
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    // for each thread
    for (int idx = 0; idx < (int)thread_count; idx++) {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[idx], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return app_cpu_usage;
        }
        basic_info_th = (thread_basic_info_t)thinfo;
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            app_cpu_usage.user_time += basic_info_th->user_time.seconds;
            app_cpu_usage.system_time += basic_info_th->system_time.seconds;
            app_cpu_usage.cpu_usage += basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100;
        }
    }
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    return app_cpu_usage;
}

/**
 APP CPU 使用率
 
 @return float 获取失败返回 0
 */
+ (float)getAppCPUUsage {
    fs_app_cpu_usage app_cpu_usage = [self getAppCPUUsageStruct];
    return app_cpu_usage.cpu_usage;
}

/**
 系统使用 CPU 情况
 
 @return fs_system_cpu_usage
 */
+ (fs_system_cpu_usage)getSystemCPUUsageStruct {
    mach_msg_type_number_t count = HOST_CPU_LOAD_INFO_COUNT;
    kern_return_t kr;
    static host_cpu_load_info_data_t pre_cpu_load_info;
    host_cpu_load_info_data_t cpu_load_info;
    fs_system_cpu_usage system_cpu_usage = {0, 0, 0, 0, 0};
    
    kr = host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, (host_info_t)&cpu_load_info, &count);
    if (kr != KERN_SUCCESS) {
        return system_cpu_usage;
    }
    
    natural_t user_cpu_differ = cpu_load_info.cpu_ticks[CPU_STATE_USER] - pre_cpu_load_info.cpu_ticks[CPU_STATE_USER];
    natural_t system_cpu_differ = cpu_load_info.cpu_ticks[CPU_STATE_SYSTEM] - pre_cpu_load_info.cpu_ticks[CPU_STATE_SYSTEM];
    natural_t idle_cpu_differ = cpu_load_info.cpu_ticks[CPU_STATE_IDLE] - pre_cpu_load_info.cpu_ticks[CPU_STATE_IDLE];
    natural_t nice_cpu_differ = cpu_load_info.cpu_ticks[CPU_STATE_NICE] - pre_cpu_load_info.cpu_ticks[CPU_STATE_NICE];
    
    pre_cpu_load_info = cpu_load_info;
    
    natural_t total_cpu = user_cpu_differ + system_cpu_differ + idle_cpu_differ + nice_cpu_differ;
    system_cpu_usage.user = 100.0 * user_cpu_differ / total_cpu;
    system_cpu_usage.system = 100.0 * system_cpu_differ / total_cpu;
    system_cpu_usage.nice = 100.0 * nice_cpu_differ / total_cpu;
    system_cpu_usage.idle = 100.0 * idle_cpu_differ / total_cpu;
    system_cpu_usage.total = system_cpu_usage.user + system_cpu_usage.system + system_cpu_usage.nice;
    return system_cpu_usage;
}

/**
 系统 CPU 使用率
 
 @return float 获取失败返回 0
 */
+ (float)getSystemCPUUsage {
    fs_system_cpu_usage  system_cpu_usage = [self getSystemCPUUsageStruct];
    return system_cpu_usage.total;
}

/**
 CPU 内核数
 
 @return NSInteger
 */
+ (NSInteger)getCPUCoreNumber {
    return [NSProcessInfo processInfo].activeProcessorCount;
}

/**
 CPU 频率
 
 @return NSUInteger
 */
+ (NSUInteger)getCPUFrequency {
    FSHardcodeDeviceInfo *deviceInfo = [FSHardcodeDeviceInfo machineHardcodedDeviceInfo];
    NSInteger CPUFrequency = [deviceInfo getCPUFrequency];
    return CPUFrequency;
}

/**
 CPU 架构 (processor architecture)
 
 @return NSString
 */
+ (NSString *)getCPUArchitectureString {
    return [NSString stringWithUTF8String:NXGetLocalArchInfo()->description];
}

#pragma mark - Private Methods
+ (NSUInteger)p_getSysInfo:(uint)typeSpecifier {
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger)results;
}

@end
