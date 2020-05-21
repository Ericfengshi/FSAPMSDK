//
//  FSBackTraceInfo.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/29.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSBackTraceInfo : NSObject

+ (NSString *)fs_backtraceOfAllThread;
+ (NSString *)fs_backtraceOfCurrentThread;
+ (NSString *)fs_backtraceOfMainThread;
+ (NSString *)fs_backtraceOfNSThread:(NSThread *)thread;

@end

NS_ASSUME_NONNULL_END
