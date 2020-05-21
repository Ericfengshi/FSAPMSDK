//
//  FSCrashInfo.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 异常信号标记
 */
static const int kFSCrashException = -1;

@interface FSCrashInfo : NSObject

/**
 时间
 */
@property (nonatomic, strong) NSDate *date;

/**
 异常名称
 */
@property (nonatomic, strong) NSString *name;

/**
 异常原因
 */
@property (nonatomic, strong) NSString *reason;

/**
 异常
 */
@property (nonatomic, strong) NSException *exception;

/**
 -1 exception, other signal
 */
@property (nonatomic, assign) NSInteger signal;

/**
 线程堆栈
 */
@property (nonatomic, strong) NSString *callBackTrace;

@end

NS_ASSUME_NONNULL_END
