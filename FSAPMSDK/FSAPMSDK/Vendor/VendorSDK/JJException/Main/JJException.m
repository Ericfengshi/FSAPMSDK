//
//  JJException.m
//  JJException
//
//  Created by Jezz on 2018/7/21.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import "JJException.h"
#import "JJExceptionProxy.h"

@implementation JJException

+ (BOOL)exceptionWhenTerminate{
    return [JJExceptionProxy shareExceptionProxy].exceptionWhenTerminate;
}

+ (void)setExceptionWhenTerminate:(BOOL)exceptionWhenTerminate{
    [JJExceptionProxy shareExceptionProxy].exceptionWhenTerminate = exceptionWhenTerminate;
}

+ (void)startGuardException{
    [JJExceptionProxy shareExceptionProxy].isProtectException = YES;
}

+ (void)stopGuardException{
    [JJExceptionProxy shareExceptionProxy].isProtectException = NO;
}

+ (void)configExceptionCategory:(JJExceptionGuardCategory)exceptionGuardCategory{
    [JJExceptionProxy shareExceptionProxy].exceptionGuardCategory = exceptionGuardCategory;
}

+ (void)registerExceptionHandle:(id<JJExceptionHandle>)exceptionHandle{
    [JJExceptionProxy shareExceptionProxy].delegate = exceptionHandle;
}

+ (void)addZombieObjectArray:(NSArray*)objects{
    [[JJExceptionProxy shareExceptionProxy] addZombieObjectArray:objects];
}

@end
