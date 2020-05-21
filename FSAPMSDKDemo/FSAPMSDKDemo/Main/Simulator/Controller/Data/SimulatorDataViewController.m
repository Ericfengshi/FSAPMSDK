//
//  SimulatorDataViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/13.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorDataViewController.h"
#import "SimulatorManager.h"
#import "SimulatorDataDetailViewController.h"

#pragma mark - static const/#define
static NSString *const KCellReuseIdentifier = @"SimulatorDataViewControllerCellReuseIdentifier";

@interface SimulatorDataViewController ()<UITableViewDataSource, UITableViewDelegate>

/**
 数据类型
 */
@property (nonatomic, assign) SimulatorDataType dataType;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SimulatorDataViewController

#pragma mark - Life Cycle
/**
 初始化
 
 @param dataType 数据类型
 @return SimulatorDataViewController
 */
- (instancetype)initWithDataType:(SimulatorDataType)dataType {
    if (self = [super init]) {
        _dataType = dataType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadData];
    [self p_loadSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationItem setHidesBackButton:NO];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
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
    cell.textLabel.text = [infoDic objectForKey:kSimulatorManagerTitleKey];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *infoDic = [self.dataArray objectAtIndex:indexPath.row];
    SimulatorDataDetailViewController *vc = [SimulatorDataDetailViewController new];
    vc.title = [infoDic objectForKey:kSimulatorManagerTitleKey];
    vc.text = [infoDic objectForKey:kSimulatorManagerDetailKey];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)p_loadData {
    self.dataArray = [[SimulatorManager sharedInstance] dataInfoArrayWithDataType:self.dataType];
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
