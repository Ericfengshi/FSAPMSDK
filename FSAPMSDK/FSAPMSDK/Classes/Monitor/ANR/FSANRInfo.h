//
//  FSANRInfo.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/24.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSANRInfo : NSObject

/**
 时间戳
 */
@property (nonatomic, assign) NSTimeInterval time;

/**
 卡顿时间
 */
@property (nonatomic, strong) NSDate *date;

/**
 卡顿线程
 */
@property (nonatomic, strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
