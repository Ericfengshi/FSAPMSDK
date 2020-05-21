//
//  FSHardcodeDeviceInfo.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/23.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSHardcodeDeviceInfo.h"
#import "sys/utsname.h"

/**
 iPhone、iPod、iPad 型号
 */
typedef NS_ENUM(NSInteger, FSHardcodedDeviceEnum) {
    /* iPhone */
    // iPhone 2G
    iPhone1_1 = 1,
    
    // iPhone 3G
    iPhone1_2,
    
    // iPhone 3GS
    iPhone2_1,
    
    // iPhone 4
    iPhone3_1,
    iPhone3_2,
    iPhone3_3,
    
    // iPhone 4S
    iPhone4_1,
    
    // iPhone 5
    iPhone5_1,
    iPhone5_2,
    
    // iPhone 5C
    iPhone5_3,
    iPhone5_4,
    
    // iPhone 5S
    iPhone6_1,
    iPhone6_2,
    
    // iPhone 6 Plus
    iPhone7_1,
    
    // iPhone 6
    iPhone7_2,
    
    // iPhone 6s
    iPhone8_1,
    
    // iPhone 6s Plus
    iPhone8_2,
    
    // iPhone SE
    iPhone8_4,
    
    // iPhone 7
    iPhone9_1,
    // iPhone 7 Plus
    iPhone9_2,
    // iPhone 7
    iPhone9_3,
    // iPhone 7 Plus
    iPhone9_4,
    
    // iPhone 8
    iPhone10_1,
    // iPhone 8 Plus
    iPhone10_2,
    // iPhone X
    iPhone10_3,
    // iPhone 8
    iPhone10_4,
    // iPhone 8 Plus
    iPhone10_5,
    // iPhone X
    iPhone10_6,
    
    // iPhone XS
    iPhone11_2,
    // iPhone XS Max
    iPhone11_4,
    iPhone11_6,
    // iPhone XR
    iPhone11_8,

    // iPhone 11
    iPhone12_1,
    // iPhone 11 Pro
    iPhone12_3,
    // iPhone 11 Pro Max
    iPhone12_5,
    // iPhone SE (2020)
    iPhone12_8,
    
    /* iPod */
    iPod1_1,
    iPod2_1,
    iPod3_1,
    iPod4_1,
    iPod5_1,
    // iPod 6
    iPod7_1,
    
    // iPod 7
    iPod9_1,
    
    /* iPad */
    // iPad
    iPad1_1,
    
    // iPad 2
    iPad2_1,
    iPad2_2,
    iPad2_3,
    iPad2_4,
    
    // iPad mini
    iPad2_5,
    iPad2_6,
    iPad2_7,
    
    // iPad (3rd generation)
    iPad3_1,
    iPad3_2,
    iPad3_3,
    
    // iPad (4th generation)
    iPad3_4,
    iPad3_5,
    iPad3_6,
    
    // iPad Air
    iPad4_1,
    iPad4_2,
    iPad4_3,
    
    // iPad mini 2
    iPad4_4,
    iPad4_5,
    iPad4_6,
    
    // iPad mini 3
    iPad4_7,
    iPad4_8,
    iPad4_9,
    
    // iPad mini 4
    iPad5_1,
    iPad5_2,
    
    // iPad Air 2
    iPad5_3,
    iPad5_4,
    
    // iPad Pro (9.7-inch)
    iPad6_3,
    iPad6_4,
    
    // iPad Pro (12.9-inch)
    iPad6_7,
    iPad6_8,
    
    // iPad (5th generation)
    iPad6_11,
    iPad6_12,
    
    // iPad Pro (12.9-inch) (2nd generation)
    iPad7_1,
    iPad7_2,
    
    // iPad Pro (10.5-inch)
    iPad7_3,
    iPad7_4,
    
    // iPad (6th generation)
    iPad7_5,
    iPad7_6,
    
    // iPad (7th generation)
    iPad7_11,
    iPad7_12,
    
    // iPad Pro (11-inch)
    iPad8_1,
    iPad8_2,
    iPad8_3,
    iPad8_4,
    
    // iPad Pro (12.9-inch) (3rd generation)
    iPad8_5,
    iPad8_6,
    iPad8_7,
    iPad8_8,
    
    // iPad Pro (11-inch) (2nd generation)
    iPad8_9,
    iPad8_10,
    
    // iPad Pro (12.9-inch) (4th generation)
    iPad8_11,
    iPad8_12,
    
    iUnknown
};

/**
 设备名称

 @param hardcodedDevice 硬件型号
 @return NSString
 */
