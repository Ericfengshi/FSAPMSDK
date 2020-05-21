//
//  FSURLProtocol.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/29.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FSURLProtocol;
@protocol FSURLProtocolDelegate <NSObject>

/**
 获取流量请求监控

 @param URLProtocol 连接协议对象
 */
- (void)URLProtocolDidCatchURLRequest:(FSURLProtocol *)URLProtocol;

@end

@interface FSURLProtocol : NSURLProtocol

/**
 URLConnection 连接对象
 */
@property (nonatomic, strong, readonly) NSURLConnection *fs_connection;

/**
 NSURLRequest 请求对象
 */
@property (nonatomic, strong, readonly) NSURLRequest *fs_request;

/**
 NSURLResponse 返回对象
 */
@property (nonatomic, strong, readonly) NSURLResponse *fs_response;

/**
 NSMutableData 接收对象
 */
@property (nonatomic, strong, readonly) NSMutableData *fs_receive_data;

/**
 请求开始时间
 */
@property (nonatomic, strong, readonly) NSDate *startDate;

/**
 请求结束时间
 */
@property (nonatomic, strong, readonly) NSDate *endDate;

/**
 是否 Hook NSURLSessionConfiguration 对象
 原因：由于NSURLSessionConfiguration 有 protocolClasses 属性，不走自定义 NSURLProtocol
 需 hook 方法将 FSURLProtocol 放入首位
 
 @param hook BOOL
 */
+ (void)setHookNSURLSessionConfiguration:(BOOL)hook;

/**
 开启委托监控

 @param delegate 委托对象
 */
+ (void)addDelegate:(id<FSURLProtocolDelegate>)delegate;

/**
 去除委托监控

 @param delegate 委托对象
 */
+ (void)removeDelegate:(id<FSURLProtocolDelegate>)delegate;


@end

NS_ASSUME_NONNULL_END
