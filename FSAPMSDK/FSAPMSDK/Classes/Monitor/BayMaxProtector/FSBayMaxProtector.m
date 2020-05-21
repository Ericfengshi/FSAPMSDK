//
//  FSBayMaxProtector.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/25.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSBayMaxProtector.h"
#import "JJException.h"

@interface FSBayMaxProtector () <JJExceptionHandle>

/**
 委托回调对象集合
 */
@property (nonatomic, strong) NSHashTable *hashTable;

/**
 是否启动防护
 */
@property (nonatomic, assign, readwrite) BOOL isRunning;

/**
 防护级别
 */
@property (nonatomic, assign, readwrite) FSProtectorCategory protectorType;

@end

@implementation FSBayMaxProtector

#pragma mark - Life Cycle
/**
 单例对象
 
 @return FSBayMaxProtector
 */
+ (FSBayMaxProtector *)sharedInstance  {
    static FSBayMaxProtector *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化
 
 @return instancetype
 */
- (instancetype)init {
    if (self = [super init]) {
        [JJException registerExceptionHandle:self];
    }
    return self;
}

/**
 释放
 */
- (void)dealloc {
    [self stop];
    [self p_removeAllDelegates];
}

#pragma mark - Public Method
/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSBayMaxProtectorDelegate>)delegate {
    [self.hashTable addObject:delegate];
}

/**
 委托对象去除监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSBayMaxProtectorDelegate>)delegate {
    if ([self.hashTable containsObject:delegate]) {
        [self.hashTable removeObject:delegate];
    }
}

/**
 开启监控
 */
- (void)start {
    if (!self.isRunning) {
        self.isRunning = YES;
        [JJException startGuardException];
    }
}

/**
 关闭监控
 */
- (void)stop {
    if (self.isRunning) {
        self.isRunning = NO;
        [JJException stopGuardException];
    }
}

/**
 配置 Crash 防护级别
 
 @param protectorType Crash 防护级别
 */
- (void)configBayMaxProtectorType:(FSProtectorCategory)protectorType {
    _protectorType = protectorType;
     [JJException configExceptionCategory:(JJExceptionGuardCategory)protectorType];
}

/**
 设置类野指针黑名单，自己添加的类野指针防护
 作用：一些特定的类是不适用于添加到zombie机制的，会发生崩溃（例如：NSBundle）
 使用：[self addZombieProtectorOnClasses:@[TestZombie.class]];
 
 @param objectClasses 要忽略的类的集合
 */
- (void)addZombieProtectorOnClasses:(NSArray *_Nonnull)objectClasses {
    [JJException addZombieObjectArray:objectClasses];
}

#pragma mark - Private Method
/**
 关闭所有委托对象
 */
- (void)p_removeAllDelegates {
    [self.hashTable removeAllObjects];
}

#pragma mark - JJExceptionHandle
/**
 防护捕捉异常回调

 @param exceptionMessage 异常消息
 @param info 扩展内容
 */
- (void)handleCrashException:(NSString*)exceptionMessage extraInfo:(nullable NSDictionary*)info {
    
}

/**
 防护捕捉异常回调

 @param exceptionMessage 异常消息
 @param exceptionCategory 防护级别
 @param extraInfo 扩展内容
 */
- (void)handleCrashException:(NSString *)exceptionMessage exceptionCategory:(JJExceptionGuardCategory)exceptionCategory extraInfo:(nullable NSDictionary *)extraInfo {
    FSBayMaxCrashInfo *crashInfo = [[FSBayMaxCrashInfo alloc] initWithCrashException:exceptionMessage exceptionCategory:(FSProtectorCategory)exceptionCategory extraInfo:extraInfo];
//    NSString *msg = [crashInfo bayMaxCrashInfoMessage];
    // msg 上报
    
    // 返回异常回调
    for (id<FSBayMaxProtectorDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(bayMaxProtector:handleCrashInfo:)]) {
            [delegate bayMaxProtector:self handleCrashInfo:crashInfo];
        }
    }
}

#pragma mark - Getters and Setters
/**
 委托回调对象集合
 
 @return NSHashTable
 */
- (NSHashTable *)hashTable {
    if (!_hashTable) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    return _hashTable;
}

@end
