//
//  FSNetworkInfo.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/29.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSNetworkInfo.h"

@implementation FSNetworkInfo

#pragma mark - Private Method
/**
 设置响应对象字符串
 */
- (void)p_parseReponseData {
    // 引用自https://github.com/coderyi/NetworkEye
    NSString *mimeType = _response.MIMEType;
    if ([mimeType isEqualToString:@"application/json"] || [mimeType isEqualToString:@"text/plain"] || [mimeType isEqualToString:@"text/html"]) {
        _responseData = [self p_responseJSONFromData:self.data];
    } else if ([mimeType isEqualToString:@"text/javascript"]) {
        // try to parse json if it is jsonp request
        NSString *jsonString = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
        // formalize string
        if ([jsonString hasSuffix:@")"]) {
            jsonString = [NSString stringWithFormat:@"%@;", jsonString];
        }
        if ([jsonString hasSuffix:@");"]) {
            NSRange range = [jsonString rangeOfString:@"("];
            if (range.location != NSNotFound) {
                range.location++;
                range.length = [jsonString length] - range.location - 2; // removes parens and trailing semicolon
                jsonString = [jsonString substringWithRange:range];
                NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                _responseData = [self p_responseJSONFromData:jsonData];
            }
        }
    } else if ([mimeType isEqualToString:@"application/xml"] || [mimeType isEqualToString:@"text/xml"]){
        NSString *xmlString = [[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding];
        if (xmlString && xmlString.length>0) {
            _responseData = xmlString;
        }
    }
}

/**
 将响应 NSData 转字符串
 
 @param data 响应对象
 @return NSString
 */
- (NSString *)p_responseJSONFromData:(NSData *)data {
    if (data == nil) {
        return nil;
    }
    NSError *error = nil;
    id returnValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"JSON Parsing Error: %@", error);
        return nil;
    }
    if (!returnValue || returnValue == [NSNull null]) {
        return nil;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:returnValue options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}


#pragma mark - Getters and Setters
/**
 设置请求对象

 @param request 请求
 */
- (void)setRequest:(NSURLRequest *)request {
    _request = request;
    
    _url = request.URL;
    _httpMethod = request.HTTPMethod;
    _requestAllHTTPHeaderFields = request.allHTTPHeaderFields;
    _httpBody = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
}

/**
 设置响应对象

 @param response 响应
 */
- (void)setResponse:(NSHTTPURLResponse *)response {
    _response = response;
    
    _MIMEType = response.MIMEType;
    _statusCode = response.statusCode;
    _expectedContentLength = response.expectedContentLength;
    _suggestedFilename = response.suggestedFilename;
    _responseAllHeaderFields = response.allHeaderFields;
}

/**
 设置日期

 @param data 日期
 */
- (void)setData:(NSData *)data {
    _data = data;
    
    [self p_parseReponseData];
}

@end
