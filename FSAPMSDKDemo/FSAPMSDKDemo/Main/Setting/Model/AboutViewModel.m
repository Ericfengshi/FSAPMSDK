//
//  AboutViewModel.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "AboutViewModel.h"
#import <FSAPMSDK/FSAPMSDK.h>

#pragma mark - static const/#define
NSString *const kAboutViewModelInfoKey   = @"infoKey";
NSString *const kAboutViewModelInfoValue = @"infoValue";

@interface AboutViewModel ()

/**
 设备相关信息
 */
@property (nonatomic, strong, readwrite) NSMutableArray *sysInfoArray;

@end

@implementation AboutViewModel

#pragma mark - Public Methods
- (void)loadData {
    [self sysInfoArray];
}

#pragma mark - Getters and Setters
- (NSMutableArray *)sysInfoArray {
    if (!_sysInfoArray) {
        NSMutableArray *sysInfoArray = [NSMutableArray array];
        
        const NSString *deviceName = [FSDeviceInfo getDeviceName];
        NSDictionary *dict1 = @{
                                kAboutViewModelInfoKey   : @"Device Name",
                                kAboutViewModelInfoValue : deviceName
                                };
        [sysInfoArray addObject:dict1];
        
        NSString *deviceModel = [FSDeviceInfo getDeviceModel];
        NSDictionary *dict2 = @{
                                kAboutViewModelInfoKey   : @"Device Model",
                                kAboutViewModelInfoValue : deviceModel
                                };
        [sysInfoArray addObject:dict2];
        
        NSString *iPhoneName = [FSDeviceInfo getIPhoneName];
        NSDictionary *dict3 = @{
                                kAboutViewModelInfoKey   : @"iPhone Name",
                                kAboutViewModelInfoValue : iPhoneName
                                };
        [sysInfoArray addObject:dict3];
        
        NSString *appVerion = [FSDeviceInfo getBundleShortVersionString];
        NSDictionary *dict4 = @{
                                kAboutViewModelInfoKey   : @"App Verion",
                                kAboutViewModelInfoValue : appVerion
                                };
        [sysInfoArray addObject:dict4];
        
        NSUInteger batteryCapacity = [FSDeviceInfo getBatteryCapacity];
        NSDictionary *dict5 = @{
                                kAboutViewModelInfoKey   : @"Battery Capacity",
                                kAboutViewModelInfoValue : [@(batteryCapacity) stringValue]
                                };
        [sysInfoArray addObject:dict5];
        
        NSString *systemName = [FSDeviceInfo getSystemName];
        NSDictionary *dict6 = @{
                                kAboutViewModelInfoKey   : @"System Name",
                                kAboutViewModelInfoValue : systemName
                                };
        [sysInfoArray addObject:dict6];
        
        NSString *systemVersion = [FSDeviceInfo getSystemVersion];
        NSDictionary *dict7 = @{
                                kAboutViewModelInfoKey   : @"System Version",
                                kAboutViewModelInfoValue : systemVersion
                                };
        [sysInfoArray addObject:dict7];
        
        NSString *screenPixel = [FSDeviceInfo getScreenPixel];
        NSDictionary *dict8 = @{
                                kAboutViewModelInfoKey   : @"Screen Pixel",
                                kAboutViewModelInfoValue : screenPixel
                                };
        [sysInfoArray addObject:dict8];
        
        float screenSize = [FSDeviceInfo getScreenSize];
        NSDictionary *dict9 = @{
                                kAboutViewModelInfoKey   : @"Screen Size",
                                kAboutViewModelInfoValue : [@(screenSize) stringValue]
                                };
        [sysInfoArray addObject:dict9];
        
        NSUInteger CPUFrequency = [FSDeviceInfo getCPUFrequency];
        NSDictionary *dict10 = @{
                                 kAboutViewModelInfoKey   : @"CPU Frequency",
                                 kAboutViewModelInfoValue : [NSString stringWithFormat:@"%lu Hz", CPUFrequency]
                                 };
        [sysInfoArray addObject:dict10];
        
        _sysInfoArray = sysInfoArray;
    }
    return _sysInfoArray;
}

@end
