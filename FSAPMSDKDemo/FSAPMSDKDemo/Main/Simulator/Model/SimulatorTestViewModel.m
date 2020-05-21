//
//  SimulatorTestViewModel.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/13.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorTestViewModel.h"

@interface SimulatorTestViewModel ()

/**
 数据类型
 */
@property (nonatomic, assign) SimulatorDataType dataType;

/**
 展现数据
 */
@property (nonatomic, strong, readwrite) NSArray *dataArray;

@end

@implementation SimulatorTestViewModel

/**
 初始化
 
 @param dataType 数据类型
 @return SimulatorDataViewController
 */
- (instancetype)initWithDataType:(SimulatorDataType)dataType {
    if (self = [super init]) {
        self.dataType = dataType;
        [self dataArray];
    }
    return self;
}

#pragma mark - Getters and Setters
- (NSArray *)dataArray {
    if (!_dataArray) {
        switch (self.dataType) {
            case SimulatorDataANRType: {
                _dataArray = @[
                               @"模拟卡顿",
                                ];
                break;
            }
            case SimulatorDataCrashType: {
                _dataArray = @[
                               @"模拟Exception Crash",
                               @"模拟Signal Crash",
                               ];
                break;
            }
            case SimulatorDataBayMaxType: {
                NSDictionary *dic1 = @{@"Unrecognized Selector 防护" : @[
                                              @"调用未定义方法",
                                              @"向null对象发送length消息",
                                              ]};
                NSDictionary *dic2 = @{@"Dictionary 防护" : @[
                                               @"赋值value为空@{key:nil} dictionaryWithObjects:forKeys:",
                                               @"赋值key为空@{nil:value} dictionaryWithObjects:forKeys:",
                                               @"赋值value为空@{key:nil} setObject:forKey:",
                                               @"赋值key为空@{nil:value} setObject:forKey:",
                                               @"删除key为空 removeObjectForKey:",
                                               ]};
                NSDictionary *dic3 = @{@"Array 防护" : @[
                                               @"对象赋空值@[nil] addObject:",
                                               @"数组越界取值 objectAtIndex:",
                                               @"数组越界删除object removeObjectAtIndex:",
                                               @"数组越界删除objects removeObjectsInRange:",
                                               @"数组越界添加object insertObject:atIndex:",
                                               @"数组越界添加objects insertObjects:atIndexes:",
                                               @"数组越界替换object replaceObjectAtIndex:",
                                               @"数组越界替换objects replaceObjectsInRange:withObjectsFromArray:",
                                               @"数组越界替换objects replaceObjectsAtIndexes:indexSetWithIndexesInRange:",
                                               ]};
                NSDictionary *dic4 = @{@"NSSet 防护" : @[
                                               @"对象赋空值 setWithObject:",
                                               @"对象赋空值 addObject:",
                                               @"删除空值 removeObject:",
                                               ]};
                NSDictionary *dic5 = @{@"NSString 防护" : @[
                                               @"取值越界 characterAtIndex:",
                                               @"取值越界 substringFromIndex:",
                                               @"取值越界 substringToIndex:",
                                               @"取值越界 substringWithRange:",
                                               @"取值越界 replaceCharactersInRange:withString:",
                                               @"取值越界 insertString:atIndex:",
                                               @"取值越界 deleteCharactersInRange:",
                                               ]};
                NSDictionary *dic6 = @{@"NSAttributedString 防护" : @[
                                               @"对象赋空值 initWithString:",
                                               @"取值越界 attributedSubstringFromRange:",
                                               @"取值越界 attribute:atIndex:effectiveRange:",
                                               @"取值越界 enumerateAttribute:inRange:options:usingBlock:",
                                               @"取值越界 enumerateAttributesInRange:options:usingBlock:",
                                               
                                               @"对象赋空值 initWithString:attributes:",
                                               @"赋值越界 addAttribute:value:range:",
                                               @"赋值越界 addAttributes:range:",
                                               @"赋值越界 setAttributes:range:",
                                               @"删除越界 removeAttribute:range:",
                                               @"删除越界 deleteCharactersInRange:",
                                               @"替换越界、替换对象为nil replaceCharactersInRange:withString:",
                                               @"替换越界 replaceCharactersInRange:withAttributedString:",
                                               ]};
                NSDictionary *dic7 = @{@"Zombie 防护" : @[
                                               @"给僵尸对象发消息"
                                               ]};
                NSDictionary *dic8 = @{@"KVO 防护(异常上报暂缺)" : @[
                                               @"keypath重复监听",
                                               @"移除了未注册的观察者",
                                               @"移除了不存在的keypath",
                                               @"keypath重复移除",
                                               ]};
                NSDictionary *dic9 = @{@"NSTimer 防护" : @[
                                               @"进入下一个界面后返回 scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",
                                               @"进入下一个界面后返回 timerWithTimeInterval:target:selector:userInfo:repeats:",
                                               ]};
                NSDictionary *dic10 = @{@"NSNotification 防护(异常上报暂缺)" : @[
                                               @"进入下一个界面后返回",
                                               ]};
                _dataArray = @[
                               dic1,
                               dic2,
                               dic3,
                               dic4,
                               dic5,
                               dic6,
                               dic7,
                               dic8,
                               dic9,
                               dic10,
                               ];
                break;
            }
            case SimulatorDataNetworkType: {
                _dataArray = @[
                               @"Baidu 一下",
                               @"获取 Beijing Time",
                               @"访问 Error(404)",
                               ];
                break;
            }
            default:
                _dataArray = [NSArray array];
                break;
        }
    }
    return _dataArray;
}

@end