static NSString * const HardcodedDeviceName(FSHardcodedDeviceEnum hardcodedDevice) {
    switch (hardcodedDevice) {
        // iPhone
        case iPhone1_1: {
            return @"iPhone 2G";
        }
        case iPhone1_2: {
            return @"iPhone 3G";
        }
        case iPhone2_1: {
            return @"iPhone 3GS";
        }
        case iPhone3_1:
        case iPhone3_2: {
            return @"iPhone 4";
        }
        case iPhone3_3: {
            return @"iPhone 4 (CDMA)";
        }
        case iPhone4_1: {
            return @"iPhone 4S";
        }
        case iPhone5_1: {
            return @"iPhone 5";
        }
        case iPhone5_2: {
            return @"iPhone 5 (CDMA GSM)";
        }
        case iPhone5_3: {
            return @"iPhone 5C";
        }
        case iPhone5_4: {
            return @"iPhone 5C (CDMA GSM)";
        }
        case iPhone6_1: {
            return @"iPhone 5S";
        }
        case iPhone6_2: {
            return @"iPhone 5S (CDMA GSM)";
        }
        case iPhone7_1: {
            return @"iPhone 6 Plus";
        }
        case iPhone7_2: {
            return @"iPhone 6";
        }
        case iPhone8_1: {
            return @"iPhone 6S";
        }
        case iPhone8_2: {
            return @"iPhone 6S Plus";
        }
        case iPhone8_4: {
            return @"iPhone SE";
        }
        case iPhone9_1: {
            return @"iPhone 7";
        }
        case iPhone9_2: {
            return @"iPhone 7 Plus";
        }
        case iPhone9_3: {
            return @"iPhone 7 (GSM)";
        }
        case iPhone9_4: {
            return @"iPhone 7 Plus (GSM)";
        }
        case iPhone10_1: {
            return @"iPhone 8 (CN)";
        }
        case iPhone10_2: {
            return @"iPhone 8 Plus (CN)";
        }
        case iPhone10_3: {
            return @"iPhone X (CN)";
        }
        case iPhone10_4: {
            return @"iPhone 8";
        }
        case iPhone10_5: {
            return @"iPhone 8 Plus";
        }
        case iPhone10_6: {
            return @"iPhone X";
        }
        case iPhone11_2: {
            return @"iPhone XS";
        }
        case iPhone11_4: {
            return @"iPhone XS Max";
        }
        case iPhone11_6: {
            return @"iPhone XS Max (CN)";
        }
        case iPhone11_8: {
            return @"iPhone XR";
        }
        case iPhone12_1: {
            return @"iPhone 11";
        }
        case iPhone12_3: {
            return @"iPhone 11 Pro";
        }
        case iPhone12_5: {
            return @"iPhone 11 Pro Max";
        }
        case iPhone12_8: {
            return @"iPhone SE (2020)";
        }
        // iPod
        case iPod1_1: {
            return @"iPod Touch";
        }
        case iPod2_1: {
            return @"iPod Touch 2";
        }
        case iPod3_1: {
            return @"iPod Touch 3";
        }
        case iPod4_1: {
            return @"iPod Touch 4";
        }
        case iPod5_1: {
            return @"iPod Touch 5";
        }
        case iPod7_1: {
            return @"iPod Touch 6";
        }
        case iPod9_1: {
            return @"iPod Touch 7";
        }
        // iPad
        case iPad1_1: {
            return @"iPad";
        }
        case iPad2_1: {
            return @"iPad 2 (Wifi)";
        }
        case iPad2_2:
        case iPad2_4: {
            return @"iPad 2";
        }
        case iPad2_3: {
            return @"iPad 2 (CDMA)";
        }
        case iPad2_5: {
            return @"iPad Mini (Wifi)";
        }
        case iPad2_6: {
            return @"iPad Mini";
        }
        case iPad2_7: {
            return @"iPad Mini (Wifi CDMA)";
        }
        case iPad3_1: {
            return @"iPad 3rd generation (Wifi)";
        }
        case iPad3_2: {
            return @"iPad 3rd generation (Wifi CDMA)";
        }
        case iPad3_3: {
            return @"iPad 3rd generation";
        }
        case iPad3_4: {
            return @"iPad 4th generation (Wifi)";
        }
        case iPad3_5: {
            return @"iPad 4th generation";
        }
        case iPad3_6: {
            return @"iPad 4th generation (GSM CDMA)";
        }
        case iPad4_1: {
            return @"iPad Air (Wifi)";
        }
        case iPad4_2: {
            return @"iPad Air (Wifi GSM)";
        }
        case iPad4_3: {
            return @"iPad Air (Wifi CDMA)";
        }
        case iPad4_4: {
            return @"iPad Mini 2 (Wifi)";
        }
        case iPad4_5: {
            return @"iPad Mini 2 (Wifi CDMA)";
        }
        case iPad4_6: {
            return @"iPad Mini 2 (Wifi Cellular CN)";
        }
        case iPad4_7: {
            return @"iPad Mini 3 (Wifi)";
        }
        case iPad4_8: {
            return @"iPad Mini 3 (Wifi Cellular)";
        }
        case iPad4_9: {
            return @"iPad Mini 3 (Wifi Cellular CN)";
        }
        case iPad5_1: {
            return @"iPad Mini 4 (Wifi)";
        }
        case iPad5_2: {
            return @"iPad Mini 4 (Wifi Cellular)";
        }
        case iPad5_3: {
            return @"iPad Air 2 (Wifi)";
        }
        case iPad5_4: {
            return @"iPad Air 2 (Wifi Cellular)";
        }
        case iPad6_3: {
            return @"iPad Pro 9.7-inch (Wifi)";
        }
        case iPad6_4: {
            return @"iPad Pro 9.7-inch (Wifi Cellular)";
        }
        case iPad6_7: {
            return @"iPad Pro 12.9-inch (Wifi)";
        }
        case iPad6_8: {
            return @"iPad Pro 12.9-inch (Wifi Cellular)";
        }
        case iPad6_11: {
            return @"iPad 5th generation (Wifi)";
        }
        case iPad6_12: {
            return @"iPad 5th generation (Wifi Cellular)";
        }
        case iPad7_1: {
            return @"iPad Pro 12.9-inch 2nd generation (Wifi)";
        }
        case iPad7_2: {
            return @"iPad Pro 12.9-inch 2nd generation (Wifi Cellular)";
        }
        case iPad7_3: {
            return @"iPad Pro 10.5-inch (Wifi)";
        }
        case iPad7_4: {
            return @"iPad Pro 10.5-inch (Wifi Cellular)";
        }
        case iPad7_5: {
            return @"iPad 6th generation (Wifi)";
        }
        case iPad7_6: {
            return @"iPad 6th generation (Wifi Cellular)";
        }
        case iPad7_11: {
            return @"iPad 7th generation (Wifi)";
        }
        case iPad7_12: {
            return @"iPad 7th generation (Wifi Cellular)";
        }
        case iPad8_1: {
            return @"iPad Pro 11-inch (Wifi)";
        }
        case iPad8_2: {
            return @"iPad Pro 11-inch (1TB Wifi)";
        }
        case iPad8_3: {
            return @"iPad Pro 11-inch (Wifi Cellular)";
        }
        case iPad8_4: {
            return @"iPad Pro 11-inch (1TB Wifi Cellular)";
        }
        case iPad8_5: {
            return @"iPad Pro 12.9-inch 3rd generation (Wifi)";
        }
        case iPad8_6: {
            return @"iPad Pro 12.9-inch 3rd generation (1TB Wifi)";
        }
        case iPad8_7: {
            return @"iPad Pro 12.9-inch 3rd generation (Wifi Cellular)";
        }
        case iPad8_8: {
            return @"iPad Pro 12.9-inch 3rd generation (1TB Wifi Cellular)";
        }
        case iPad8_9: {
            return @"iPad Pro 11-inch 2nd generation (Wifi)";
        }
        case iPad8_10: {
            return @"iPad Pro 11-inch 2nd generation (Wifi Cellular)";
        }
        case iPad8_11: {
            return @"iPad Pro 12.9--inch 4th generation (Wifi)";
        }
        case iPad8_12: {
            return @"iPad Pro 12.9--inch 4th generation (Wifi Cellular)";
        }
        default:
            return @"";
    }
};

/**
 CPU 频率
 
 @param hardcodedDevice 硬件型号
 @return NSUInteger Hz
 */
