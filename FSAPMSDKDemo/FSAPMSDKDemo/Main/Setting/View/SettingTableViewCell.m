//
//  SettingTableViewCell.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SettingTableViewCell.h"

#pragma mark - static const/#define

@implementation SettingTableViewCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_loadSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_loadSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Action Methods
- (void)switchValueChanged:(UISwitch *)switchView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchValueChanged:settingType:)]) {
        [self.delegate switchValueChanged:switchView settingType:_cellModel.settingType];
    }
}

#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)p_loadSubViews {
    UISwitch *switchView = [[UISwitch alloc]init];
    switchView.on = YES;
    [switchView addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = switchView;
}

#pragma mark - Getters and Setters
- (void)setCellModel:(SettingTableCellModel *)cellModel {
    _cellModel = cellModel;
    self.textLabel.text = cellModel.title;
    if (cellModel.settingType == SettingAccessoryAboutType) {
        self.accessoryView = nil;
        self.accessoryType = cellModel.accessoryType;
    }
}

@end
