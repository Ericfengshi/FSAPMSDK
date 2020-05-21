//
//  SettingViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "SettingViewModel.h"
#import "SettingTableCellModel.h"

#import "SimulatorZombieViewController.h"

#import "AboutViewController.h"
#import <FSAPMSDK/FSAPMSDK.h>

#pragma mark - static const/#define
static NSString *const KCellReuseIdentifier = @"SettingViewControllerCellReuseIdentifier";

@interface SettingViewController ()<SettingTableViewCellDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SettingViewModel *viewModel;

@end

@implementation SettingViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadData];
    [self p_loadSubViews];
}

#pragma mark - SettingTableViewCellDelegate
- (void)switchValueChanged:(UISwitch *)switchView settingType:(SettingAccessoryType)settingType {
    BOOL isOn = switchView.isOn;
    if (settingType == SettingAccessorySystemType) {
        if (isOn) {
            [[FSSystemMonitor sharedInstance] start];
        } else {
            [[FSSystemMonitor sharedInstance] stop];
        }
    } else if (settingType == SettingAccessoryFPSType) {
        if (isOn) {
            [[FSFPSMonitor sharedInstance] start];
        } else {
            [[FSFPSMonitor sharedInstance] stop];
        }
    } else if (settingType == SettingAccessoryANRType) {
        if (isOn) {
            [[FSANRMonitor sharedInstance] start];
        } else {
            [[FSANRMonitor sharedInstance] stop];
        }
    } else if (settingType == SettingAccessoryCrashType) {
        if (isOn) {
            [[FSCrashMonitor sharedInstance] start];
        } else {
            [[FSCrashMonitor sharedInstance] stop];
        }
    } else if (settingType == SettingAccessoryBayMaxType) {
        if (isOn) {
            [[FSBayMaxProtector sharedInstance] start];
        } else {
            [[FSBayMaxProtector sharedInstance] stop];
        }
    } else if (settingType == SettingAccessoryNetworkType) {
        if (isOn) {
            [[FSNetworkMonitor sharedInstance] start];
        } else {
            [[FSNetworkMonitor sharedInstance] stop];
        }
    }
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.monitorInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellReuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    SettingTableCellModel *cellModel = [self.viewModel.monitorInfoArray objectAtIndex:indexPath.row];
    cell.cellModel = cellModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableCellModel *cellModel = [self.viewModel.monitorInfoArray objectAtIndex:indexPath.row];
    return cellModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableCellModel *cellModel = [self.viewModel.monitorInfoArray objectAtIndex:indexPath.row];
    if (cellModel.settingType == SettingAccessoryAboutType) {
        AboutViewController *vc = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Private Methods
- (void)p_loadData {
    self.viewModel = [SettingViewModel new];
    [self.viewModel loadData];
}

- (void)p_loadSubViews {
    [self.view addSubview:self.tableView];
}

#pragma mark - Getters and Setters
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc] init];
        [tableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:KCellReuseIdentifier];
        _tableView = tableView;
    }
    return _tableView;
}

@end