static const NSUInteger HardcodedDeviceCPUFrequency(FSHardcodedDeviceEnum hardcodedDevice) {
    switch (hardcodedDevice) {
        // iPhone
        case iPhone1_1: {
            return 412;
        }
        case iPhone1_2: {
            return 620;
        }
        case iPhone2_1: {
            return 600;
        }
        case iPhone3_1:
        case iPhone3_2:
        case iPhone3_3:
        case iPhone4_1: {
            return 800;
        }
        case iPhone5_1:
        case iPhone5_2: {
            return 1300;
        }
        case iPhone5_3:
        case iPhone5_4: {
            return 1000;
        }
        case iPhone6_1:
        case iPhone6_2: {
            return 1300;
        }
        case iPhone7_1:
        case iPhone7_2: {
            return 1400;
        }
        case iPhone8_1:
        case iPhone8_2:
        case iPhone8_4: {
            return 1850;
        }
        case iPhone9_1:
        case iPhone9_2:
        case iPhone9_3:
        case iPhone9_4: {
            return 2340;
        }
        case iPhone10_1:
        case iPhone10_2:
        case iPhone10_3:
        case iPhone10_4:
        case iPhone10_5:
        case iPhone10_6: {
            return 2390;
        }
        case iPhone11_2:
        case iPhone11_4:
        case iPhone11_6:
        case iPhone11_8: {
            return 2490;
        }
        case iPhone12_1:
        case iPhone12_3:
        case iPhone12_5:
        case iPhone12_8: {
            return 2650;
        }
        // iPod
        case iPod1_1: {
            return 400;
        }
        case iPod2_1: {
            return 533;
        }
        case iPod3_1: {
            return 600;
        }
        case iPod4_1: {
            return 800;
        }
        case iPod5_1: {
            return 1000;
        }
        case iPod7_1: {
            return 1100;
        }
        case iPod9_1: {
            return 2340;
        }
        // iPad
        case iPad1_1:
        case iPad2_1:
        case iPad2_2:
        case iPad2_4:
        case iPad2_3:
        case iPad2_5:
        case iPad2_6:
        case iPad2_7:
        case iPad3_1:
        case iPad3_2:
        case iPad3_3: {
            return 1000;
        }
        case iPad3_4:
        case iPad3_5:
        case iPad3_6:
        case iPad4_1:
        case iPad4_2:
        case iPad4_3: {
            return 1400;
        }
        case iPad4_4:
        case iPad4_5:
        case iPad4_6:
        case iPad4_7:
        case iPad4_8:
        case iPad4_9: {
            return 1300;
        }
        case iPad5_1:
        case iPad5_2:
        case iPad5_3:
        case iPad5_4: {
            return 1500;
        }
        case iPad6_3:
        case iPad6_4: {
            return 2160;
        }
        case iPad6_7:
        case iPad6_8: {
            return 2240;
        }
        case iPad6_11:
        case iPad6_12: {
            return 1850;
        }
        case iPad7_1:
        case iPad7_2:
        case iPad7_3:
        case iPad7_4: {
            return 2380;
        }
        case iPad7_5:
        case iPad7_6:
        case iPad7_11:
        case iPad7_12: {
            return 2310;
        }
        case iPad8_1:
        case iPad8_2:
        case iPad8_3:
        case iPad8_4:
        case iPad8_5:
        case iPad8_6:
        case iPad8_7:
        case iPad8_8:
        case iPad8_9:
        case iPad8_10:
        case iPad8_11:
        case iPad8_12: {
            return 2490;
        }
        default:
            return 0;
    }
};

/**
 CPU名称
 
 @param hardcodedDevice 硬件型号
 @return NSString
 */
static NSString * const HardcodedDeviceCPUName(FSHardcodedDeviceEnum hardcodedDevice) {
    switch (hardcodedDevice) {
        // iPhone
        case iPhone1_1:
        case iPhone1_2: {
            return @"S5L8900";
        }
        case iPhone2_1: {
            return @"S5L8920";
        }
        case iPhone3_1:
        case iPhone3_2:
        case iPhone3_3: {
            return @"Apple A4";
        }
        case iPhone4_1:
        case iPhone5_1:
        case iPhone5_2:
        case iPhone5_3:
        case iPhone5_4: {
            return @"Apple A6";
        }
        case iPhone6_1:
        case iPhone6_2: {
            return @"Apple A7";
        }
        case iPhone7_1:
        case iPhone7_2: {
            return @"Apple A8";
        }
        case iPhone8_1:
        case iPhone8_2:
        case iPhone8_4: {
            return @"Apple A9";
        }
        case iPhone9_1:
        case iPhone9_2:
        case iPhone9_3:
        case iPhone9_4: {
            return @"Apple A10";
        }
        case iPhone10_1:
        case iPhone10_2:
        case iPhone10_3:
        case iPhone10_4:
        case iPhone10_5:
        case iPhone10_6:{
            return @"Apple A11";
        }
        case iPhone11_2:
        case iPhone11_4:
        case iPhone11_6:
        case iPhone11_8: {
            return @"Apple A12 Bionic";
        }
        case iPhone12_1:
        case iPhone12_3:
        case iPhone12_5:
        case iPhone12_8: {
            return @"Apple A13";
        }
        // iPod
        case iPod1_1: {
            return @"S5L8900";
        }
        case iPod2_1: {
            return @"S5L8720";
        }
        case iPod3_1: {
            return @"S5L8922";
        }
        case iPod4_1: {
            return @"Apple A4";
        }
        case iPod5_1: {
            return @"Apple A5 Rev A";
        }
        case iPod7_1: {
            return @"Apple A8";
        }
        case iPod9_1: {
            return @"A10 Fusion";
        }
        // iPad
        case iPad1_1: {
            return @"Apple A4";
        }
        case iPad2_1:
        case iPad2_2:
        case iPad2_3:
        case iPad2_4: {
            return @"Apple A5";
        }
        case iPad2_5:
        case iPad2_6:
        case iPad2_7: {
            return @"Apple A5 Rev A";
        }
        case iPad3_1:
        case iPad3_2:
        case iPad3_3: {
            return @"Apple A5X";
        }
        case iPad3_4:
        case iPad3_5:
        case iPad3_6: {
            return @"Apple A6X";
        }
        case iPad4_1:
        case iPad4_2:
        case iPad4_3: {
            return @"Apple A7 Rev A";
        }
        case iPad4_4:
        case iPad4_5:
        case iPad4_6:
        case iPad4_7:
        case iPad4_8:
        case iPad4_9: {
            return @"Apple A7";
        }
        case iPad5_1:
        case iPad5_2: {
            return @"Apple A8";
        }
        case iPad5_3:
        case iPad5_4: {
            return @"Apple A8X";
        }
        case iPad6_3:
        case iPad6_4: {
            return @"Apple A9X";
        }
        case iPad6_7:
        case iPad6_8: {
            return @"Apple A9X";
        }
        case iPad6_11:
        case iPad6_12: {
            return @"Apple A9";
        }
        case iPad7_1:
        case iPad7_2: {
            return @"Apple A10X";
        }
        case iPad7_3:
        case iPad7_4: {
            return @"Apple A10X";
        }
        case iPad7_5:
        case iPad7_6:
        case iPad7_11:
        case iPad7_12: {
            return @"Apple A10";
        }
        case iPad8_1:
        case iPad8_2:
        case iPad8_3:
        case iPad8_4:
        case iPad8_5:
        case iPad8_6:
        case iPad8_7:
        case iPad8_8:
        case iPad8_9:
        case iPad8_10:
        case iPad8_11:
        case iPad8_12: {
            return @"Apple A12Z";
        }
        default:
            return @"Unknown";
    }
};

