//
//  SimulatorDataViewController.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/13.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimulatorHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimulatorDataViewController : UIViewController

/**
 初始化

 @param dataType 数据类型
 @return SimulatorDataViewController
 */
- (instancetype)initWithDataType:(SimulatorDataType)dataType;

@end

NS_ASSUME_NONNULL_END
