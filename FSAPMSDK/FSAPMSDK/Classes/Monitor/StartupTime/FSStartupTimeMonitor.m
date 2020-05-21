//
//  FSStartTimeMonitor.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/24.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSStartupTimeMonitor.h"
#import <mach/mach_time.h>

static uint64_t loadTime;
static uint64_t applicationRespondedTime = -1;
static mach_timebase_info_data_t timebaseInfo;

static inline NSTimeInterval MachTimeToSeconds(uint64_t machTime) {
    return ((machTime / 1e9) * timebaseInfo.numer) / timebaseInfo.denom;
}

@implementation FSStartupTimeMonitor

+ (void)load {
    loadTime = mach_absolute_time();
    mach_timebase_info(&timebaseInfo);
    
    @autoreleasepool {
        __block id<NSObject> obs;
        obs = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
                   dispatch_async(dispatch_get_main_queue(), ^{
                       applicationRespondedTime = mach_absolute_time();
                       NSTimeInterval startupTime = MachTimeToSeconds(applicationRespondedTime - loadTime);
                       // userDefaults 写入
                       [[NSUserDefaults standardUserDefaults] setObject:@(startupTime) forKey:kFSAPMNotification_startupTime];
                       
                       FSAPMLogInfo(@"startupTime: %f seconds", startupTime);
                   });
                   [[NSNotificationCenter defaultCenter] removeObserver:obs];
                }];
    }
}

@end