/**
 协处理器名称
 
 @param hardcodedDevice 硬件型号
 @return NSString
 */
static NSString * const HardcodedDeviceCoprocessorName(FSHardcodedDeviceEnum hardcodedDevice) {
    switch (hardcodedDevice) {
        // iPhone
        case iPhone1_1:
        case iPhone1_2:
        case iPhone2_1:
        case iPhone3_1:
        case iPhone3_2:
        case iPhone3_3:
        case iPhone4_1:
        case iPhone5_1:
        case iPhone5_2:
        case iPhone5_3:
        case iPhone5_4: {
            return @"N/A";
        }
        case iPhone6_1:
        case iPhone6_2: {
            return @"Apple M7";
        }
        case iPhone7_1:
        case iPhone7_2: {
            return @"Apple M8";
        }
        case iPhone8_1:
        case iPhone8_2:
        case iPhone8_4: {
            return @"Apple M9";
        }
        case iPhone9_1:
        case iPhone9_2:
        case iPhone9_3:
        case iPhone9_4: {
            return @"Apple M10";
        }
        case iPhone10_1:
        case iPhone10_2:
        case iPhone10_3:
        case iPhone10_4:
        case iPhone10_5:
        case iPhone10_6:{
            return @"Apple M11";
        }
        case iPhone11_2:
        case iPhone11_4:
        case iPhone11_6:
        case iPhone11_8:
        case iPhone12_1:
        case iPhone12_3:
        case iPhone12_5:
        case iPhone12_8:{
            return @"N/A";
        }
        // iPod
        case iPod1_1:
        case iPod2_1:
        case iPod3_1:
        case iPod4_1:
        case iPod5_1: {
            return @"N/A";
        }
        case iPod7_1: {
            return @"Apple M8";
        }
        case iPod9_1: {
             return @"Apple M10";
        }
        // iPad
        case iPad1_1:
        case iPad2_1:
        case iPad2_2:
        case iPad2_3:
        case iPad2_4:
        case iPad2_5:
        case iPad2_6:
        case iPad2_7:
        case iPad3_1:
        case iPad3_2:
        case iPad3_3:
        case iPad3_4:
        case iPad3_5:
        case iPad3_6: {
            return @"N/A";
        }
        case iPad4_1:
        case iPad4_2:
        case iPad4_3:
        case iPad4_4:
        case iPad4_5:
        case iPad4_6:
        case iPad4_7:
        case iPad4_8:
        case iPad4_9: {
            return @"Apple M7";
        }
        case iPad5_1:
        case iPad5_2:
        case iPad5_3:
        case iPad5_4: {
            return @"Apple M8";
        }
        case iPad6_3:
        case iPad6_4:
        case iPad6_7:
        case iPad6_8:
        case iPad6_11:
        case iPad6_12: {
            return @"Apple M9";
        }
        case iPad7_1:
        case iPad7_2:
        case iPad7_3:
        case iPad7_4:
        case iPad7_5:
        case iPad7_6:
        case iPad7_11:
        case iPad7_12: {
            return @"Apple M10";
        }
        case iPad8_1:
        case iPad8_2:
        case iPad8_3:
        case iPad8_4:
        case iPad8_5:
        case iPad8_6:
        case iPad8_7:
        case iPad8_8:
        case iPad8_9:
        case iPad8_10:
        case iPad8_11:
        case iPad8_12: {
            return @"Apple M12";
        }
        default:
            return @"Unknown";
    }
};

/**
 电池容量
 
 iPad Pro 12.9-inch 3th (iPad8_5、iPad8_6、iPad8_7、iPad8_8) 数据来自
 https://zhuanlan.zhihu.com/p/48880124
 
 @param hardcodedDevice 硬件型号
 @return NSUInteger 单位mA
 */
