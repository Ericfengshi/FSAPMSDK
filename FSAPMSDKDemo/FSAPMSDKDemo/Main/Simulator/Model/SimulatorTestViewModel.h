//
//  SimulatorTestViewModel.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/13.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimulatorHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimulatorTestViewModel : NSObject

/**
 展现数据
 */
@property (nonatomic, strong, readonly) NSArray *dataArray;

/**
 初始化
 
 @param dataType 数据类型
 @return SimulatorDataViewController
 */
- (instancetype)initWithDataType:(SimulatorDataType)dataType;

@end

NS_ASSUME_NONNULL_END
