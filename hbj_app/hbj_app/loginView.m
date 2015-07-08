//
//  loginView.m
//  hbj_app
//
//  Created by eidision on 15/1/7.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import "loginView.h"
#import "DejalActivityView.h"
#import "myNetworking.h"
#import "mainViewController.h"
#import "plistOperation.h"

@interface loginView (){
    BOOL remember;
    NSInteger flag;
    int connected;
    NSTimer *timer;
}

@end

@implementation loginView

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.rememberMark setSelected:YES];
    remember = YES;
    
    flag = 5;
    
    NSString *documentDirectory = [plistOperation applicationDocumentsDirectory];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"logininfo.plist"];//不应该从资源文件中读取数据，资源文件中的数据没有更改，要从沙箱中的资源文件读取数据
    
    NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];//从资源文件中加载内容
    
    if (userInfoDic) {
        self.userName.text = userInfoDic[@"username"];
        self.userPwd.text = userInfoDic[@"password"];
    }
}

- (IBAction)remember:(id)sender {
    if (remember) {
        remember = NO;
        [self.rememberMark setSelected:NO];
    }
    else{
        remember = YES;
        [self.rememberMark setSelected:YES];
    }
}


- (IBAction)forget:(UIButton *)sender {
    [self alertWithTitle:@"找回密码" withMsg:@"未开放"];
}

- (IBAction)login:(id)sender {
    [self connectedToNetWork];
    if (connected == 0) {
        if ([self.userName.text isEqualToString:@""]) {
            [self alertWithTitle:@"账号异常" withMsg:@"请输入账号"];
        }else{
            [self postToServer];
            
            UIView *viewToUse = self.view;
            [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"登录中..." width:100];
        }
    }
    else if(connected == 1){
        [self alertWithTitle:@"网络异常" withMsg:@"网络未连接"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    //将账号密码存储在plist
    [plistOperation createEditableCopyOfDatabaseIfNeeded:@"logininfo.plist"];
    
    NSString *documentDirectory = [plistOperation applicationDocumentsDirectory];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"logininfo.plist"];//不应该从资源文件中读取数据，资源文件中的数据没有更改，要从沙箱中的资源文件读取数据
    NSMutableDictionary *logininfo;
    if (remember) {
        NSString *userID = [[NSUserDefaults standardUserDefaults] stringForKey:@"userid"];
        
        logininfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.userName.text, @"username", self.userPwd.text, @"password", userID, @"userid", nil];
        [logininfo writeToFile:path atomically:YES];
    }else{
        NSFileManager *appFileManager = [NSFileManager defaultManager];
        if ([appFileManager fileExistsAtPath:path]) {
            [appFileManager removeItemAtPath:path error:nil];
        }
    }
    
    if (timer) {
        [timer invalidate];
    }
}

-(void)postToServer
{
    //login url
    NSString *asktemp = @"users/login/";
    NSString *ask = [asktemp stringByAppendingString:[NSString stringWithFormat:@"%@/%@", self.userName.text, self.userPwd.text]];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [[myNetworking sharedClient] GET:ask
                           parameters:nil
                              success:^(AFHTTPRequestOperation *operation, id result){
                                  if (!operation.responseString) {
                                      //网络异常
                                      flag = 0;
                                  }else{
                                      NSMutableDictionary *loginInfo = result;
                                      NSString *state = [loginInfo objectForKey:@"message"];
                                      NSLog(@"state:%@", state);
                                      
                                      switch ([state intValue]) {
                                          case 3:
                                          {
                                              //{state:0, id:1}成功
                                              flag = 3;
                                              NSString *userid = [loginInfo objectForKey:@"userId"];
                                              
                                              [[NSUserDefaults standardUserDefaults] setValue:userid forKey:@"userid"];
                                              break;
                                          }
                                              
                                          case 1:
                                              //{state:1, id:1}密码错误
                                              flag = 1;
                                              
                                          case 2:
                                              //{state:2, id:1}账号不存在
                                              flag = 2;
                                          default:
                                              break;
                                      }
                                  }
                                  [self performSelector:@selector(removeActivityView) withObject:nil afterDelay:0.4];
                                  
                                  [timer invalidate];
                              } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                                  NSLog(@"%@", error);
                              }
     ];
}

- (void)timerFired {
    if (flag == 5) {
        [UIView animateWithDuration:0.3f animations:^{
            [self alertWithTitle:@"网络异常" withMsg:@"登陆超时"];
            
            [DejalBezelActivityView removeViewAnimated:YES];
            [[self class] cancelPreviousPerformRequestsWithTarget:self];
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)removeActivityView
{
    [DejalBezelActivityView removeViewAnimated:YES];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    
    //post账号密码
    //登陆成功
    switch (flag) {
        case 0:
        {
            [self alertWithTitle:@"登陆失败" withMsg:@"网络异常，请检查网络后重试"];
            break;
        }
        case 1:
        {
            [self alertWithTitle:@"登陆失败" withMsg:@"账号密码不匹配"];
            break;
        }
        case 2:
        {
            [self alertWithTitle:@"登陆失败" withMsg:@"账号不存在"];
            break;
        }
        case 3:
        {
            //successfully login
            mainViewController *mainview = [[mainViewController alloc] init];
            [self presentViewController:mainview animated:YES completion:nil];
            //[self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
}

- (void) alertWithTitle:(NSString *)title withMsg:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) connectedToNetWork {
    //检测网络是否可以连接
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                connected = 0;
                NSLog(@"network:YES");
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                connected = 1;
                NSLog(@"network:NO");
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (IBAction)touchView:(id)sender {
    [self.view endEditing:YES];
}
@end
