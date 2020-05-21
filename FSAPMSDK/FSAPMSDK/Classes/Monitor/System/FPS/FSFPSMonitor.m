//
//  FSFPSMonitor.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSFPSMonitor.h"
#import "FSWeakProxy.h"

@interface FSFPSMonitor ()

/**
 委托回调对象集合
 */
@property (nonatomic, strong) NSHashTable *hashTable;

/**
 定时器
 */
@property (nonatomic, strong) CADisplayLink *displayLink;

/**
 CADisplayLink 上一次刷新时间
 */
@property (nonatomic, assign) NSTimeInterval lastUpdateTime;

/**
 CADisplayLink 刷新次数
 */
@property (nonatomic, assign) NSInteger count;

@end

@implementation FSFPSMonitor

#pragma mark - Life Cycle
/**
 单例对象
 
 @return FSFPSMonitor
 */
+ (instancetype)sharedInstance {
    static FSFPSMonitor *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化
 设置 FPS 检测间隔默认值

 @return instancetype
 */
- (instancetype)init {
    if (self = [super init]) {
        _lastUpdateTime = 0;
        _updateFPSInterval = 1.0;
    }
    return self;
}

/**
 对象释放
 */
- (void)dealloc {
    [self stop];
    [self p_removeAllDelegates];
}

#pragma mark - Action Method
/**
 CADisplayLink 定时回调方法
 
 @param displayLink 定时器
 */
- (void)updateFPSAction:(CADisplayLink *)displayLink {
    if (_lastUpdateTime == 0) {
        _lastUpdateTime = displayLink.timestamp;
    }
    _count++;
    NSTimeInterval interval = displayLink.timestamp - _lastUpdateTime;
    if (interval < _updateFPSInterval) {
        return;
    }
    _lastUpdateTime = displayLink.timestamp;
    float fps = _count/interval;
    _count = 0;
    
    for (id<FSFPSMonitorDelegate> delegate in _hashTable) {
        if ([delegate respondsToSelector:@selector(FPSMoitor:didUpdateFPS:)]) {
            [delegate FPSMoitor:self didUpdateFPS:fps];
        }
    }
}

#pragma mark - Public Method
/**
 委托对象添加监控
 
 @param delegate 委托对象
 */
- (void)addDelegate:(id<FSFPSMonitorDelegate>)delegate {
    [self.hashTable addObject:delegate];
}

/**
 委托对象去除监控
 
 @param delegate 委托对象
 */
- (void)removeDelegate:(id<FSFPSMonitorDelegate>)delegate {
    if ([self.hashTable containsObject:delegate]) {
        [self.hashTable removeObject:delegate];
    }
}

/**
 开启检测 FPS
 */
- (void)start {
    if (_displayLink) {
        return;
    }
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

/**
 关闭检测 FPS
 */
- (void)stop {
    if (!_displayLink) {
        return;
    }
    [self.displayLink invalidate];
    _displayLink = nil;
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
 定时器，按FPS 60计算，间隔时间为 1/60 = 16.7ms

 @return CADisplayLink
 */
- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:[FSWeakProxy proxyWithTarget:self] selector:@selector(updateFPSAction:)];
        if (@available(iOS 10, *)) {
            displayLink.preferredFramesPerSecond = 60;
        } else {
            displayLink.frameInterval = 1;
        }
        _displayLink = displayLink;
    }
    return _displayLink;
}

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
