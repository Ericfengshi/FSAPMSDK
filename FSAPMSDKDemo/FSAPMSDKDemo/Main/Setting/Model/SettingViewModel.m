//
//  SettingViewModel.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SettingViewModel.h"
#import "SettingTableCellModel.h"

@interface SettingViewModel()

/**
 监控对象集合
 */
@property (nonatomic, strong, readwrite) NSMutableArray *monitorInfoArray;

@end

@implementation SettingViewModel

#pragma mark - Public Methods
- (void)loadData {
    [self monitorInfoArray];
}

#pragma mark - Getters and Setters
- (NSMutableArray *)monitorInfoArray {
    if (!_monitorInfoArray) {
        SettingTableCellModel *aboutCell = [[SettingTableCellModel alloc] init];
        aboutCell.title = @"About";
        aboutCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        aboutCell.settingType = SettingAccessoryAboutType;
        
        SettingTableCellModel *systemCell = [[SettingTableCellModel alloc] init];
        systemCell.title = @"System Moniotor Switch";
        systemCell.settingType = SettingAccessorySystemType;
        
        SettingTableCellModel *fpsCell = [[SettingTableCellModel alloc] init];
        fpsCell.title = @"FPS Moniotor Switch";
        fpsCell.settingType = SettingAccessoryFPSType;
        
        SettingTableCellModel *batteryCell = [[SettingTableCellModel alloc] init];
        batteryCell.title = @"Battery Moniotor Switch";
        batteryCell.settingType = SettingAccessoryBatteryType;
        
        SettingTableCellModel *ANRCell = [[SettingTableCellModel alloc] init];
        ANRCell.title = @"ANR Moniotor Switch";
        ANRCell.settingType = SettingAccessoryANRType;
        
        SettingTableCellModel *crashCell = [[SettingTableCellModel alloc] init];
        crashCell.title = @"Crash Moniotor Switch";
        crashCell.settingType = SettingAccessoryCrashType;
        
        SettingTableCellModel *bayMaxCell = [[SettingTableCellModel alloc] init];
        bayMaxCell.title = @"BayMax Moniotor Switch";
        bayMaxCell.settingType = SettingAccessoryBayMaxType;

        SettingTableCellModel *networkCell = [[SettingTableCellModel alloc] init];
        networkCell.title = @"Network Moniotor Switch";
        networkCell.settingType = SettingAccessoryNetworkType;
        
        _monitorInfoArray = [NSMutableArray arrayWithObjects:aboutCell, systemCell, fpsCell, batteryCell, ANRCell, crashCell, bayMaxCell, networkCell, nil];
    }
    return _monitorInfoArray;
}

@end
