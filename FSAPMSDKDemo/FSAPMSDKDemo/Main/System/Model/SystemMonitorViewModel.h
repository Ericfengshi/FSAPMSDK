//
//  SystemMonitorViewModel.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SystemMonitorType){
    SystemMonitorCPUType = 1,
    SystemMonitorRAMType = 2,
    SystemMonitorDiskType = 3,
    SystemMonitorBatteryType = 4,
    SystemMonitorNetworkFlowType = 5,
    SystemMonitorNetworkStateType = 6,
    SystemMonitorFPSType = 7,
};

#pragma mark - static const/#define
extern NSString *const kSystemMonitorViewModelInfoKey;
extern NSString *const kSystemMonitorViewModelInfoValue;

@protocol SystemMonitorViewModelDelegate;
@interface SystemMonitorViewModel : NSObject

/**
 监控类型
 */
@property (nonatomic, strong, readonly) NSMutableArray *sysInfoArray;

/**
 单例对象
 
 @return SystemMonitorViewModel
 */
+ (instancetype)sharedInstance;

/**
 加载列表数据
 */
- (void)loadData;

/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<SystemMonitorViewModelDelegate>)delegate;

/**
 委托对象去除监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<SystemMonitorViewModelDelegate>)delegate;

@end

@protocol SystemMonitorViewModelDelegate <NSObject>

/**
 更新数据

 @param monitorType 监控类型
 @param data 数据
 */
- (void)updateMonitorType:(SystemMonitorType)monitorType forData:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
