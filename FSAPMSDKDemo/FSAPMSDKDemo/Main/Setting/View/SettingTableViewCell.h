//
//  SettingTableViewCell.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingTableCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SettingTableViewCellDelegate;
@interface SettingTableViewCell : UITableViewCell

@property (nonatomic, weak) id<SettingTableViewCellDelegate> delegate;
@property (nonatomic, strong) SettingTableCellModel *cellModel;

@end

@protocol SettingTableViewCellDelegate <NSObject>

- (void)switchValueChanged:(UISwitch *)switchView settingType:(SettingAccessoryType)settingType;

@end

NS_ASSUME_NONNULL_END
