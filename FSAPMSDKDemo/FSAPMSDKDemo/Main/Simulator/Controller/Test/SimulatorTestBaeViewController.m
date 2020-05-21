//
//  SimulatorTestBaeViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/13.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorTestBaeViewController.h"

#pragma mark - static const/#define
static NSString *const KCellReuseIdentifier = @"SimulatorTestBaeViewControllerCellReuseIdentifier";

@interface SimulatorTestBaeViewController ()<UITableViewDataSource>

@property (nonatomic, strong, readwrite) UITableView *tableView;

/**
 数据模型
 */
@property (nonatomic, strong, readwrite) SimulatorTestViewModel *viewModel;

/**
 数据类型
 */
@property (nonatomic, assign, readwrite) SimulatorDataType dataType;

@end

@implementation SimulatorTestBaeViewController

#pragma mark - Life Cycle
/**
 初始化
 
 @param dataType 数据类型
 @return SimulatorDataViewController
 */
- (instancetype)initWithDataType:(SimulatorDataType)dataType {
    if (self = [super init]) {
        self.dataType = dataType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadData];
    [self p_loadSubViews];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    NSString *title = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor colorWithRed:16/255.0 green:119/255.0 blue:255/255.0 alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - Private Methods
/**
 加载数据
 */
- (void)p_loadData {
    self.viewModel = [[SimulatorTestViewModel alloc] initWithDataType:self.dataType];
}

/**
 绘制 UI
 */
- (void)p_loadSubViews {
    [self.view addSubview:self.tableView];
}

#pragma mark - Getters and Setters
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
        _tableView = tableView;
    }
    return _tableView;
}

@end
