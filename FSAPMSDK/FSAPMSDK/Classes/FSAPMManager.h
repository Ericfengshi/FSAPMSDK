//
//  FSAPMManager.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSAPMManager : NSObject

/**
 单例对象
 
 @return FSAPMManager
 */
+ (FSAPMManager *)sharedInstance;

/**
 开启管理
 */
- (void)start;

/**
 关闭管理
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
