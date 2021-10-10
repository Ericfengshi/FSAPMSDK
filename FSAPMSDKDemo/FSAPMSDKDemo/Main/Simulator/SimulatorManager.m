//
//  SimulatorManager.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/12.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorManager.h"
#import "TabBarController.h"
#import "SimulatorDataViewController.h"
#import "SimulatorBubbleView.h"
#import <FSAPMSDK/FSAPMSDK.h>

#pragma mark - static const/#define
NSString *const kSimulatorManagerTitleKey  = @"titleKey";
NSString *const kSimulatorManagerDetailKey = @"detailKey";

@interface SimulatorManager ()<FSANRMonitorDelegate, FSCrashMonitorDelegate, FSBayMaxProtectorDelegate, FSNetworkMonitorDelegate, SimulatorBubbleViewDelegate>

/**
 悬浮框
 */
@property (nonatomic, strong) SimulatorBubbleView *bubbleView;

/**
 当前控制器界面
 */
@property (nonatomic, weak) UIViewController *presentViewController;


/**
 采集的监控数据个数
 */
@property (nonatomic, assign) NSInteger simulatorDataCount;

/**
 数据类型
 */
@property (nonatomic, assign, readwrite) SimulatorDataType dataType;

/**
 时间格式
 */
@property (nonatomic, strong) NSDateFormatter *dateFormatter;


@end

@implementation SimulatorManager

#pragma mark - Life Cycle
/**
 单例对象
 
 @return FSAPMManager
 */
