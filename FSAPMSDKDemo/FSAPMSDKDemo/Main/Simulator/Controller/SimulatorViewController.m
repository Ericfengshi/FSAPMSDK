//
//  SimulatorViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorViewController.h"
#import "SimulatorViewModel.h"
#import "SimulatorManager.h"
#import "SimulatorTestBaeViewController.h"

#pragma mark - static const/#define
static NSString *const KCellReuseIdentifier = @"SimulatorViewControllerCellReuseIdentifier";

@interface SimulatorViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SimulatorViewModel *viewModel;

@end

@implementation SimulatorViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadData];
    [self p_loadSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //  隐藏悬浮框
    [[SimulatorManager sharedInstance] hide];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:KCellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SimulatorTableCellModel *cellModel = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cellModel.cellName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SimulatorTableCellModel *cellModel = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    NSString *className = cellModel.className;
    if (className && ![className isEqualToString:@""]) {
        Class cls = NSClassFromString(className);
        if ([cls isSubclassOfClass:[SimulatorTestBaeViewController class]]) {
            SimulatorTestBaeViewController *vc = [((SimulatorTestBaeViewController *)[cls alloc]) initWithDataType:cellModel.cellType];
            vc.title = SimulatorDataTypeName(cellModel.cellType);
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - Private Methods
- (void)p_loadData {
    self.viewModel = [SimulatorViewModel new];
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
