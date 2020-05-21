//
//  NSMutableArray+MutableArrayHook.m
//  JJException
//
//  Created by Jezz on 2018/7/15.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import "NSMutableArray+MutableArrayHook.h"
#import "NSObject+SwizzleHook.h"
#import "JJExceptionProxy.h"

@implementation NSMutableArray (MutableArrayHook)

+ (void)jj_swizzleNSMutableArray{
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:), @selector(hookObjectAtIndex:));
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(subarrayWithRange:), @selector(hookSubarrayWithRange:));
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndexedSubscript:), @selector(hookObjectAtIndexedSubscript:));
    
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:), @selector(hookAddObject:));
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(insertObject:atIndex:), @selector(hookInsertObject:atIndex:));
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(insertObjects:atIndexes:), @selector(hookInsertObjects:atIndexes:));
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObjectAtIndex:), @selector(hookRemoveObjectAtIndex:));
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(replaceObjectAtIndex:withObject:), @selector(hookReplaceObjectAtIndex:withObject:));
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(replaceObjectsAtIndexes:withObjects:), @selector(hookReplaceObjectsAtIndexes:withObjects:));
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(replaceObjectsInRange:withObjectsFromArray:), @selector(hookReplaceObjectsInRange:withObjectsFromArray:));
    swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObjectsInRange:), @selector(hookRemoveObjectsInRange:));
    
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(objectAtIndex:), @selector(hookObjectAtIndex:));
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(subarrayWithRange:), @selector(hookSubarrayWithRange:));
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(objectAtIndexedSubscript:), @selector(hookObjectAtIndexedSubscript:));
    
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(addObject:), @selector(hookAddObject:));
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(insertObject:atIndex:), @selector(hookInsertObject:atIndex:));
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(insertObjects:atIndexes:), @selector(hookInsertObjects:atIndexes:));
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(removeObjectAtIndex:), @selector(hookRemoveObjectAtIndex:));
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(replaceObjectAtIndex:withObject:), @selector(hookReplaceObjectAtIndex:withObject:));
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(replaceObjectsAtIndexes:withObjects:), @selector(hookReplaceObjectsAtIndexes:withObjects:));
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(replaceObjectsInRange:withObjectsFromArray:), @selector(hookReplaceObjectsInRange:withObjectsFromArray:));
    swizzleInstanceMethod(NSClassFromString(@"__NSCFArray"), @selector(removeObjectsInRange:), @selector(hookRemoveObjectsInRange:));
}

- (void) hookAddObject:(id)anObject {
    if (anObject) {
        [self hookAddObject:anObject];
    }else{
        handleCrashException(JJExceptionGuardArrayContainer,@"NSMutableArray addObject nil object");
    }
}
- (id) hookObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self hookObjectAtIndex:index];
    }
    handleCrashException(JJExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray objectAtIndex invalid index:%tu total:%tu",index,self.count]);
    return nil;
}
- (id) hookObjectAtIndexedSubscript:(NSInteger)index {
    if (index < self.count) {
        return [self hookObjectAtIndexedSubscript:index];
    }
    handleCrashException(JJExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray objectAtIndexedSubscript invalid index:%tu total:%tu",index,self.count]);
    return nil;
}
- (void) hookInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && index <= self.count) {
        [self hookInsertObject:anObject atIndex:index];
    }else{
        handleCrashException(JJExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray insertObject invalid index:%tu total:%tu insert object:%@",index,self.count,anObject]);
    }
}

- (void)hookInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    if (indexes.firstIndex > self.count) {
        handleCrashException(JJExceptionGuardArrayContainer, [NSString stringWithFormat:@"NSMutableArray insertObjects:atIndexes: index %ld in index set beyond bounds [0 .. %ld]", (unsigned long)indexes.firstIndex, (unsigned long)self.count]);
    } else if (objects.count != (indexes.count)) {
        handleCrashException(JJExceptionGuardArrayContainer, [NSString stringWithFormat:@"NSMutableArray insertObjects:atIndexes: count of array (%ld) differs from count of index set (%ld)", (unsigned long)objects.count, (unsigned long)indexes.count]);
    } else {
        [self hookInsertObjects:objects atIndexes:indexes];
    }
}

- (void) hookRemoveObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self hookRemoveObjectAtIndex:index];
    }else{
        handleCrashException(JJExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray removeObjectAtIndex invalid index:%tu total:%tu",index,self.count]);
    }
}


- (void) hookReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < self.count && anObject) {
        [self hookReplaceObjectAtIndex:index withObject:anObject];
    }else{
        handleCrashException(JJExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray replaceObjectAtIndex invalid index:%tu total:%tu replace object:%@",index,self.count,anObject]);
    }
}

- (void)hookReplaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects {
    if (indexes.lastIndex >= self.count || indexes.firstIndex >= self.count) {
        handleCrashException(JJExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray replaceObjectsInRange:withObjects: range {%ld, %ld} extends beyond bounds [0 .. %ld]", (unsigned long)indexes.firstIndex, (unsigned long)indexes.count, (unsigned long)self.count]);
    } else {
        [self hookReplaceObjectsAtIndexes:indexes withObjects:objects];
    }
}

- (void)hookReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray {
    if (range.location + range.length > self.count) {
        handleCrashException(JJExceptionGuardArrayContainer, [NSString stringWithFormat:@"NSMutableArray replaceObjectsInRange:withObjectsFromArray: range {%ld, %ld} extends beyond bounds [0 .. %ld]", (unsigned long)range.location, (unsigned long)range.length, (unsigned long)self.count]);
    } else {
        [self hookReplaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
}

- (void) hookRemoveObjectsInRange:(NSRange)range {
    if (range.location + range.length <= self.count) {
        [self hookRemoveObjectsInRange:range];
    }else{
        handleCrashException(JJExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray removeObjectsInRange invalid range location:%tu length:%tu",range.location,range.length]);
    }
}

- (NSArray *)hookSubarrayWithRange:(NSRange)range
{
    if (range.location + range.length <= self.count){
        return [self hookSubarrayWithRange:range];
    }else if (range.location < self.count){
        return [self hookSubarrayWithRange:NSMakeRange(range.location, self.count-range.location)];
    }
    handleCrashException(JJExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray subarrayWithRange invalid range location:%tu length:%tu",range.location,range.length]);
    return nil;
}

@end