+ (FSAPMManager *)sharedInstance {
    static FSAPMManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化
 
 @return FSNetworkMonitor
 */
- (instancetype)init {
    if (self = [super init]) {
        [self p_addDelegate];
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    }
    return self;
}

#pragma mark - Public Method
/**
 展现采集监控数据
 */
- (void)show {
    [self.bubbleView show];
}

/**
 展现悬浮框
 
 @param dataType 数据类型
 */
- (void)showWithDataType:(SimulatorDataType)dataType {
    self.dataType = dataType;
    self.presentViewController = nil;
    [self p_setBubbleBtuttonTitle];
    
    [self.bubbleView show];
}

/**
 隐藏
 */
- (void)hide {
    [self.bubbleView hide];
}

/**
 当前类型采集的数据集合
 
 @param dataType 数据类型
 @return NSArray
 */
- (NSArray *)dataInfoArrayWithDataType:(SimulatorDataType)dataType {
    switch (dataType) {
        case SimulatorDataANRType: {
            return self.ANRInfoArray;
            break;
        }
        case SimulatorDataCrashType: {
            return self.crashInfoArray;
            break;
        }
        case SimulatorDataBayMaxType: {
            return self.bayMaxInfoArray;
            break;
        }
        case SimulatorDataNetworkType: {
            return self.networkInfoArray;
            break;
        }
        default:
            return nil;
            break;
    }
}

/**
 获取当前控制器
 
 @return UIViewController
 */
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    resultVC = [self p_getTopViewController:rootViewController];
    while (resultVC.presentedViewController) {
        resultVC = [self p_getTopViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

/**
 递归获取当前ViewController
 
 @param vc 控制器
 @return UIViewController
 */
- (UIViewController *)p_getTopViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self p_getTopViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self p_getTopViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

#pragma mark - Private Method
/**
 添加监控回调
 */
- (void)p_addDelegate {
    
    FSANRMonitor *anr = [FSANRMonitor sharedInstance];
    [anr addDelegate:self];
    
    FSCrashMonitor *crash = [FSCrashMonitor sharedInstance];
    [crash addDelegate:self];
    
    FSBayMaxProtector *bayMax = [FSBayMaxProtector sharedInstance];
    [bayMax addDelegate:self];
    
    FSNetworkMonitor *network = [FSNetworkMonitor sharedInstance];
    [network addDelegate:self];
    
}

/**
 设置悬浮框按钮 title
 */
- (void)p_setBubbleBtuttonTitle {
    NSString *title = @"APM";
    if (self.simulatorDataCount > 0) {
        title = [NSString stringWithFormat:@"+ %d", (int)self.simulatorDataCount];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.bubbleView.bubbleBtn setTitle:title forState:UIControlStateNormal];
    });
}

#pragma mark - SimulatorBubbleViewDelegate
/**
 按钮点击事件
 
 @param bubbleView 悬浮框视图
 */
- (void)bubbleViewDidClicked:(SimulatorBubbleView *)bubbleView {
    if (self.simulatorDataCount == 0) {
        return;
    }
    UIViewController *topViewController = [self topViewController];
    if (!topViewController) {
        return;
    }
    if (!_presentViewController) {
        SimulatorDataViewController *dataVC = [[SimulatorDataViewController alloc] initWithDataType:self.dataType];
        dataVC.title = [NSString stringWithFormat:@"%@ Data", SimulatorDataTypeName(self.dataType)];
        _presentViewController = topViewController;
        [topViewController.navigationController pushViewController:dataVC animated:YES];
        bubbleView.isSelected = YES;
    } else {
        [topViewController.navigationController popToViewController:_presentViewController animated:YES];
        bubbleView.isSelected = NO;
        _presentViewController = nil;
    }
}

#pragma mark - FSANRMonitorDelegate
/**
 卡顿回调
 
 @param ANRMonitor 卡顿对象
 @param ANRInfo 卡顿日志
 */
- (void)ANRMonitor:(FSANRMonitor *)ANRMonitor didRecievedANRInfo:(FSANRInfo *)ANRInfo {
    
    NSString *date = [_dateFormatter stringFromDate:ANRInfo.date];
    NSString *title = [NSString stringWithFormat:@"ANR Date(%@)", date];
    [self.ANRInfoArray insertObject:@{kSimulatorManagerTitleKey : title,
                                          kSimulatorManagerDetailKey : ANRInfo.content,
                                          } atIndex:0];
    [self p_setBubbleBtuttonTitle];
}

#pragma mark - FSCrashMonitorDelegate

/**
 *  最新一次闪退标题
 */
#define kNewestCrashTitle @"apm_crashTitle"

/**
 *  最新一次闪退内容正文
 */
#define kNewestCrashValue @"apm_crashValue"

/**
 闪退回调
 
 @param crashMonitor 闪退监控对象
 @param exceptionInfo 闪退日志
 */
- (void)crashMonitor:(FSCrashMonitor *)crashMonitor didCatchExceptionInfo:(FSCrashInfo *)exceptionInfo {

    NSString *date = [_dateFormatter stringFromDate:exceptionInfo.date];
    NSString *title = [NSString stringWithFormat:@"Crash (%@) Date(%@)", exceptionInfo.name, date];
    NSString *detail = [NSString stringWithFormat:@"\n*** Exception Date: %@,\nTerminating app due to uncaught exception '%@', reason: '%@':\n*** First throw call stack:\n%@\n", date, exceptionInfo.name, exceptionInfo.reason, exceptionInfo.callBackTrace];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:title forKey:kNewestCrashTitle];
    [userDefault setObject:detail forKey:kNewestCrashValue];
    [userDefault synchronize];
    
    [self.crashInfoArray insertObject:@{kSimulatorManagerTitleKey : title,
                                      kSimulatorManagerDetailKey : detail,
                                      } atIndex:0];
    [self p_setBubbleBtuttonTitle];
}

#pragma mark - FSBayMaxProtectorDelegate
/**
 捕捉到防护 Crash 日志回调
 
 @param bayMaxProtector 返回对象
 @param crashInfo 异常对象
 */
- (void)bayMaxProtector:(FSBayMaxProtector *)bayMaxProtector handleCrashInfo:(FSBayMaxCrashInfo *)crashInfo {
    NSString *date = [_dateFormatter stringFromDate:crashInfo.date];
    NSString *title = [NSString stringWithFormat:@"BayMax Date(%@)", date];

    [self.bayMaxInfoArray insertObject:@{kSimulatorManagerTitleKey : title,
                                        kSimulatorManagerDetailKey : crashInfo.callStackSymbols,
                                        } atIndex:0];

    [self p_setBubbleBtuttonTitle];
}

