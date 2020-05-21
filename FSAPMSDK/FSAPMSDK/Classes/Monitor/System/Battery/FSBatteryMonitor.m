//
//  FSBatteryMonitor.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSBatteryMonitor.h"

@interface FSBatteryMonitor ()

/**
 委托回调对象集合
 */
@property (nonatomic, strong) NSHashTable *hashTable;

/**
 是否开启电池监控
 */
@property (nonatomic, assign) BOOL monitoringEnabled;

@end

@implementation FSBatteryMonitor

#pragma mark - Life Cycle
/**
 单例对象
 
 @return FSBatteryMonitor
 */
+ (instancetype)sharedInstance {
    static FSBatteryMonitor *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化

 @return FSBatteryMonitor
 */
- (instancetype)init {
    if (self = [super init]) {
        // 默认不监控电池变化
        [self p_setSystemBatteryMonitoringEnabled:NO];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(batteryLevelDidChange)
                                                     name: UIDeviceBatteryLevelDidChangeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(batteryStateDidChange)
                                                     name: UIDeviceBatteryStateDidChangeNotification
                                                   object: nil];
    }
    return self;
}

/**
 对象释放
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stop];
    [self p_removeAllDelegates];
}

#pragma mark - NSNotificationCenter
/**
 电量发生变化
 */
- (void)batteryLevelDidChange {
    [self p_batteryDidChange];
}

/**
 电池发生变化，充电、充满、不充电、未知
 */
- (void)batteryStateDidChange {
    [self p_batteryDidChange];
}

#pragma mark - Public Method
/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSBatteryMonitorDelegate>)delegate {
    [self.hashTable addObject:delegate];
    // 立即更新
    if (self.monitoringEnabled) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //        if ([UIDevice currentDevice].batteryState != UIDeviceBatteryStateUnknown) {
            [self p_batteryDidChange];
            //        }
        });
    }
}

/**
 委托对象去除监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSBatteryMonitorDelegate>)delegate {
    if ([self.hashTable containsObject:delegate]) {
        [self.hashTable removeObject:delegate];
    }
}

/**
 开启检测电池
 */
- (void)start {
    if (!self.monitoringEnabled) {
        self.monitoringEnabled = YES;
        [self p_setSystemBatteryMonitoringEnabled:YES];
        // 立即更新
        if ([UIDevice currentDevice].batteryState != UIDeviceBatteryStateUnknown) {
            [self p_batteryDidChange];
        }
    }
}

/**
 关闭检测电池
 */
- (void)stop {
    if (self.monitoringEnabled) {
        self.monitoringEnabled = NO;
        [self p_setSystemBatteryMonitoringEnabled:NO];
    }
}

#pragma mark - Private Method
/**
 关闭所有委托对象
 */
- (void)p_removeAllDelegates {
    [self.hashTable removeAllObjects];
}

/**
 电池发生变化
 */
- (void)p_batteryDidChange {
    CGFloat batteryLevel = [[UIDevice currentDevice] batteryLevel];
    NSString *status = @"";
    switch ([[UIDevice currentDevice] batteryState]) {
        case UIDeviceBatteryStateCharging:
            if (batteryLevel == 1) {
                status = @"Fully charged";
            } else {
                status = @"Charging";
            }
            break;
        case UIDeviceBatteryStateFull:
            status = @"Fully charged";
            break;
        case UIDeviceBatteryStateUnplugged:
            status = @"Unplugged";
            break;
        case UIDeviceBatteryStateUnknown:
            status = @"Unknown";
            break;
    }
    FSBatteryInfo *batteryInfo = [[FSBatteryInfo alloc] initWithBatteryLevel:batteryLevel status:status];
    if (self.monitoringEnabled) {
        for (id<FSBatteryMonitorDelegate> delegate in _hashTable) {
            if ([delegate respondsToSelector:@selector(batteryMoitor:didUpdateBattery:)]) {
                [delegate batteryMoitor:self didUpdateBattery:batteryInfo];
            }
        }
    }
}

/**
 设置系统电池监控

 @param monitoringEnabled 是否监控
 */
- (void)p_setSystemBatteryMonitoringEnabled:(BOOL)monitoringEnabled {
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:monitoringEnabled];
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
