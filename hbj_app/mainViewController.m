//
//  mainViewController.m
//  hbj_app
//
//  Created by eidision on 14/12/21.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "mainViewController.h"
#import "homemapViewController.h"
#import "hometableViewController.h"
#import "homedataViewController.h"
#import "homehistoryViewController.h"
#import "newsTableViewController.h"
#import "plistOperation.h"

@interface mainViewController ()

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //地图Tab
    homemapViewController *mapViewController = [[homemapViewController alloc] init];
    UINavigationController *homemapNav = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    //[mapViewController setTitle:@"地图方式查看"];
    UITabBarItem *mapTabBarItem = [[UITabBarItem alloc] initWithTitle:@"地图"
                                                                image:[[UIImage imageNamed:@"home_map"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                        selectedImage:[[UIImage imageNamed:@"home_map_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [mapViewController setTabBarItem:mapTabBarItem];
    
    //图表Tab
    hometableViewController *tableViewController = [[hometableViewController alloc] init];
    UINavigationController *hometableNav = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    [tableViewController setTitle:@"图表方式查看"];
    UITabBarItem *tableTabBarItem = [[UITabBarItem alloc] initWithTitle:@"曲线对比"
                                                                  image:[[UIImage imageNamed:@"home_table"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                          selectedImage:[[UIImage imageNamed:@"home_table_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tableViewController setTabBarItem:tableTabBarItem];
    
    //数据Tab
    homedataViewController *dataViewController = [[homedataViewController alloc] init];
    UINavigationController *homedataNav = [[UINavigationController alloc] initWithRootViewController:dataViewController];
    [dataViewController setTitle:@"数值方式查看"];
    UITabBarItem *dataTabBarItem = [[UITabBarItem alloc] initWithTitle:@"数据对比"
                                                                 image:[[UIImage imageNamed:@"home_data"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                         selectedImage:[[UIImage imageNamed:@"home_data_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [dataViewController setTabBarItem:dataTabBarItem];
    
    //历史Tab
    homehistoryViewController *historyViewController = [[homehistoryViewController alloc] init];
    UINavigationController *homehistoryNav = [[UINavigationController alloc] initWithRootViewController:historyViewController];
    [historyViewController setTitle:@"查看历史"];
    UITabBarItem *historyTabBarItem = [[UITabBarItem alloc] initWithTitle:@"历史对比"
                                                                    image:[[UIImage imageNamed:@"home_history"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                            selectedImage:[[UIImage imageNamed:@"home_history_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [historyViewController setTabBarItem:historyTabBarItem];
    
    //新闻Tab
    newsTableViewController *newsViewController = [[newsTableViewController alloc] init];
    UINavigationController *newshistoryNav = [[UINavigationController alloc] initWithRootViewController:newsViewController];
    [newsViewController setTitle:@"相关新闻"];
    UITabBarItem *newsTabBarItem = [[UITabBarItem alloc] initWithTitle:@"相关新闻"
                                                                    image:[[UIImage imageNamed:@"home_news"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                            selectedImage:[[UIImage imageNamed:@"home_news_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [newsViewController setTabBarItem:newsTabBarItem];
    
    NSArray *homeTabArray = @[homemapNav, hometableNav, homedataNav, homehistoryNav, newshistoryNav];
    
    //UITabBarController *homeTabBarController = [[UITabBarController alloc] init];
    //[homeTabBarController setViewControllers:homeTabArray animated:YES];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:41/255.0
                                                                                                       green:173/255.0
                                                                                                        blue:81/255.0
                                                                                                       alpha:1]}
                                             forState:UIControlStateSelected];
     //setTitleTextAttributes:];
     //[NSDictionarydictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal]];
    
    [self setViewControllers:homeTabArray animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showselectedItems:)
                                                 name:(@"showselectedItems")
                                               object:nil];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbackground"]]];
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbackground"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showselectedItems:(NSNotification *)notify
{
    NSArray *ids = notify.userInfo[@"ids"];
    NSString *itemnum = notify.userInfo[@"itemnum"];
    
    //plist
    /*[plistOperation createEditableCopyOfDatabaseIfNeeded:@"selectIDs.plist"];
    NSString *documentDirectory = [plistOperation applicationDocumentsDirectory];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"selectIDs.plist"];
    //不应该从资源文件中读取数据，资源文件中的数据没有更改，要从沙箱中的资源文件读取数据
    
    //NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithContentsOfFile:path];//从资源文件中加载内容
    
    [ids writeToFile:path atomically:YES];//原子性写入，要么全部写入成功，要么全部没写入*/
    
    [[NSUserDefaults standardUserDefaults] setObject:ids forKey:@"selectedIDs"];
    
    int topath = 0;
    //调到第几个页面
    switch ([itemnum intValue]) {
        case 0:
            topath = 1;
            break;
            
        case 1:
            topath = 2;
            break;
            
        case 2:
            topath = 4;
            break;
   
        default:
            break;
    }
    
    [self setSelectedIndex:topath];
}

/*- (void)createEditableCopyOfDatabaseIfNeeded {//拷贝CarsInfoList.plist文件到沙箱目录，只执行一次拷贝。
    // First, test for existence - we don't want to wipe out a user's DB
    //selectIDs.plist中有一个原始数据
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [self applicationDocumentsDirectory];
    NSString *writableDBPath = [documentDirectory stringByAppendingPathComponent:@"selectIDs.plist"];//在沙箱创建的数据库文件可以更改，若直接操作资源文件，不能更改数据
    
    BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];//是否存在该数据库文件
    
    if (!dbexits) {
        // The writable database does not exist, so copy the default to the appropriate location.
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"selectIDs.plist"];//得到资源（Resources）文件的路径
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }else{
            NSLog(@"selectIDs.plist拷贝成功");
        }
    }
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
