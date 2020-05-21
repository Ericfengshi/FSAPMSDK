//
//  FSBatteryInfo.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSBatteryInfo : NSObject

/**
 总容量
 */
@property (nonatomic, assign) NSInteger totalCapacity;

/**
 当前总电量
 */
@property (nonatomic, assign) NSInteger currentCapacity;

/**
 当前电池百分比
 */
@property (nonatomic, assign) NSInteger currentPercent;

/**
 电压
 */
@property (nonatomic, assign) CGFloat voltage;

/**
 电池状态
 */
@property (nonatomic, copy) NSString *status;

/**
 电池状态初始化
 
 @param batteryLevel 当前电池级别 0 .. 1.0
 @param status 电池状态
 @return FSBatteryInfo
 */
- (instancetype)initWithBatteryLevel:(CGFloat)batteryLevel
                              status:(NSString *)status;

@end

NS_ASSUME_NONNULL_END
