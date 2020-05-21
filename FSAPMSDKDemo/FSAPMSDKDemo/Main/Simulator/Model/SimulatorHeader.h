//
//  SimulatorHeader.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/13.
//  Copyright © 2019 fengs. All rights reserved.
//

#ifndef SimulatorHeader_h
#define SimulatorHeader_h

/**
 监控模拟数据类型

 - SimulatorDataANRType: 卡顿
 - SimulatorDataCrashType: 闪退
 - SimulatorDataBayMaxType: 闪退防护
 - SimulatorDataNetworkType: 网络
 */
typedef NS_ENUM(NSInteger, SimulatorDataType) {
    SimulatorDataANRType = 1,
    SimulatorDataCrashType,
    SimulatorDataBayMaxType,
    SimulatorDataNetworkType,
};

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
// 转换货币类型
static NSString * const SimulatorDataTypeName(SimulatorDataType dataType) {
    switch (dataType) {
        case SimulatorDataANRType: {
            return @"ANR";
            break;
        } case SimulatorDataCrashType: {
            return @"Crash";
            break;
        } case SimulatorDataBayMaxType: {
            return @"BayMax";
            break;
        }  case SimulatorDataNetworkType: {
            return @"Network";
            break;
        } default:
            return @"";
    }
};
#pragma clang diagnostic pop

#endif /* SimulatorHeader_h */
