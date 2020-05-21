//
//  FSAPMHttpDNS.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/28.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FSAPMHttpDNSDelegate <NSObject>

@optional
/**
 上报失效域名
 
 @param url 失败域名地址
 @param count 失败次数
 */
- (void)reportDNSFailedUrl:(NSString *)url withFailedCount:(int64_t)count;

@end

@interface FSAPMHttpDNS : NSObject

/**
 单例对象
 
 @return FSAPMHttpDNS
 */
+ (instancetype)sharedInstance;

/**
 设置默认 DNS Mapping 字典对象

 @param DNSMapping Mapping 字典对象
 */
- (void)setDefaultDNSMapping:(NSDictionary *)DNSMapping;

/**
 通过地址获取 IP
 
 @param url 地址
 @return NSString
 */
- (NSString *)getResolvedIpByUrl:(NSURL *)url;

/**
 添加委托对象
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSAPMHttpDNSDelegate>)delegate;

/**
 去掉委托对象
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSAPMHttpDNSDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
