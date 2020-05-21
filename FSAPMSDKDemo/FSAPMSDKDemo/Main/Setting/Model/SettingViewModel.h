//
//  SettingViewModel.h
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/11.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingViewModel : NSObject

/**
 监控对象集合
 */
@property (nonatomic, strong, readonly) NSMutableArray *monitorInfoArray;

/**
 加载数据
 */
- (void)loadData;

@end

NS_ASSUME_NONNULL_END
