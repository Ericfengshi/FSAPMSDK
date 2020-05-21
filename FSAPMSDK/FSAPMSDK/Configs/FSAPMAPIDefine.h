//
//  FSAPMAPIDefine.h
//  FSAPMSDK
//
//  Created by fengs on 2018/11/7.
//  Copyright © 2018 fengs. All rights reserved.
//

#ifndef FSAPMAPIDefine_h
#define FSAPMAPIDefine_h

#pragma mark - API接口配置

#pragma mark -API接口枚举类型
/**
 接口类型
 
 - FSAPMAPITypeUndefined: 未定义
 */
typedef NS_ENUM(NSInteger, FSAPMAPIType) {
    FSAPMAPITypeUndefined = 0x101,
};

/**
 *  网络协议前缀
 */
#define kAPIURLPrefix               @"https://"

/**
 *  接口域名 (127.0.0.1)
 */
#define kAPIURLDomain               @"127.0.0.1"

/**
 *  接口后缀
 */
#define kAPIURLSuffix               @"/public"

#endif /* FSAPMAPIDefine_h */
