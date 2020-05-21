//
//  SimulatorZombieViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/18.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorZombieViewController.h"
#import <FSAPMSDK/FSAPMSDK.h>

#pragma mark - static const/#define

@interface TestZombie : NSObject

- (void)test;

@end

@implementation TestZombie

- (void)test{
    
}

@end

@interface SimulatorZombieViewController ()

@end

@implementation SimulatorZombieViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_loadSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark - Action Methods
/**
 添加僵尸对象防护黑名单

 @param btn 按钮
 */
- (void)addZombieProtectorBtnClicked:(UIButton *)btn {
    [[FSBayMaxProtector sharedInstance] addZombieProtectorOnClasses:@[TestZombie.class]];
}

/**
 僵尸对象 调用测试
 
 @param btn 按钮
 */
- (void)testZombieBtnClicked:(UIButton *)btn {
    TestZombie *test = [TestZombie new];
    [test release];
    [test test];
}

#pragma mark - Private Methods
/**
 加载界面 UI
 */
- (void)p_loadSubViews {
    UIButton *addZombieProtectorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addZombieProtectorBtn setFrame:CGRectMake(0, 100, self.view.frame.size.width/2, 50)];
    [addZombieProtectorBtn setTitle:@"添加防护黑名单类" forState:UIControlStateNormal];
    [addZombieProtectorBtn setTitleColor:[UIColor colorWithRed:16/255.0 green:119/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [addZombieProtectorBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [addZombieProtectorBtn addTarget:self action:@selector(addZombieProtectorBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addZombieProtectorBtn];
    
    UIButton *testZombieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testZombieBtn setFrame:CGRectMake(self.view.frame.size.width/2, 100, self.view.frame.size.width/2, 50)];
    [testZombieBtn setTitle:@"调用僵尸类 TestZombie" forState:UIControlStateNormal];
    [testZombieBtn setTitleColor:[UIColor colorWithRed:16/255.0 green:119/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [testZombieBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [testZombieBtn addTarget:self action:@selector(testZombieBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testZombieBtn];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, self.view.frame.size.width - 20, 200)];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor darkTextColor];
    tipLabel.numberOfLines = 0;
    tipLabel.text = @"1、添加僵尸对象防护黑名单类集合\n2、实例化TestZombie对象，随后release该对象\n然后在调用这个已经释放的僵尸对象方法，-[testZombie(TestZombie) test];";
    [self.view addSubview:tipLabel];
}

@end
