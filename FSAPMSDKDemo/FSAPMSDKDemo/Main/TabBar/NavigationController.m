//
//  NavigationController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.enableRightGesture = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self p_configureNavBarTheme];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    return self.enableRightGesture;
}

#pragma mark - Public Methods
/**
 override pushViewController (重载 pushViewController 方法)

 @param viewController 页面
 @param animated 是否开启动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - Private Methods
/**
 去掉导航栏底部阴影
 */
- (void)p_configureNavBarTheme {
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

@end
