//
//  SimulatorTimerViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/15.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorTimerViewController.h"

@interface SimulatorTimerViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SimulatorTimerViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_loadData];
    [self p_loadSubViews];
}

#pragma mark - Action Methods
/**
 NSTimer方法
 */
- (void)timerMethod {
    NSLog(@"Timer tick");
}

#pragma mark - Private Methods
/**
 加载数据
 */
- (void)p_loadData {
    [self p_testTimer];
}

/**
 加载界面 UI
 */
- (void)p_loadSubViews {
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, self.view.frame.size.width - 20, 200)];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor darkTextColor];
    tipLabel.numberOfLines = 0;
    tipLabel.text = @"针对NSTimer的两个类方法进行保护\n一个是+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo\n另一个是scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo\n退出页面时，会自动invalid计时器";
    [self.view addSubview:tipLabel];
}

/**
 测试 NSTimer
 */
- (void)p_testTimer {
    if (self.isScheduledTimer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    } else {
        _timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
}

@end