static const NSUInteger HardcodedDeviceBatteryCapacity(FSHardcodedDeviceEnum hardcodedDevice) {
    switch (hardcodedDevice) {
        // iPhone
        case iPhone1_1: {
            return 1400;
        }
        case iPhone1_2: {
            return 1150;
        }
        case iPhone2_1: {
            return 1219;
        }
        case iPhone3_1:
        case iPhone3_2:
        case iPhone3_3: {
            return 1419;
        }
        case iPhone4_1: {
            return 1432;
        }
        case iPhone5_1:
        case iPhone5_2: {
            return 1434;
        }
        case iPhone5_3:
        case iPhone5_4: {
            return 1508;
        }
        case iPhone6_1:
        case iPhone6_2: {
            return 1508;
        }
        case iPhone7_1: {
            return 2906;
        }
        case iPhone7_2: {
            return 1809;
        }
        case iPhone8_1: {
            return 1715;
        }
        case iPhone8_2: {
            return 2750;
        }
        case iPhone8_4: {
            return 1624;
        }
        case iPhone9_1:
        case iPhone9_3: {
            return 1960;
        }
        case iPhone9_2:
        case iPhone9_4: {
            return 2900;
        }
        case iPhone10_1:
        case iPhone10_4: {
            return 1821;
        }
        case iPhone10_2:
        case iPhone10_5: {
            return 2691;
        }
        case iPhone10_3:
        case iPhone10_6: {
            return 2716;
        }
        case iPhone11_2: {
            return 2658;
        }
        case iPhone11_4:
        case iPhone11_6: {
            return 3174;
        }
        case iPhone11_8: {
            return 2942;
        }
        case iPhone12_1: {
            return 3110;
        }
        case iPhone12_3: {
            return 3046;
        }
        case iPhone12_5: {
            return 3969;
        }
        case iPhone12_8: {
            return 1821;
        }
        // iPod
        case iPod1_1: {
            return 580;
        }
        case iPod2_1: {
            return 730;
        }
        case iPod3_1: {
            return 789;
        }
        case iPod4_1: {
            return 930;
        }
        case iPod5_1: {
            return 1030;
        }
        case iPod7_1: {
            return 1043;
        }
        case iPod9_1: {
            return 1043;
        }
        // iPad
        case iPad1_1: {
            return 6600;
        }
        case iPad2_1:
        case iPad2_2:
        case iPad2_3:
        case iPad2_4: {
            return 6930;
        }
        case iPad2_5:
        case iPad2_6:
        case iPad2_7: {
            return 4440;
        }
        case iPad3_1:
        case iPad3_2:
        case iPad3_3: {
            return 11560;
        }
        case iPad3_4:
        case iPad3_5:
        case iPad3_6: {
            return 11560;
        }
        case iPad4_1:
        case iPad4_2:
        case iPad4_3: {
            return 8820;
        }
        case iPad4_4:
        case iPad4_5:
        case iPad4_6: {
            return 6471;
        }
        case iPad4_7:
        case iPad4_8:
        case iPad4_9: {
            return 6471;
        }
        case iPad5_1:
        case iPad5_2: {
            return 5124;
        }
        case iPad5_3:
        case iPad5_4: {
            return 7340;
        }
        case iPad6_3:
        case iPad6_4: {
            return 7306;
        }
        case iPad6_7:
        case iPad6_8: {
            return 10307;
        }
        case iPad6_11:
        case iPad6_12: {
            return 8820;
        }
        case iPad7_1:
        case iPad7_2: {
            return 10875;
        }
        case iPad7_3:
        case iPad7_4: {
            return 8134;
        }
        case iPad7_5:
        case iPad7_6:
        case iPad7_11:
        case iPad7_12: {
            return 8820;
        }
        case iPad8_1:
        case iPad8_2:
        case iPad8_3:
        case iPad8_4: {
            return 7812;
        }
        case iPad8_5:
        case iPad8_6:
        case iPad8_7:
        case iPad8_8: {
            return 9720;
        }
        case iPad8_9:
        case iPad8_10: {
            return 7540;
        }
        case iPad8_11:
        case iPad8_12: {
            return 9720;
        }
        default:
            return 0;
    }
};

/**
 电池电压

 @param hardcodedDevice 硬件型号
 @return CGFloat 单位 V
 */
static const CGFloat HardcodedDeviceBatteryVoltage(FSHardcodedDeviceEnum hardcodedDevice) {
    switch (hardcodedDevice) {
        // iPhone
        case iPhone1_1: {
            return 3.7;
        }
        case iPhone1_2: {
            return 3.7;
        }
        case iPhone2_1: {
            return 3.7;
        }
        case iPhone3_1:
        case iPhone3_2:
        case iPhone3_3: {
            return 3.7;
        }
        case iPhone4_1: {
            return 3.7;
        }
        case iPhone5_1:
        case iPhone5_2: {
            return 3.8;
        }
        case iPhone5_3:
        case iPhone5_4: {
            return 3.8;
        }
        case iPhone6_1:
        case iPhone6_2: {
            return 3.8;
        }
        case iPhone7_1: {
            return 3.82;
        }
        case iPhone7_2: {
            return 3.82;
        }
        case iPhone8_1: {
            return 3.82;
        }
        case iPhone8_2: {
            return 3.8;
        }
        case iPhone8_4: {
            return 3.82;
        }
        case iPhone9_1:
        case iPhone9_3: {
            return 3.8;
        }
        case iPhone9_2:
        case iPhone9_4: {
            return 3.82;
        }
        case iPhone10_1:
        case iPhone10_4: {
            return 3.82;
        }
        case iPhone10_2:
        case iPhone10_5: {
            return 3.82;
        }
        case iPhone10_3:
        case iPhone10_6: {
            return 3.81;
        }
        case iPhone11_2: {
            return 3.81;
        }
        case iPhone11_4:
        case iPhone11_6: {
            return 3.8;
        }
        case iPhone11_8: {
            return 3.79;
        }
        case iPhone12_1:
        case iPhone12_3: {
            return 3.83;
        }
        case iPhone12_5: {
            return 3.79;
        }
        case iPhone12_8: {
            return 3.82;
        }
        // iPod
        case iPod1_1: {
            return 3.7;
        }
        case iPod2_1: {
            return 3.7;
        }
        case iPod3_1: {
            return 3.7;
        }
        case iPod4_1: {
            return 3.7;
        }
        case iPod5_1: {
            return 3.7;
        }
        case iPod7_1:
        case iPod9_1: {
            return 3.83;
        }
        // iPad
        case iPad1_1: {
            return 3.76;
        }
        case iPad2_1:
        case iPad2_2:
        case iPad2_3:
        case iPad2_4: {
            return 3.8;
        }
        case iPad2_5:
        case iPad2_6:
        case iPad2_7: {
            return 3.72;
        }
        case iPad3_1:
        case iPad3_2:
        case iPad3_3: {
            return 3.78;
        }
        case iPad3_4:
        case iPad3_5:
        case iPad3_6: {
            return 3.78;
        }
        case iPad4_1:
        case iPad4_2:
        case iPad4_3: {
            return 3.73;
        }
        case iPad4_4:
        case iPad4_5:
        case iPad4_6: {
            return 3.75;
        }
        case iPad4_7:
        case iPad4_8:
        case iPad4_9: {
            return 3.75;
        }
        case iPad5_1:
        case iPad5_2: {
            return 3.82;
        }
        case iPad5_3:
        case iPad5_4: {
            return 3.763;
        }
        case iPad6_3:
        case iPad6_4: {
            return 3.82;
        }
        case iPad6_7:
        case iPad6_8: {
            return 3.77;
        }
        case iPad6_11:
        case iPad6_12: {
            return 3.73;
        }
        case iPad7_1:
        case iPad7_2: {
            return 3.77;
        }
        case iPad7_3:
        case iPad7_4: {
            return 3.77;
        }
        case iPad7_5:
        case iPad7_6:
        case iPad7_11:
        case iPad7_12:{
            return 3.73;
        }
        case iPad8_1:
        case iPad8_2:
        case iPad8_3:
        case iPad8_4: {
            return 3.77;
        }
        case iPad8_5:
        case iPad8_6:
        case iPad8_7:
        case iPad8_8:
        case iPad8_11:
        case iPad8_12:{
            return 3.78;
        }
        case iPad8_9:
        case iPad8_10: {
            return 3.81;
        }
        default:
            return 0;
    }
};

