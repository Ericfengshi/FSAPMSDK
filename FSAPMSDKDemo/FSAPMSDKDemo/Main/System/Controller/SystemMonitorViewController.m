//
//  SystemMonitorViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SystemMonitorViewController.h"
#import "SystemMonitorViewModel.h"
#import "SystemDetailViewController.h"

#pragma mark - static const/#define
static NSString *const KCellReuseIdentifier = @"SystemViewControllerCellReuseIdentifier";

@interface SystemMonitorViewController ()<SystemMonitorViewModelDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SystemMonitorViewModel *viewModel;

@property (nonatomic, strong) NSMutableDictionary *detailDic;

@end

@implementation SystemMonitorViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadData];
    [self p_loadSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.viewModel) {
        [self.viewModel addDelegate:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.viewModel) {
        [self.viewModel removeDelegate:self];
    }
}

- (void)dealloc {
    if (self.viewModel) {
        [self.viewModel removeDelegate:self];
    }
}

#pragma mark - SystemMonitorViewModelDelegate
/**
 更新数据
 
 @param monitorType 监控类型
 @param data 数据
 */
- (void)updateMonitorType:(SystemMonitorType)monitorType forData:(NSArray *)data {
    [self.detailDic setObject:data forKey:@(monitorType)];
    if (monitorType == SystemMonitorNetworkStateType || monitorType == SystemMonitorFPSType) {
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.sysInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:KCellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *infoDic = [self.viewModel.sysInfoArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [infoDic objectForKey:kSystemMonitorViewModelInfoValue];
    NSNumber *monitorType = [infoDic objectForKey:kSystemMonitorViewModelInfoKey];
    if (monitorType.integerValue == SystemMonitorNetworkStateType || monitorType.integerValue == SystemMonitorFPSType) {
        NSArray *dataArray = [self.detailDic objectForKey:monitorType];
        if (dataArray.count > 0) {
            NSDictionary *infoDic = [dataArray firstObject];
            cell.detailTextLabel.text = [infoDic objectForKey:kSystemMonitorViewModelInfoValue];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.detailTextLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *infoDic = [self.viewModel.sysInfoArray objectAtIndex:indexPath.row];
    NSNumber *monitorType = [infoDic objectForKey:kSystemMonitorViewModelInfoKey];
    if (monitorType.integerValue == SystemMonitorNetworkStateType || monitorType.integerValue == SystemMonitorFPSType) {
        return;
    }
    SystemDetailViewController *vc = [[SystemDetailViewController alloc] init];
    vc.monitorType = monitorType;
    vc.dataDic = self.detailDic;
    vc.title = [infoDic objectForKey:kSystemMonitorViewModelInfoValue];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private Methods
- (void)p_loadData {
    self.detailDic = [NSMutableDictionary dictionary];
    self.viewModel = [[SystemMonitorViewModel sharedInstance] init];
    [self.viewModel addDelegate:self];
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
        _tableView = tableView;
    }
    return _tableView;
}

@end
