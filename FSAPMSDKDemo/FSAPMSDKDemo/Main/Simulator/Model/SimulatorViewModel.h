//
//  SimulatorViewModel.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/12.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimulatorHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimulatorTableCellModel : NSObject

@property (nonatomic, assign) SimulatorDataType cellType;
@property (nonatomic, copy) NSString *cellName;
@property (nonatomic, copy) NSString *className;

@end

@interface SimulatorViewModel : NSObject

/**
 展现数据
 */
@property (nonatomic, strong, readonly) NSArray<SimulatorTableCellModel *>* dataArray;

/**
 加载数据
 */
- (void)loadData;

@end

NS_ASSUME_NONNULL_END