/**
 屏幕尺寸
 
 @param hardcodedDevice 硬件型号
 @return CGFloat 英寸
 */
static const CGFloat HardcodedDeviceScreenSize(FSHardcodedDeviceEnum hardcodedDevice) {
    switch (hardcodedDevice) {
        // iPhone
        case iPhone1_1: {
            return 3.5;
        }
        case iPhone1_2: {
            return 3.5;
        }
        case iPhone2_1: {
            return 3.5;
        }
        case iPhone3_1:
        case iPhone3_2:
        case iPhone3_3: {
            return 3.5;
        }
        case iPhone4_1: {
            return 3.5;
        }
        case iPhone5_1:
        case iPhone5_2: {
            return 4.0;
        }
        case iPhone5_3:
        case iPhone5_4: {
            return 4.0;
        }
        case iPhone6_1:
        case iPhone6_2: {
            return 4.0;
        }
        case iPhone7_1: {
            return 5.5;
        }
        case iPhone7_2: {
            return 4.7;
        }
        case iPhone8_1: {
            return 4.7;
        }
        case iPhone8_2: {
            return 5.5;
        }
        case iPhone8_4: {
            return 4;
        }
        case iPhone9_1:
        case iPhone9_3: {
            return 4.7;
        }
        case iPhone9_2:
        case iPhone9_4: {
            return 5.5;
        }
        case iPhone10_1:
        case iPhone10_4: {
            return 4.7;
        }
        case iPhone10_2:
        case iPhone10_5: {
            return 5.5;
        }
        case iPhone10_3:
        case iPhone10_6:
        case iPhone11_2:
        case iPhone12_3: {
            return 5.8;
        }
        case iPhone11_4:
        case iPhone11_6:
        case iPhone12_5: {
            return 6.5;
        }
        case iPhone11_8:
        case iPhone12_1: {
            return 6.1;
        }
        case iPhone12_8:{
            return 4;
        }
        // iPod
        case iPod1_1: {
            return 3.5;
        }
        case iPod2_1: {
            return 3.5;
        }
        case iPod3_1: {
            return 3.5;
        }
        case iPod4_1: {
            return 3.5;
        }
        case iPod5_1: {
            return 4.0;
        }
        case iPod7_1: {
            return 4.0;
        }
        case iPod9_1: {
            return 4.0;
        }
        // iPad
        case iPad1_1: {
            return 9.7;
        }
        case iPad2_1:
        case iPad2_2:
        case iPad2_3:
        case iPad2_4: {
            return 9.7;
        }
        case iPad2_5:
        case iPad2_6:
        case iPad2_7: {
            return 7.9;
        }
        case iPad3_1:
        case iPad3_2:
        case iPad3_3: {
            return 9.7;
        }
        case iPad3_4:
        case iPad3_5:
        case iPad3_6: {
            return 9.7;
        }
        case iPad4_1:
        case iPad4_2:
        case iPad4_3: {
            return 9.7;
        }
        case iPad4_4:
        case iPad4_5:
        case iPad4_6: {
            return 7.9;
        }
        case iPad4_7:
        case iPad4_8:
        case iPad4_9: {
            return 7.9;
        }
        case iPad5_1:
        case iPad5_2: {
            return 7.9;
        }
        case iPad5_3:
        case iPad5_4: {
            return 9.7;
        }
        case iPad6_3:
        case iPad6_4: {
            return 9.7;
        }
        case iPad6_7:
        case iPad6_8: {
            return 12.9;
        }
        case iPad6_11:
        case iPad6_12: {
            return 9.7;
        }
        case iPad7_1:
        case iPad7_2: {
            return 12.9;
        }
        case iPad7_3:
        case iPad7_4: {
            return 10.5;
        }
        case iPad7_5:
        case iPad7_6: {
            return 9.7;
        }
        case iPad7_11:
        case iPad7_12:{
            return 10.2;
        }
        case iPad8_1:
        case iPad8_2:
        case iPad8_3:
        case iPad8_4:
        case iPad8_9:
        case iPad8_10: {
            return 11.0;
        }
        case iPad8_5:
        case iPad8_6:
        case iPad8_7:
        case iPad8_8:
        case iPad8_11:
        case iPad8_12: {
            return 12.9;
        }
        default:
            return 0;
    }
};

/**
 屏幕 PPI
 
 @param hardcodedDevice 硬件型号
 @return NSUInteger
 */
static const NSUInteger HardcodedDeviceScreenPPI(FSHardcodedDeviceEnum hardcodedDevice) {
    switch (hardcodedDevice) {
        // iPhone
        case iPhone1_1: {
            return 163;
        }
        case iPhone1_2: {
            return 163;
        }
        case iPhone2_1: {
            return 163;
        }
        case iPhone3_1:
        case iPhone3_2:
        case iPhone3_3: {
            return 326;
        }
        case iPhone4_1: {
            return 326;
        }
        case iPhone5_1:
        case iPhone5_2: {
            return 326;
        }
        case iPhone5_3:
        case iPhone5_4: {
            return 326;
        }
        case iPhone6_1:
        case iPhone6_2: {
            return 326;
        }
        case iPhone7_1: {
            return 401;
        }
        case iPhone7_2: {
            return 326;
        }
        case iPhone8_1: {
            return 326;
        }
        case iPhone8_2: {
            return 401;
        }
        case iPhone8_4: {
            return 326;
        }
        case iPhone9_1:
        case iPhone9_3: {
            return 326;
        }
        case iPhone9_2:
        case iPhone9_4: {
            return 401;
        }
        case iPhone10_1:
        case iPhone10_4: {
            return 326;
        }
        case iPhone10_2:
        case iPhone10_5: {
            return 401;
        }
        case iPhone10_3:
        case iPhone10_6: {
            return 458;
        }
        case iPhone11_2: {
            return 458;
        }
        case iPhone11_4:
        case iPhone11_6:
        case iPhone12_3:
        case iPhone12_5: {
            return 458;
        }
        case iPhone11_8:
        case iPhone12_1:
        case iPhone12_8: {
            return 326;
        }
        // iPod
        case iPod1_1: {
            return 163;
        }
        case iPod2_1: {
            return 163;
        }
        case iPod3_1: {
            return 163;
        }
        case iPod4_1: {
            return 326;
        }
        case iPod5_1: {
            return 326;
        }
        case iPod7_1:
        case iPod9_1: {
            return 326;
        }
        // iPad
        case iPad1_1: {
            return 132;
        }
        case iPad2_1:
        case iPad2_2:
        case iPad2_3:
        case iPad2_4: {
            return 132;
        }
        case iPad2_5:
        case iPad2_6:
        case iPad2_7: {
            return 163;
        }
        case iPad3_1:
        case iPad3_2:
        case iPad3_3: {
            return 264;
        }
        case iPad3_4:
        case iPad3_5:
        case iPad3_6: {
            return 264;
        }
        case iPad4_1:
        case iPad4_2:
        case iPad4_3: {
            return 264;
        }
        case iPad4_4:
        case iPad4_5:
        case iPad4_6: {
            return 326;
        }
        case iPad4_7:
        case iPad4_8:
        case iPad4_9: {
            return 326;
        }
        case iPad5_1:
        case iPad5_2: {
            return 326;
        }
        case iPad5_3:
        case iPad5_4: {
            return 264;
        }
        case iPad6_3:
        case iPad6_4: {
            return 264;
        }
        case iPad6_7:
        case iPad6_8: {
            return 264;
        }
        case iPad6_11:
        case iPad6_12: {
            return 264;
        }
        case iPad7_1:
        case iPad7_2: {
            return 264;
        }
        case iPad7_3:
        case iPad7_4: {
            return 264;
        }
        case iPad7_5:
        case iPad7_6:
        case iPad7_11:
        case iPad7_12: {
            return 264;
        }
        case iPad8_1:
        case iPad8_2:
        case iPad8_3:
        case iPad8_4: {
            return 264;
        }
        case iPad8_5:
        case iPad8_6:
        case iPad8_7:
        case iPad8_8:
        case iPad8_9:
        case iPad8_10:
        case iPad8_11:
        case iPad8_12: {
            return 264;
        }
        default:
            return 0;
    }
};

