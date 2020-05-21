//
//  SimulatorNotificationViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/15.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorNotificationViewController.h"

@interface SimulatorNotificationViewController ()

@end

@implementation SimulatorNotificationViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_loadData];
    [self p_loadSubViews];
}

#pragma mark - Action Methods
/**
 通知方法
 */
- (void)notificationMethod {
    NSLog(@"notificationMethod");
}

#pragma mark - Private Methods
/**
 加载数据
 */
- (void)p_loadData {
    [self p_testNotification];
}

/**
 加载界面 UI
 */
- (void)p_loadSubViews {
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 200)];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor darkTextColor];
    tipLabel.numberOfLines = 0;
    tipLabel.text = @"针对NSNotificationCenter的防护不多，主要是在对象dealloc过程中自动帮你移除监听者\n实现过程：\nobserver对象 新增通知时 ————>(持有Associated对象) blockArray ————>(持有) stub\nobserver对象 dealloc时 ————>(调用_object_remove_associations 释放) blockArray————>(释放)stub  ————>(调用)removeObserver:";
    [self.view addSubview:tipLabel];
}

/**
 测试通知
 */
- (void)p_testNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationMethod) name:@"test" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
}

@end
