//
//  SystemDetailViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SystemDetailViewController.h"
#import "SystemMonitorViewModel.h"

static NSString *const KCellReuseIdentifier = @"SystemDetailViewControllerCellReuseIdentifier";

@interface SystemDetailViewController ()<SystemMonitorViewModelDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) SystemMonitorViewModel *viewModel;

@end

@implementation SystemDetailViewController

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
    if (monitorType == self.monitorType.integerValue) {
        self.dataArray = data;
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:KCellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *infoDic = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [infoDic objectForKey:kSystemMonitorViewModelInfoKey];
    cell.detailTextLabel.text = [infoDic objectForKey:kSystemMonitorViewModelInfoValue];
    return cell;
}

#pragma mark - Private Methods
- (void)p_loadData {
    self.dataArray = [self.dataDic objectForKey:self.monitorType];
    if (!self.dataDic) {
        self.dataDic = [NSMutableDictionary dictionary];
    }
    if (!self.dataArray) {
        self.dataArray = [NSArray array];
    }
    
    self.viewModel = [[SystemMonitorViewModel sharedInstance] init];
    [self.viewModel addDelegate:self];
}

- (void)p_loadSubViews {
    [self.view addSubview:self.tableView];
}

#pragma mark - Getters and Setters
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] init];
        _tableView = tableView;
    }
    return _tableView;
}

@end
