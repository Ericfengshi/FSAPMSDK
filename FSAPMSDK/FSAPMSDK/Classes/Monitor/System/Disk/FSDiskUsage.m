//
//  FSDiskUsage.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSDiskUsage.h"

@implementation FSDiskUsage

#pragma mark - Public Methods
/**
 磁盘总空间
 
 @return byte
 */
+ (unsigned long long)getDiskTotalSize {
    NSDictionary<NSFileAttributeKey, id> *directory = [self p_getFileAttributeDic];
    if (directory) {
        return [[directory objectForKey:NSFileSystemSize] unsignedLongLongValue];
    }
    return 0;
}

/**
 磁盘已使用空间
 
 @return byte
 */
+ (unsigned long long)getDiskUsedSize {
    NSDictionary<NSFileAttributeKey, id> *directory = [self p_getFileAttributeDic];
    if (directory) {
        unsigned long long fileSystemSize = [[directory objectForKey:NSFileSystemSize] unsignedLongLongValue];
        unsigned long long fileSystemFreeSize = [[directory objectForKey:NSFileSystemFreeSize] unsignedLongLongValue];
        unsigned long long fileSystemUsedSize = fileSystemSize - fileSystemFreeSize;
        return fileSystemUsedSize;
    }
    return 0;
}

/**
 磁盘可用空间大小
 
 @return byte
 */
+ (unsigned long long)getDiskFreeSize {
    NSDictionary<NSFileAttributeKey, id> *directory = [self p_getFileAttributeDic];
    if (directory) {
        return [[directory objectForKey:NSFileSystemFreeSize] unsignedLongLongValue];
    }
    return 0;
}

/**
 获取文件大小
 
 @param filePath 文件路径
 @return byte
 */
+ (unsigned long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        return 0;
    }
    return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}

/**
 获取文件夹下所有文件的大小
 
 @param folderPath 文件夹路径
 @return byte
 */
+ (unsigned long long)folderSizeAtPath:(NSString *)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *filesEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    unsigned long long folerSize = 0;
    while ((fileName = [filesEnumerator nextObject]) != nil) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        folerSize += [self fileSizeAtPath:filePath];
    }
    return folerSize;
}

#pragma mark - Private Methods
/**
 获取磁盘空间字典
 
 @return NSDictionary<NSFileAttributeKey, id>
 */
+ (nullable NSDictionary<NSFileAttributeKey, id> *)p_getFileAttributeDic {
    NSError *error;
    NSDictionary *directory = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
        return nil;
    }
    return directory;
}

@end
