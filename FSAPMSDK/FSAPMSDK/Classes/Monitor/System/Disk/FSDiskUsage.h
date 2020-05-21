//
//  FSDiskUsage.h
//  FSAPMSDK
//
//  Created by fengs on 2019/1/22.
//  Copyright © 2019 fengs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSDiskUsage : NSObject

/**
 磁盘总空间

 @return byte
 */
+ (unsigned long long)getDiskTotalSize;

/**
 磁盘已使用空间
 
 @return byte
 */
+ (unsigned long long)getDiskUsedSize;

/**
 磁盘可用空间大小

 @return byte
 */
+ (unsigned long long)getDiskFreeSize;

/**
 获取文件大小

 @param filePath 文件路径
 @return byte
 */
+ (unsigned long long)fileSizeAtPath:(NSString *)filePath;

/**
 获取文件夹下所有文件的大小

 @param folderPath 文件夹路径
 @return byte
 */
+ (unsigned long long)folderSizeAtPath:(NSString *)folderPath;

@end

NS_ASSUME_NONNULL_END
