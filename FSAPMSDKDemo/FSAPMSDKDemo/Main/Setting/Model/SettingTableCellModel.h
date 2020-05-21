//
//  SettingTableCellModel.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, SettingAccessoryType){
    SettingAccessoryAboutType = 1,
    SettingAccessoryANRType = 2,
    SettingAccessoryCrashType = 3,
    SettingAccessoryBayMaxType = 4,
    SettingAccessoryNetworkType = 5,
    SettingAccessorySystemType = 6,
    SettingAccessoryFPSType = 7,
    SettingAccessoryBatteryType = 8,
};

@interface SettingTableCellModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, assign) SettingAccessoryType settingType;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;

@end

NS_ASSUME_NONNULL_END
