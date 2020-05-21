//
//  FSAPMHttpDNS.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/28.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSAPMHttpDNS.h"
#import "PPDNSMapping.h"
#import "PPDNSReporter.h"

@interface PPDNSMappingManager (FSAPMCategory)

/**
 设置 DNS Mapping 字典对象
 
 @param mappingDic DNS Mapping 字典对象
 */
- (void)parseDNSMapping:(NSDictionary *)mappingDic;

@end

@interface FSAPMHttpDNS ()

/**
 委托回调对象集合
 */
@property (nonatomic, strong) NSHashTable *hashTable;

/**
 上报失效域名
 
 @param url 失败域名地址
 @param count 失败次数
 */
- (void)reportDNSFailedUrl:(NSString *)url count:(int64_t)count;

@end

@implementation FSAPMHttpDNS

#pragma mark - Life Cycle
/**
 单例对象
 
 @return FSAPMHttpDNS
 */
+ (instancetype)sharedInstance {
    static FSAPMHttpDNS *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 释放
 */
- (void)dealloc {
    [self p_removeAllDelegates];
}

#pragma mark - Public Method
/**
 上报失效域名
 
 @param url 失败域名地址
 @param count 失败次数
 */
- (void)reportDNSFailedUrl:(NSString *)url count:(int64_t)count {
    for (id<FSAPMHttpDNSDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(reportDNSFailedUrl:withFailedCount:)]) {
            [delegate reportDNSFailedUrl:url withFailedCount:count];
        }
    }
    
}

/**
 设置默认 DNS Mapping 字典对象
 
 @param DNSMapping Mapping 字典对象
 */
- (void)setDefaultDNSMapping:(NSDictionary *)DNSMapping {
    if (!DNSMapping) {
        return;
    }
    PPDNSMappingManager *ppDNS = [PPDNSMappingManager sharedInstance];
    if ([ppDNS respondsToSelector:@selector(parseDNSMapping:)]) {
        [ppDNS parseDNSMapping:DNSMapping];
    }
}

/**
 通过地址获取 IP
 
 @param url 地址
 @return NSString
 */
- (NSString *)getResolvedIpByUrl:(NSURL *)url {
    PPResolvedUrl *resolvedUrl = [[PPDNSMappingManager sharedInstance] resolveUrl:url];
    return resolvedUrl.resolvedUrl;
}

/**
 开启监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSAPMHttpDNSDelegate>)delegate {
    [self.hashTable addObject:delegate];
}

/**
 关闭监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSAPMHttpDNSDelegate>)delegate {
    if ([self.hashTable containsObject:delegate]) {
        [self.hashTable removeObject:delegate];
    }
}

#pragma mark - Private Method
/**
 关闭所有委托对象
 */
- (void)p_removeAllDelegates {
    [self.hashTable removeAllObjects];
}

#pragma mark - Getters and Setters
/**
 卡顿委托回调对象集合
 
 @return NSHashTable
 */
- (NSHashTable *)hashTable {
    if (!_hashTable) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    return _hashTable;
}

@end

@interface PPDNSReporter (FSAPMCategory)

/**
 上报失效 iP
 
 @param url 失败域名地址
 @param count 失败次数
 */
- (void)reportFailedUrl:(NSString*)url withFailedCount:(int64_t)count;

@end

@implementation PPDNSReporter (FSAPMCategory)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
/**
 上报失效域名
 
 @param url 失败域名地址
 @param count 失败次数
 */
- (void)reportFailedUrl:(NSString *)url withFailedCount:(int64_t)count {
    
    [[FSAPMHttpDNS sharedInstance] reportDNSFailedUrl:url count:count];
}
#pragma clang diagnostic pop

@end
