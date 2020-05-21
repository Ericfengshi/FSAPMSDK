//
//  SimulatorViewModel.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/12.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorViewModel.h"

@implementation SimulatorTableCellModel

#pragma mark - Life Cycle
/**
 初始化

 @param cellType 类型
 @return SimulatorDataModel
 */
- (instancetype)initWithCellType:(SimulatorDataType)cellType {
    if (self = [super init]) {
        _cellType = cellType;
        _className = [self p_getClassNameByCellType:cellType];
        _cellName = SimulatorDataTypeName(cellType);
    }
    return self;
}

#pragma mark - Private Methods
- (NSString *)p_getClassNameByCellType:(SimulatorDataType)cellType {
    switch (cellType) {
        case SimulatorDataANRType: {
            return @"SimulatorANRViewController";
            break;
        }
        case SimulatorDataCrashType: {
            return @"SimulatorCrashViewController";
            break;
        }
        case SimulatorDataBayMaxType: {
            return @"SimulatorBayMaxViewController";
            break;
        }
        case SimulatorDataNetworkType: {
            return @"SimulatorNetworkViewController";
            break;
        }
        default:
            return @"";
            break;
    }
}

@end

@interface SimulatorViewModel()

/**
 展现数据
 */
@property (nonatomic, strong, readwrite) NSArray<SimulatorTableCellModel *>* dataArray;

@end

@implementation SimulatorViewModel

#pragma mark - Public Methods
/**
 加载数据
 */
- (void)loadData {
    [self dataArray];
}

#pragma mark - Getters and Setters
- (NSArray<SimulatorTableCellModel *> *)dataArray {
    if (!_dataArray) {

        SimulatorTableCellModel *cellModel1 = [[SimulatorTableCellModel alloc] initWithCellType:SimulatorDataANRType];
        SimulatorTableCellModel *cellModel2 = [[SimulatorTableCellModel alloc] initWithCellType:SimulatorDataCrashType];
        SimulatorTableCellModel *cellModel3 = [[SimulatorTableCellModel alloc] initWithCellType:SimulatorDataBayMaxType];
        SimulatorTableCellModel *cellModel4 = [[SimulatorTableCellModel alloc] initWithCellType:SimulatorDataNetworkType];
        
        _dataArray = [NSArray arrayWithObjects:cellModel1, cellModel2, cellModel3, cellModel4, nil];
    }
    return _dataArray;
}
@end
