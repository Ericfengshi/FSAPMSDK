//
//  FSBatteryInfo.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSBatteryInfo.h"
#import "FSHardcodeDeviceInfo.h"

@implementation FSBatteryInfo

#pragma mark - Life Cycle
/**
 电池状态初始化
 
 @param batteryLevel 当前电池级别 0 .. 1.0
 @param status 电池状态
 @return FSBatteryInfo
 */
- (instancetype)initWithBatteryLevel:(CGFloat)batteryLevel
                              status:(NSString *)status {
    if (self = [super init]) {
        FSHardcodeDeviceInfo *deviceInfo = [FSHardcodeDeviceInfo machineHardcodedDeviceInfo];
        NSInteger totalCapacity = [deviceInfo getBatteryCapacity];
        CGFloat batteryVoltage = [deviceInfo getBatteryVoltage];
        int currentCapacity = totalCapacity * batteryLevel;
        int currentPercent = batteryLevel * 100;
        
        _totalCapacity = totalCapacity;
        _currentCapacity = currentCapacity;
        _currentPercent = currentPercent;
        _voltage = batteryVoltage;
        _status = status;
    }
    return self;
}

@end
