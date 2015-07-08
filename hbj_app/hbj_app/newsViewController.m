//
//  newsViewController.m
//  hbj_app
//
//  Created by eidision on 15/1/6.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import "newsViewController.h"

@interface newsViewController ()
{
    UIWebView *webView;
}

@end

@implementation newsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbackground"]]];
    
    //left
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    UIButton *left_arrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 10, 18)];
    [left_arrow addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [left_arrow setBackgroundImage:[UIImage imageNamed:@"menu_left"] forState:UIControlStateNormal];
    [backButton addSubview:left_arrow];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    backButton.titleLabel.textColor = [UIColor whiteColor];
    backButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height + 20)];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    [self loadinfo];
}

-(void)loadinfo
{
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"OK" message:@"出错了" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alterview show];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
