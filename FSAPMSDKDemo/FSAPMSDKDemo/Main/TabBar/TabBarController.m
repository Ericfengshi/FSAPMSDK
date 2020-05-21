//
//  TabBarController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"

#import "MonitorViewController.h"
#import "SystemMonitorViewController.h"
#import "SimulatorViewController.h"
#import "SettingViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_configureChildViewControllers];
}

#pragma mark - Private Methods
/**
 tabbar 配置
 */
- (void)p_configureChildViewControllers {

    [self p_addSimulatorController];
    
    [self p_addSystemMonitorController];
    
    [self p_addSettingController];
}

/**
 异常状态模拟
 */
- (void)p_addSimulatorController {
    SimulatorViewController *simulatorVC = [[SimulatorViewController alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:simulatorVC];
    simulatorVC.title = @"Simulator";
    nav.tabBarItem.title = @"Simulator";
    [self p_setNavigationTabBarItem:nav.tabBarItem];
    
    [self addChildViewController:nav];
}

/**
 系统监控信息查看
 */
- (void)p_addSystemMonitorController {
    SystemMonitorViewController *monitorVC = [[SystemMonitorViewController alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:monitorVC];
    monitorVC.title = @"System";
    nav.tabBarItem.title = @"System";
    [self p_setNavigationTabBarItem:nav.tabBarItem];

    [self addChildViewController:nav];
}

/**
 系统设置
 */
- (void)p_addSettingController {
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:settingVC];
    settingVC.title = @"Setting";
    nav.tabBarItem.title = @"Setting";
    [self p_setNavigationTabBarItem:nav.tabBarItem];

    [self addChildViewController:nav];
}

/**
 设置 tabBarItem 样式

 @param tabBarItem tabBar 项
 */
- (void)p_setNavigationTabBarItem:(UITabBarItem *)tabBarItem {
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0]} forState:UIControlStateNormal];
    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -12);
}


@end
