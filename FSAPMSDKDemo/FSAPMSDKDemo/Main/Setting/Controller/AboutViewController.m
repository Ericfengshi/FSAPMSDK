//
//  AboutViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutViewModel.h"

#pragma mark - static const/#define
static NSString *const KCellReuseIdentifier = @"AboutViewControllerCellReuseIdentifier";

@interface AboutViewController ()<UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) AboutViewModel *viewModel;

@end

@implementation AboutViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"About";
    [self p_loadData];
    [self p_loadSubViews];
}

#pragma mark - UITableViewDataSource
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
    cell.textLabel.text = [infoDic objectForKey:kAboutViewModelInfoKey];
    cell.detailTextLabel.text = [infoDic objectForKey:kAboutViewModelInfoValue];
    return cell;
}

#pragma mark - Private Methods
- (void)p_loadData {
    self.viewModel = [AboutViewModel new];
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
        tableView.tableFooterView = [[UIView alloc] init];
        _tableView = tableView;
    }
    return _tableView;
}

@end