@interface FSHardcodeDeviceInfo ()

@property (nonatomic, assign) FSHardcodedDeviceEnum hardcodedDevice;

@property (nonatomic, strong) NSDictionary *hardcodedDeviceDict;

@end

@implementation FSHardcodeDeviceInfo

#pragma mark - Life Cycle
/**
 创建硬编码对象

 @param machine 硬件信息
 @return FSHardcodeDeviceInfo
 */
- (nonnull FSHardcodeDeviceInfo *)initWithMachine:(NSString *)machine {
    if (self = [super init]) {
        BOOL hasMachine = [self.hardcodedDeviceDict.allKeys containsObject:machine];
        if (hasMachine) {
            NSInteger enumValue = [[self.hardcodedDeviceDict objectForKey:machine] integerValue];
            if (enumValue != 0) {
                _hardcodedDevice = (FSHardcodedDeviceEnum)enumValue;
            }
        } else {
            _hardcodedDevice = iUnknown;
        }
    }
    return self;
}

/**
 创建硬编码对象
 
 @return FSHardcodeDeviceInfo
 */
+ (nonnull FSHardcodeDeviceInfo *)machineHardcodedDeviceInfo {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machine = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [[[self class] alloc] initWithMachine:machine];
}

#pragma mark - Public Method
/**
 获取设备名称
 
 @return NSString
 */
- (const NSString *)getDeviceName {
    NSString *deviceName = HardcodedDeviceName(_hardcodedDevice);
    return deviceName;
}

/**
 获取 CPU 名称
 
 @return NSString
 */
- (const NSString *)getCPUName {
    NSString *CPUName = HardcodedDeviceCPUName(_hardcodedDevice);
    return CPUName;
}

/**
 获取 CPU 频率
 
 @return NSUInteger
 */
- (NSUInteger)getCPUFrequency {
    NSUInteger CPUFrequency = HardcodedDeviceCPUFrequency(_hardcodedDevice);
    return CPUFrequency;
}

/**
 获取 协处理器 名称
 
 @return NSString
 */
- (const NSString *)getCoprocessorName {
    NSString *coprocessorName = HardcodedDeviceCoprocessorName(_hardcodedDevice);
    return coprocessorName;
}

/**
 获取电池容量
 
 @return NSUInteger
 */
- (NSUInteger)getBatteryCapacity {
    NSUInteger batteryCapacity = HardcodedDeviceBatteryCapacity(_hardcodedDevice);
    return batteryCapacity;
}

/**
 获取电池电压
 
 @return CGFloat
 */
- (CGFloat)getBatteryVoltage {
    CGFloat batteryVoltage = HardcodedDeviceBatteryVoltage(_hardcodedDevice);
    return batteryVoltage;
}

/**
 获取屏幕尺寸
 
 @return CGFloat 英寸
 */
- (CGFloat)getScreenSize {
    CGFloat screenSize = HardcodedDeviceScreenSize(_hardcodedDevice);
    return screenSize;
}

/**
 获取屏幕 PPI
 
 @return NSUInteger
 */
- (NSUInteger)getPPI {
    NSUInteger screenPPI = HardcodedDeviceScreenPPI(_hardcodedDevice);
    return screenPPI;
}

#pragma mark - Private Method

#pragma mark - Getters and Setters
/**
 获取硬件信息对应的枚举

 @return NSDictionary
 */
