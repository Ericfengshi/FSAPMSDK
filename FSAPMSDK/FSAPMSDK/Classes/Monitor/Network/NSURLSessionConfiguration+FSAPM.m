//
//  NSURLSessionConfiguration+FSAPM.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/29.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "NSURLSessionConfiguration+FSAPM.h"
#import <objc/runtime.h>
#import "FSURLProtocol.h"

/**
 hook 状态
 */
static BOOL isHookWorking = NO;

@implementation NSURLSessionConfiguration (FSAPM)

#pragma mark - Life Cycle
/**
 swizzle method
 */
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 避免使用私有 APIm，不过审
        Class cls = NSClassFromString([NSString stringWithFormat:@"%@%@%@", @"__NSCFU", @"RLSessionCon", @"figuration"]) ?: NSClassFromString(@"NSURLSessionConfiguration");
        Method origMethod = class_getInstanceMethod(cls, @selector(protocolClasses));
        Method replMethod = class_getInstanceMethod(self, @selector(fs_protocolClasses));
        if (origMethod && replMethod) {
            if (class_addMethod(cls, @selector(protocolClasses), method_getImplementation(replMethod), method_getTypeEncoding(replMethod))) {
                class_replaceMethod(self, @selector(fs_protocolClasses), method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
            } else {
                method_exchangeImplementations(origMethod, replMethod);
            }
        }
    });
    
}

#pragma mark - Public Method
/**
 开启 hook
 */
+ (void)start {
    isHookWorking = YES;
}

/**
 关闭 hook
 */
+ (void)stop {
    isHookWorking = NO;
}

#pragma mark - Private Method
/**
 将 FSURLProtocol 对象放在首位

 @return NSArray<NSURLProtocol>
 */
- (NSArray<Class> *)fs_protocolClasses {
    if (!isHookWorking) {
        return [self fs_protocolClasses];
    }
    NSMutableArray *array = [[self fs_protocolClasses] mutableCopy];
    if (array.count == 0) {
        return @[[FSURLProtocol class]];
    }
    if (![array containsObject:[FSURLProtocol class]]) {
        [array insertObject:[FSURLProtocol class] atIndex:0];
    }
    
    return array;
}

@end
