//
//  plistOperation.m
//  hbj_app
//
//  Created by eidision on 14/12/24.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "plistOperation.h"

@implementation plistOperation

+ (void)createEditableCopyOfDatabaseIfNeeded:(NSString *)plistName
{//拷贝CarsInfoList.plist文件到沙箱目录，只执行一次拷贝。
    // First, test for existence - we don't want to wipe out a user's DB
    //selectIDs.plist中有一个原始数据
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [self applicationDocumentsDirectory];
    NSString *writableDBPath = [documentDirectory stringByAppendingPathComponent:plistName];//在沙箱创建的数据库文件可以更改，若直接操作资源文件，不能更改数据
    
    BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];//是否存在该数据库文件
    
    if (!dbexits) {
        // The writable database does not exist, so copy the default to the appropriate location.
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:plistName];//得到资源（Resources）文件的路径
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }else{
            NSLog(@"拷贝成功");
        }
    }
}

+ (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
