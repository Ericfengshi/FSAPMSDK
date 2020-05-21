//
//  FSURLProtocol.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/29.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSURLProtocol.h"
#import "NSURLSessionConfiguration+FSAPM.h"

#define kFSURLRequestKey @"FSURLRequestKey"

/**
 默认不注册 Protocol
 */
static BOOL isRegisterProtocol = NO;

/**
 默认 hook NSURLSessionConfiguration 对象
 */
static BOOL hookNSURLSessionConfiguration = YES;

@interface FSURLProtocol() <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

/**
 URLConnection 连接对象
 */
@property (nonatomic, strong, readwrite) NSURLConnection *fs_connection;

/**
 NSURLRequest 请求对象
 */
@property (nonatomic, strong, readwrite) NSURLRequest *fs_request;

/**
 NSURLResponse 返回对象
 */
@property (nonatomic, strong, readwrite) NSURLResponse *fs_response;

/**
 NSMutableData 接收对象
 */
@property (nonatomic, strong, readwrite) NSMutableData *fs_receive_data;

/**
 请求开始时间
 */
@property (nonatomic, strong, readwrite) NSDate *startDate;

/**
 请求结束时间
 */
@property (nonatomic, strong, readwrite) NSDate *endDate;

@end

@implementation FSURLProtocol

#pragma mark - Life Cycle

#pragma mark - Public Method
/**
 是否 Hook NSURLSessionConfiguration 对象
 原因：由于NSURLSessionConfiguration 有 protocolClasses 属性，不走自定义 NSURLProtocol
 需 hook 方法将 FSURLProtocol 放入首位
 
 @param hook BOOL
 */
+ (void)setHookNSURLSessionConfiguration:(BOOL)hook {
    hookNSURLSessionConfiguration = hook;
    if (!hook) {
        [NSURLSessionConfiguration stop];
    }
}

/**
 开启委托监控
 
 @param delegate 委托对象
 */
+ (void)addDelegate:(id<FSURLProtocolDelegate>)delegate {
    if (!delegate) {
        return;
    }
    [[self hashTable]addObject:delegate];
    if ([self hashTable].count > 0) {
        [self p_start];
    }
}

/**
 去除委托监控
 
 @param delegate 委托对象
 */
+ (void)removeDelegate:(id<FSURLProtocolDelegate>)delegate {
    if (!delegate) {
        return;
    }
    [[self hashTable]removeObject:delegate];
    if ([self hashTable].count == 0) {
        [self p_stop];
    }
}

#pragma mark - Private Method
/**
 开启监控
 */
+ (void)p_start {
    if (isRegisterProtocol) {
        return;
    }
    isRegisterProtocol = YES;
    [NSURLProtocol registerClass:self];
    if (hookNSURLSessionConfiguration) {
        [NSURLSessionConfiguration start];
    }
}

/**
 关闭监控
 */
+ (void)p_stop {
    if (!isRegisterProtocol) {
        return;
    }
    isRegisterProtocol = NO;
    [NSURLProtocol unregisterClass:self];
    if (hookNSURLSessionConfiguration) {
        [NSURLSessionConfiguration stop];
    }
}

#pragma mark - NSURLProtocol Method
/**
 根据 scheme 值是否拦截 request

 @param request 请求
 @return BOOL
 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if (![request.URL.scheme isEqualToString:@"http"]
        && ![request.URL.scheme isEqualToString:@"https"]) {
        return NO;
    }
    // 如果是已经拦截过，放行
    if ([NSURLProtocol propertyForKey:kFSURLRequestKey inRequest:request]) {
        return NO;
    }
    return YES;
}

/**
 自定义请求

 @param request 请求
 @return NSURLRequest
 */
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    NSString *host = request.URL.host;
    
    // HTTPDNS 直连 iP，host 帮助运营商解析
    if (host) {
       [mutableRequest setValue:host forHTTPHeaderField:@"HOST"];
    }
    // HTTPDNS 域名转 iP
    [NSURLProtocol setProperty:@(YES) forKey:kFSURLRequestKey inRequest:mutableRequest];
    return [mutableRequest copy];
}

/**
 开始请求
 */
- (void)startLoading {
    _startDate = [NSDate date];
    NSURLRequest *request = [[self class] canonicalRequestForRequest:self.request];
    self.fs_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    self.fs_request = self.request;
}

/**
 结束请求
 */
- (void)stopLoading {
    [self.fs_connection cancel];
    _endDate = [NSDate date];
    
    for (id<FSURLProtocolDelegate> delegate in [[self class]hashTable]) {
        if ([delegate respondsToSelector:@selector(URLProtocolDidCatchURLRequest:)]) {
            [delegate URLProtocolDidCatchURLRequest:self];
        }
    }
}

#pragma mark - NSURLConnectionDelegate
/**
 连接错误

 @param connection 连接对象
 @param error 错误原因
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

/**
 连接时是否使用证书

 @param connection 连接对象
 @return YES
 */
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
    return YES;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
/**
 连接身份验证 - 接收

 @param connection 连接对象
 @param challenge 身份验证挑战
 */
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [self.client URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}

/**
 连接身份验证 - 取消
 
 @param connection 连接对象
 @param challenge 身份验证挑战
 */
- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [self.client URLProtocol:self didCancelAuthenticationChallenge:challenge];
}
#pragma clang diagnostic pop

#pragma mark - NSURLConnectionDataDelegate
/**
 重定向响应请求

 @param connection 连接对象
 @param request 请求对象
 @param response 响应对象
 @return NSURLRequest
 */
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    if (response != nil) {
        self.fs_response = response;
        [self.client URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
    }
    return request;
}

/**
 接收到响应对象

 @param connection 连接对象
 @param response 响应对象
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    self.fs_response = response;
}

/**
 接收数据量

 @param connection 连接对象
 @param data 接收数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
    if (!self.fs_receive_data) {
        self.fs_receive_data = [NSMutableData dataWithData:data];
    }else {
        [self.fs_receive_data appendData:data];
    }
}

/**
 将缓存响应对象

 @param connection 连接对象
 @param cachedResponse 响应缓存
 @return NSCachedURLResponse
 */
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}

/**
 连接对象接收

 @param connection 连接对象
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[self client] URLProtocolDidFinishLoading:self];
}

#pragma mark - Getters and Setters
/**
 委托回调对象集合

 @return NSHashTable
 */
+ (NSHashTable *)hashTable {
    static NSHashTable<NSObject *> *hashTable = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hashTable = [NSHashTable weakObjectsHashTable];
    });
    return hashTable;
}

@end
