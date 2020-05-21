//
//  FSAPMLog.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/21.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSAPMLog.h"

#ifdef DEBUG
    FSAPMLogLevel apmLogLevel = FSAPMLogLevelInfo;
#else
    FSAPMLogLevel apmLogLevel = FSAPMLogLevelWarning;
#endif

@implementation FSAPMLog

/**
 debug 默认 FSAPMLogLevelInfo
 release 默认 FSAPMLogLevelWarning
 
 @param logLevel 错误级别
 */
+ (void)setAPMLogLevel:(FSAPMLogLevel)logLevel {
      apmLogLevel = logLevel;
}

@end
