//
//  SimulatorManager.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/12.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimulatorHeader.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - static const/#define
extern NSString *const kSimulatorManagerTitleKey;
extern NSString *const kSimulatorManagerDetailKey;

@interface SimulatorManager : NSObject

/**
 采集的卡顿数据
 */
@property (nonatomic, strong) NSMutableArray *ANRInfoArray;

/**
 采集的闪退数据
 */
@property (nonatomic, strong) NSMutableArray *crashInfoArray;

/**
 采集的防护数据
 */
@property (nonatomic, strong) NSMutableArray *bayMaxInfoArray;

/**
 采集的网络数据
 */
@property (nonatomic, strong) NSMutableArray *networkInfoArray;

/**
 数据类型
 */
@property (nonatomic, assign, readonly) SimulatorDataType dataType;

/**
 单例对象
 
 @return SimulatorManager
 */
+ (SimulatorManager *)sharedInstance;

///**
// 展现悬浮框
// */
//- (void)show;

/**
 展现悬浮框

 @param dataType 数据类型
 */
- (void)showWithDataType:(SimulatorDataType)dataType;

/**
 隐藏
 */
- (void)hide;

/**
 当前类型采集的数据集合

 @param dataType 数据类型
 @return NSArray
 */
- (NSArray *)dataInfoArrayWithDataType:(SimulatorDataType)dataType;

@end

NS_ASSUME_NONNULL_END
