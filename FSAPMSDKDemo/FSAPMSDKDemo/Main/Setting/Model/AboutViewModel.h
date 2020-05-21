//
//  AboutViewModel.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - static const/#define
extern NSString *const kAboutViewModelInfoKey;
extern NSString *const kAboutViewModelInfoValue;

@interface AboutViewModel : NSObject

/**
 设备相关信息
 */
@property (nonatomic, strong, readonly) NSMutableArray *sysInfoArray;

/**
 加载数据
 */
- (void)loadData;

@end

NS_ASSUME_NONNULL_END
