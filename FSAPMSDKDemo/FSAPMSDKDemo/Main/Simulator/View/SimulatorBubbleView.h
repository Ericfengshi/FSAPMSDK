//
//  SimulatorBubbleView.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/12.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SimulatorBubbleViewDelegate;
@interface SimulatorBubbleView : UIWindow

@property (nonatomic, strong, readonly) UIButton *bubbleBtn;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, weak) id<SimulatorBubbleViewDelegate> bubbleDelegate;

/**
 显示窗体
 */
- (void)show;

/**
 隐藏窗体
 */
- (void)hide;

/**
 获取当前界面窗体
 
 @return UIWindow
 */
- (UIWindow *)getMainWindow;

@end

@protocol SimulatorBubbleViewDelegate <NSObject>

/**
 按钮点击事件

 @param bubbleView 悬浮框视图
 */
- (void)bubbleViewDidClicked:(SimulatorBubbleView *)bubbleView;

@end

NS_ASSUME_NONNULL_END
