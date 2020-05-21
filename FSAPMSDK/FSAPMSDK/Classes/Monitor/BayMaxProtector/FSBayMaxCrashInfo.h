//
//  FSBayMaxCrashInfo.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/25.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Before start JJException,must config the FSProtectorCategory
 
 - FSProtectorNone: Do not guard normal crash exception
 - FSProtectorUnrecognizedSelector: Unrecognized Selector Exception
 - FSProtectorDictionaryContainer: NSDictionary,NSMutableDictionary
 - FSProtectorArrayContainer: NSArray,NSMutableArray
 - FSProtectorZombie: Zombie
 - FSProtectorKVOCrash: KVO exception
 - FSProtectorNSTimer: NSTimer
 - FSProtectorNSNotificationCenter: NSNotificationCenter
 - FSProtectorNSStringContainer:NSString,NSMutableString,NSAttributedString,NSMutableAttributedString
 - FSProtectorAllExceptZombie:Above All except Zombie
 - FSProtectorAll: Above All
 */
typedef NS_OPTIONS(NSInteger, FSProtectorCategory){
    FSProtectorNone = 0,
    FSProtectorUnrecognizedSelector = 1 << 1,
    FSProtectorDictionaryContainer = 1 << 2,
    FSProtectorArrayContainer = 1 << 3,
    FSProtectorZombie = 1 << 4,
    FSProtectorKVOCrash = 1 << 5,
    FSProtectorNSTimer = 1 << 6,
    FSProtectorNSNotificationCenter = 1 << 7,
    FSProtectorNSStringContainer = 1 << 8,
    FSProtectorAllExceptZombie = FSProtectorUnrecognizedSelector | FSProtectorDictionaryContainer | FSProtectorArrayContainer | FSProtectorKVOCrash | FSProtectorNSTimer | FSProtectorNSNotificationCenter | FSProtectorNSStringContainer,
    FSProtectorAll = FSProtectorUnrecognizedSelector | FSProtectorDictionaryContainer | FSProtectorArrayContainer | FSProtectorZombie | FSProtectorKVOCrash | FSProtectorNSTimer | FSProtectorNSNotificationCenter | FSProtectorNSStringContainer,
};

NS_ASSUME_NONNULL_BEGIN

@interface FSBayMaxCrashInfo : NSObject

/**
 时间
 */
@property (nonatomic, strong) NSDate *date;

/**
 异常防护类型
 */
@property (nonatomic, assign) FSProtectorCategory protectorType;

/**
 crash 线程的调用栈
 */
@property (nonatomic, copy) NSString *callStackSymbols;

/**
 扩展信息
 */
@property (nonatomic, copy) NSDictionary *userInfo;

/**
 初始化
 
 @param exceptionMessage 异常消息
 @param exceptionCategory 防护级别
 @param extraInfo 扩展内容
 */
- (instancetype)initWithCrashException:(NSString *)exceptionMessage exceptionCategory:(FSProtectorCategory)exceptionCategory extraInfo:(nullable NSDictionary *)extraInfo;

/**
 获取 防护异常消息
 
 @return NSString
 */
- (NSString *)bayMaxCrashInfoMessage;

@end

NS_ASSUME_NONNULL_END
