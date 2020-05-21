//
//  FSBayMaxCrashInfo.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/25.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSBayMaxCrashInfo.h"

@implementation FSBayMaxCrashInfo

#pragma mark - Life Cycle
/**
 初始化
 
 @param exceptionMessage 异常消息
 @param exceptionCategory 防护级别
 @param extraInfo 扩展内容
 */
- (instancetype)initWithCrashException:(NSString *)exceptionMessage exceptionCategory:(FSProtectorCategory)exceptionCategory extraInfo:(nullable NSDictionary *)extraInfo {
    if (self = [super init]) {
        _protectorType = exceptionCategory;
        _callStackSymbols = exceptionMessage;
        _userInfo = extraInfo;
        _date = [NSDate date];
    }
    return self;
}

#pragma mark - Public Method
/**
 获取 防护异常消息

 @return NSString
 */
- (NSString *)bayMaxCrashInfoMessage {
    return nil;
}

@end
