//
//  SimulatorBubbleView.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/12.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorBubbleView.h"

#pragma mark - static const/#define
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kBubbleViewWidth 48
#define kBubbleViewHeight 48

#define kVerticalMargin 15
#define kHorizenMargin 5

@interface SimulatorBubbleView()

@property (nonatomic, strong, readwrite) UIButton *bubbleBtn;
@property (nonatomic, assign) CGFloat openAlpha;
@property (nonatomic, assign) CGFloat closeAlpha;

@end

@implementation SimulatorBubbleView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_loadSubViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bubbleBtn.frame = self.bounds;
}

#pragma mark - Action Methods
/**
 悬浮框按钮点击
 
 @param button 悬浮框按钮
 */
- (void)bubbleBtnClicked:(UIButton *)button {
    if (self.bubbleDelegate && [self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidClicked:)]) {
        [self.bubbleDelegate bubbleViewDidClicked:self];
    }
}

/**
 移动悬浮框位置
 
 @param p 手势对象
 */
- (void)panGestureClicked:(UIPanGestureRecognizer *)p {
    UIWindow *appWindow = [self getMainWindow];
    CGPoint panPoint = [p locationInView:appWindow];
    
    if (p.state == UIGestureRecognizerStateBegan) {
        self.alpha = 1;
    } else if(p.state == UIGestureRecognizerStateChanged) {
        self.center = CGPointMake(panPoint.x, panPoint.y);
    } else if(p.state == UIGestureRecognizerStateEnded
              || p.state == UIGestureRecognizerStateCancelled) {
        self.alpha = _isSelected ? _openAlpha : _closeAlpha;
        [self p_layoutAnimateWithPosition:panPoint];
    }
}

#pragma mark - Public Methods
/**
 显示窗体
 */
- (void)show {
    self.alpha = _isSelected ? _openAlpha : _closeAlpha;
    UIWindow *keyWindow = [self getMainWindow];
    self.frame = CGRectMake(kScreenWidth - kBubbleViewWidth - kHorizenMargin, kScreenHeight - kBubbleViewHeight*5, kBubbleViewWidth, kBubbleViewHeight);
    if (!self.rootViewController) {
        self.rootViewController = [[UIViewController alloc]init];
    }
    self.layer.cornerRadius = self.frame.size.width <= self.frame.size.height ? self.frame.size.width / 2.0 : self.frame.size.height / 2.0;
    self.layer.masksToBounds = YES;
    if (self.bubbleBtn.superview) {
        [self.bubbleBtn removeFromSuperview];
    }
    [self makeKeyAndVisible];
    [self addSubview:self.bubbleBtn];
    [keyWindow makeKeyAndVisible];
}

/**
 隐藏窗体
 */
- (void)hide {
    self.hidden = YES;
}

/**
 获取当前界面窗体
 
 @return UIWindow
 */
- (UIWindow *)getMainWindow {
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = [app keyWindow];
    if (!window) {
        window = app.windows.firstObject;
    }
    return window;
}

#pragma mark - Private Methods
/**
 加载页面
 */
- (void)p_loadSubViews {
    self.windowLevel = UIWindowLevelAlert + 1;
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    _openAlpha = 0.5;
    _closeAlpha = 0.7;
    
    [self bubbleBtn];
}

/**
 重新计算悬浮框位置
 
 @param postion 位置
 */
- (void)p_layoutAnimateWithPosition:(CGPoint)postion {
    CGFloat ballWidth = self.frame.size.width;
    CGFloat ballHeight = self.frame.size.height;
    CGFloat screenWidth = kScreenWidth;
    CGFloat screenHeight = kScreenHeight;
    
    CGFloat left = fabs(postion.x);
    CGFloat right = fabs(screenWidth - left);
    
    CGFloat minSpace = MIN(left, right);
    CGPoint newCenter = CGPointZero;
    CGFloat targetY = 0;
    
    //Correcting Y
    if (postion.y < kVerticalMargin + ballHeight / 2.0) {
        targetY = kVerticalMargin + ballHeight / 2.0;
    } else if (postion.y > (screenHeight - ballHeight / 2.0 - kVerticalMargin)) {
        targetY = screenHeight - ballHeight / 2.0 - kVerticalMargin;
    } else{
        targetY = postion.y;
    }
    
    CGFloat centerXSpace = kHorizenMargin + ballWidth/2;
    if (minSpace == left) {
        newCenter = CGPointMake(centerXSpace, targetY);
    } else if (minSpace == right) {
        newCenter = CGPointMake(screenWidth - centerXSpace, targetY);
    }
    
    [UIView animateWithDuration:.25 animations:^{
        self.center = newCenter;
    }];
}

#pragma mark - Getters and Setters
- (UIButton *)bubbleBtn {
    if (!_bubbleBtn) {
        UIButton *bubbleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bubbleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [bubbleBtn addTarget:self action:@selector(bubbleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureClicked:)];
        panGesture.delaysTouchesBegan = YES;
        [bubbleBtn addGestureRecognizer:panGesture];
        _bubbleBtn = bubbleBtn;
    }
    return _bubbleBtn;
}

/**
 点击状态更新

 @param isSelected 是否点击
 */
- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.alpha = isSelected ? _openAlpha : _closeAlpha;
}

@end
