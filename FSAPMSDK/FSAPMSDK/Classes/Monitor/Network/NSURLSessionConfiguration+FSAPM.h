//
//  NSURLSessionConfiguration+FSAPM.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/29.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "NSURLSessionConfiguration+FSAPM.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSURLSessionConfiguration (FSAPM)

/**
 开启 hook
 */
+ (void)start;

/**
 关闭 hook
 */
+ (void)stop;

@end

NS_ASSUME_NONNULL_END
