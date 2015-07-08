//
//  AppDelegate.m
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "AppDelegate.h"
#import "loginView.h"
#import "plistOperation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:1.8];
    
    self.window =[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSString *documentDirectory = [plistOperation applicationDocumentsDirectory];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"logininfo.plist"];//不应该从资源文件中读取数据，资源文件中的数据没有更改，要从沙箱中的资源文件读取数据
    
    NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];//从资源文件中加载内容
    
    if (userInfoDic) {
        [[NSUserDefaults standardUserDefaults] setValue:userInfoDic[@"userid"] forKey:@"userid"];
    }
    
    loginView *loginview = [[loginView alloc] initWithNibName:@"loginView" bundle:nil];
    self.window.rootViewController = loginview;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
