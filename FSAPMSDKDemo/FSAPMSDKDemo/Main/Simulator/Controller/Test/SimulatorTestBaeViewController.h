//
//  SimulatorTestBaeViewController.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/13.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimulatorTestViewModel.h"
#import "SimulatorManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimulatorTestBaeViewController : UIViewController <UITableViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;

/**
 数据类型
 */
@property (nonatomic, assign, readonly) SimulatorDataType dataType;

/**
 数据模型
 */
@property (nonatomic, strong, readonly) SimulatorTestViewModel *viewModel;

/**
 初始化
 
 @param dataType 数据类型
 @return SimulatorDataViewController
 */
- (instancetype)initWithDataType:(SimulatorDataType)dataType;

@end

NS_ASSUME_NONNULL_END