#pragma mark - FSNetworkMonitorDelegate
/**
 网络监控回调
 
 @param monitor 监控对象
 @param networkInfo 流量数据
 */
- (void)networkMonitor:(FSNetworkMonitor *)monitor didCatchNetworkInfo:(FSNetworkInfo *)networkInfo {
    
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    NSString *date = [_dateFormatter stringFromDate:networkInfo.startDate];
    [mutableString appendFormat:@"Date:  %@\n", date];
    [mutableString appendFormat:@"During:  %.fms\n", networkInfo.during*1000];
    [mutableString appendFormat:@"Status:  %ld\n", (long)networkInfo.statusCode];
    [mutableString appendFormat:@"Method:  %@\n", networkInfo.httpMethod];
    [mutableString appendFormat:@"URL:  %@\n", networkInfo.url];
    [mutableString appendFormat:@"Body:  %@\n", networkInfo.httpBody];
    
    NSMutableString *requestAllHTTPHeaderFields = [NSMutableString string];
    [networkInfo.requestAllHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        [requestAllHTTPHeaderFields appendFormat:@"%@: %@\n",key,obj];
    }];
    [mutableString appendFormat:@"HTTPHeaderField:  %@\n\n", requestAllHTTPHeaderFields];
    [mutableString appendFormat:@"MimeType:  %@\n", networkInfo.MIMEType];
    [mutableString appendFormat:@"ContentLength:  %lldkb\n", networkInfo.expectedContentLength/1024];
    
    NSMutableString *responseAllHeaderFields = [NSMutableString string];
    [networkInfo.responseAllHeaderFields enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        [responseAllHeaderFields appendFormat:@"%@: %@\n",key,obj];
    }];
    [mutableString appendFormat:@"ResponseHeaderFields:  %@\n", responseAllHeaderFields];
    [mutableString appendFormat:@"ResponseData:  %@\n", networkInfo.responseData];

    NSString *title = [NSString stringWithFormat:@"Network Date(%@)", date];
    [self.networkInfoArray insertObject:@{kSimulatorManagerTitleKey : title,
                                          kSimulatorManagerDetailKey : mutableString,
                                          } atIndex:0];
    [self p_setBubbleBtuttonTitle];
}

#pragma mark - Getters and Setters
- (SimulatorBubbleView *)bubbleView {
    if (!_bubbleView) {
        SimulatorBubbleView *bubbleView = [[SimulatorBubbleView alloc] init];
        bubbleView.bubbleDelegate = self;
        [bubbleView.bubbleBtn setTitle:@"APM" forState:UIControlStateNormal];
        [bubbleView.bubbleBtn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        bubbleView.backgroundColor = [UIColor colorWithRed:0.97 green:0.30 blue:0.30 alpha:1.00];
        _bubbleView = bubbleView;
    }
    return _bubbleView;
}

- (NSMutableArray *)ANRInfoArray {
    if (!_ANRInfoArray) {
        _ANRInfoArray = [NSMutableArray array];
    }
    return _ANRInfoArray;
}

- (NSMutableArray *)crashInfoArray {
    if (!_crashInfoArray) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *title = [userDefault objectForKey:kNewestCrashTitle];
        NSString *detail = [userDefault objectForKey:kNewestCrashValue];
        if (title && ![title isEqualToString:@""]) {
            _crashInfoArray = [NSMutableArray arrayWithObjects:@{kSimulatorManagerTitleKey : title, kSimulatorManagerDetailKey : detail,}, nil];
        } else {
           _crashInfoArray = [NSMutableArray array];
        }
    }
    return _crashInfoArray;
}

- (NSMutableArray *)bayMaxInfoArray {
    if (!_bayMaxInfoArray) {
        _bayMaxInfoArray = [NSMutableArray array];
    }
    return _bayMaxInfoArray;
}

- (NSMutableArray *)networkInfoArray {
    if (!_networkInfoArray) {
        _networkInfoArray = [NSMutableArray array];
    }
    return _networkInfoArray;
}

- (NSInteger)simulatorDataCount {
    NSArray *dataArray = [self dataInfoArrayWithDataType:self.dataType];
    return dataArray.count;
}

@end
