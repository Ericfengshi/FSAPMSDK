//
//  FSAPMLog.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/21.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 日志标记
 
 - FSAPMLogFlagError: 错误
 - FSAPMLogFlagWarning: 警告
 - FSAPMLogFlagInfo: 信息
 - FSAPMLogFlagDebug: 测试
 - FSAPMLogFlagVerbose: 详情
 */
typedef NS_OPTIONS(NSUInteger, FSAPMLogFlag) {
    FSAPMLogFlagError   = (1 << 0),
    FSAPMLogFlagWarning = (1 << 1),
    FSAPMLogFlagInfo    = (1 << 2),
    FSAPMLogFlagDebug   = (1 << 3),
    FSAPMLogFlagVerbose = (1 << 4)
};

/**
 日志级别
 
 - FSAPMLogLevelOff: 不写日志
 - FSAPMLogLevelError: 错误
 - FSAPMLogLevelWarning: 警告
 - FSAPMLogLevelInfo: 信息
 - FSAPMLogLevelDebug: 测试
 - FSAPMLogLevelVerbose: 详情
 - FSAPMLogLevelAll: 全部
 */
typedef NS_ENUM(NSUInteger, FSAPMLogLevel){
    FSAPMLogLevelOff     = 0,
    FSAPMLogLevelError   = (FSAPMLogFlagError),
    FSAPMLogLevelWarning = (FSAPMLogLevelError | FSAPMLogFlagWarning),
    FSAPMLogLevelInfo    = (FSAPMLogLevelWarning | FSAPMLogFlagInfo),
    FSAPMLogLevelDebug   = (FSAPMLogLevelInfo | FSAPMLogFlagDebug),
    FSAPMLogLevelVerbose = (FSAPMLogLevelDebug | FSAPMLogFlagVerbose),
    FSAPMLogLevelAll     = NSUIntegerMax
};

#define FSAPMLogVerbose if (apmLogLevel & FSAPMLogFlagVerbose) NSLog
#define FSAPMLogDebug if (apmLogLevel & FSAPMLogFlagDebug) NSLog
#define FSAPMLogWarn if (apmLogLevel & FSAPMLogFlagWarning) NSLog
#define FSAPMLogInfo if (apmLogLevel & FSAPMLogFlagInfo) NSLog
#define FSAPMLogError if (apmLogLevel & FSAPMLogFlagError) NSLog

extern FSAPMLogLevel apmLogLevel;

@interface FSAPMLog: NSObject

/**
 debug 默认 FSAPMLogLevelInfo
 release 默认 FSAPMLogLevelWarning
 
 @param logLevel 错误级别
 */
+ (void)setAPMLogLevel:(FSAPMLogLevel)logLevel;

@end

NS_ASSUME_NONNULL_END
