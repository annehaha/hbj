//
//  plistOperation.h
//  hbj_app
//
//  Created by eidision on 14/12/24.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface plistOperation : NSObject

+ (void)createEditableCopyOfDatabaseIfNeeded:(NSString *)plistName;
+ (NSString *)applicationDocumentsDirectory;

@end