- (NSDictionary *)hardcodedDeviceDict {
    if (!_hardcodedDeviceDict) {
        NSDictionary *hardcodedDeviceDict = @{
                                              /* iPhone */
                                              // iPhone 2G
                                              @"iPhone1,1" : @(iPhone1_1),
                                              
                                              // iPhone 3G
                                              @"iPhone1,2" : @(iPhone1_2),
                                              // iPhone 3GS
                                              @"iPhone2,1" : @(iPhone2_1),
                                              // iPhone 4
                                              @"iPhone3,1" : @(iPhone3_1),
                                              @"iPhone3,2" : @(iPhone3_2),
                                              @"iPhone3,3" : @(iPhone3_3),
                                              // iPhone 4S
                                              @"iPhone4,1" : @(iPhone4_1),
                                              // iPhone 5
                                              @"iPhone5,1" : @(iPhone5_1),
                                              @"iPhone5,2" : @(iPhone5_2),
                                              // iPhone 5C
                                              @"iPhone5,3" : @(iPhone5_3),
                                              @"iPhone5,4" : @(iPhone5_4),
                                              // iPhone 5S
                                              @"iPhone6,1" : @(iPhone6_1),
                                              @"iPhone6,2" : @(iPhone6_2),
                                              // iPhone 6 Plus
                                              @"iPhone7,1" : @(iPhone7_1),
                                              // iPhone 6
                                              @"iPhone7,2" : @(iPhone7_2),
                                              // iPhone 6s
                                              @"iPhone8,1" : @(iPhone8_1),
                                              // iPhone 6s Plus
                                              @"iPhone8,2" : @(iPhone8_2),
                                              // iPhone SE
                                              @"iPhone8,4" : @(iPhone8_4),
                                              // iPhone 7
                                              @"iPhone9,1" : @(iPhone9_1),
                                              // iPhone 7 Plus
                                              @"iPhone9,2" : @(iPhone9_2),
                                              // iPhone 7
                                              @"iPhone9,3" : @(iPhone9_3),
                                              // iPhone 7 Plus
                                              @"iPhone9,4" : @(iPhone9_4),
                                              // iPhone 8
                                              @"iPhone10,1" : @(iPhone10_1),
                                              // iPhone 8 Plus
                                              @"iPhone10,2" : @(iPhone10_2),
                                              // iPhone X
                                              @"iPhone10,3" : @(iPhone10_3),
                                              // iPhone 8
                                              @"iPhone10,4" : @(iPhone10_4),
                                              // iPhone 8 Plus
                                              @"iPhone10,5" : @(iPhone10_5),
                                              // iPhone X
                                              @"iPhone10,6" : @(iPhone10_6),
                                              // iPhone XS
                                              @"iPhone11,2" : @(iPhone11_2),
                                              // iPhone XS Max
                                              @"iPhone11,4" : @(iPhone11_4),
                                              @"iPhone11,6" : @(iPhone11_6),
                                              // iPhone XR
                                              @"iPhone11,8" : @(iPhone11_8),
                                              // iPhone 11
                                              @"iPhone12,1" : @(iPhone12_1),
                                              // iPhone 11 Pro
                                              @"iPhone12,3" : @(iPhone12_3),
                                              // iPhone 11 Pro Max
                                              @"iPhone12,5" : @(iPhone12_5),
                                              // iPhone SE (2020)
                                              @"iPhone12,8" : @(iPhone12_8),
                                              
                                              /* iPod */
                                              @"iPod1,1" : @(iPod1_1),
                                              @"iPod2,1" : @(iPod2_1),
                                              @"iPod3,1" : @(iPod3_1),
                                              @"iPod4,1" : @(iPod4_1),
                                              @"iPod5,1" : @(iPod5_1),
                                              // iPod 6
                                              @"iPod7,1" : @(iPod7_1),
                                              // iPod 7
                                              @"iPod9,1" : @(iPod9_1),
                                              
                                              /* iPad */
                                              // iPad
                                              @"iPad1,1" : @(iPad1_1),
                                              // iPad 2
                                              @"iPad2,1" : @(iPad2_1),
                                              @"iPad2,2" : @(iPad2_2),
                                              @"iPad2,3" : @(iPad2_3),
                                              @"iPad2,4" : @(iPad2_4),
                                              // iPad mini
                                              @"iPad2,5" : @(iPad2_5),
                                              @"iPad2,6" : @(iPad2_6),
                                              @"iPad2,7" : @(iPad2_7),
                                              // iPad (3rd generation)
                                              @"iPad3,1" : @(iPad3_1),
                                              @"iPad3,2" : @(iPad3_2),
                                              @"iPad3,3" : @(iPad3_3),
                                              // iPad (4th generation)
                                              @"iPad3,4" : @(iPad3_4),
                                              @"iPad3,5" : @(iPad3_5),
                                              @"iPad3,6" : @(iPad3_6),
                                              // iPad Air
                                              @"iPad4,1" : @(iPad4_1),
                                              @"iPad4,2" : @(iPad4_2),
                                              @"iPad4,3" : @(iPad4_3),
                                              // iPad mini 2
                                              @"iPad4,4" : @(iPad4_4),
                                              @"iPad4,5" : @(iPad4_5),
                                              @"iPad4,6" : @(iPad4_6),
                                              // iPad mini 3
                                              @"iPad4,7" : @(iPad4_7),
                                              @"iPad4,8" : @(iPad4_8),
                                              @"iPad4,9" : @(iPad4_9),
                                              // iPad mini 4
                                              @"iPad5,1" : @(iPad5_1),
                                              @"iPad5,2" : @(iPad5_2),
                                              // iPad Air 2
                                              @"iPad5,3" : @(iPad5_3),
                                              @"iPad5,4" : @(iPad5_4),
                                              // iPad Pro (9.7-inch)
                                              @"iPad6,3" : @(iPad6_3),
                                              @"iPad6,4" : @(iPad6_4),
                                              // iPad Pro (12.9-inch)
                                              @"iPad6,7" : @(iPad6_7),
                                              @"iPad6,8" : @(iPad6_8),
                                              // iPad (5th generation)
                                              @"iPad6,11" : @(iPad6_11),
                                              @"iPad6,12" : @(iPad6_12),
                                              // iPad Pro (12.9-inch) (2nd generation)
                                              @"iPad7,1" : @(iPad7_1),
                                              @"iPad7,2" : @(iPad7_2),
                                              // iPad Pro (10.5-inch)
                                              @"iPad7,3" : @(iPad7_3),
                                              @"iPad7,4" : @(iPad7_4),
                                              // iPad (6th generation)
                                              @"iPad7,5" : @(iPad7_5),
                                              @"iPad7,6" : @(iPad7_6),
                                              // iPad (7th generation)
                                              @"iPad7,11" : @(iPad7_11),
                                              @"iPad7,12" : @(iPad7_12),
                                              // iPad Pro (11-inch)
                                              @"iPad8,1" : @(iPad8_1),
                                              @"iPad8,2" : @(iPad8_2),
                                              @"iPad8,3" : @(iPad8_3),
                                              @"iPad8,4" : @(iPad8_4),
                                              // iPad Pro (12.9-inch) (3rd generation)
                                              @"iPad8,5" : @(iPad8_5),
                                              @"iPad8,6" : @(iPad8_6),
                                              @"iPad8,7" : @(iPad8_7),
                                              @"iPad8,8" : @(iPad8_8),
                                              // iPad Pro (11-inch) (2nd generation)
                                              @"iPad8,9" : @(iPad8_9),
                                              @"iPad8,10" : @(iPad8_10),
                                              // iPad Pro (12.9-inch) (4th generation)
                                              @"iPad8,11" : @(iPad8_11),
                                              @"iPad8,12" : @(iPad8_12),
                                              };
        _hardcodedDeviceDict = hardcodedDeviceDict;
    }
    return _hardcodedDeviceDict;
}

@end
