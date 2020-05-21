//
//  SimulatorDataDetailViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/13.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorDataDetailViewController.h"

@interface SimulatorDataDetailViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation SimulatorDataDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadSubViews];
}

#pragma mark - Private Methods
- (void)p_loadSubViews {
    [self.view addSubview:self.textView];
    self.textView.text = self.text;
}

#pragma mark - Getters and Setters
- (UITextView *)textView {
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        textView.backgroundColor = [UIColor colorWithRed:253/255. green:246/255. blue:227/255. alpha:1];
        textView.editable = NO;
        textView.textColor = [UIColor colorWithRed:81/255. green:81/255. blue:81/255. alpha:1];
        textView.font = [UIFont systemFontOfSize:13];
        _textView = textView;
    }
    return _textView;
}

@end
