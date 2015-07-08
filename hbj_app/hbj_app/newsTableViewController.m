//
//  newsTableViewController.m
//  hbj_app
//
//  Created by eidision on 14/12/27.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "newsTableViewController.h"
#import "plistOperation.h"
#import "newsTableViewCell.h"
#import "loginView.h"
#import "myNetworking.h"
#import "newsViewController.h"

@interface newsTableViewController ()
{
    NSMutableDictionary *building_type;
    NSTimer *timer;
}

@end

@implementation newsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbackground"]]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"相关新闻";
    self.navigationItem.titleView = titleLabel;
    
//    //right
//    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
//    [logoutButton setBackgroundImage:[UIImage imageNamed:@"quit"] forState:UIControlStateNormal];
//    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logoutButton];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].applicationFrame.size.width, 150)];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].applicationFrame.size.width * 4, 150);
    
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    self.tableView.tableHeaderView = scrollView;
    
    float _x = 0;
    for (int index = 1; index < 5; index ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + _x, 0, [UIScreen mainScreen].applicationFrame.size.width, 150)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"news_%d",index]];
        [scrollView addSubview:imageView];
        _x += 320;
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 130, [UIScreen mainScreen].applicationFrame.size.width, 20)];
    pageControl.numberOfPages = 4;
    pageControl.tag = 171;
    [self.tableView addSubview:pageControl];
    
    [self readFromPlist];
    
    self.tabBarItem.image = [UIImage imageNamed:@"home_news_selected"];
    
    //拿到idToName和Addr
    self.idToDetail = [[NSUserDefaults standardUserDefaults] objectForKey:@"idToNameAndAddr"];
}

#pragma mark - plist
-(void)readFromPlist
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"buildings" ofType:@"plist"];
    building_type = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //拿到selectedID
    self.idArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedIDs"];
    
    if (self.idArray) {
        //将selectedIDs清零
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"selectedIDs"];
        [self assignFornewsArray:YES];
    }else{
        [self assignFornewsArray:NO];
    }
}

#pragma mark -assign for newsArray
-(void) assignFornewsArray: (BOOL)fromID
{
    timer = [NSTimer scheduledTimerWithTimeInterval:7.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
    UIView *viewToUse = self.view;
    [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
    
    //get arrayinfo from server
    //here we get {id:title, text, url}
    NSString *base = @"news/user/";

    NSString *ask = [base stringByAppendingString:[NSString stringWithFormat:@"%@/", [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]]];
    NSString *request = @"";
    if (fromID) {// get from ids
        for (NSString *id in self.idArray) {
            request = [request stringByAppendingFormat:@"%@&", id];
        }

        request = [request substringToIndex:request.length - 1];

    }else{// get all
        request = @"all";
    }
    ask = [ask stringByAppendingString:request];

    self.newsArray = [[NSMutableArray alloc] init];
    [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
        
        NSArray *array = result;

        if (array) {
            for (int i = 0 ; i < array.count; i ++) {
                NSDictionary *temp = array[i];
                
                NSString *tid = [temp objectForKey:@"id"];
                NSString *title = [temp objectForKey:@"title"];
                NSString *text = [temp objectForKey:@"content"];
                NSString *url = [temp objectForKey:@"urls"];
                
                [self.newsArray addObject:@[tid, title, text, url]];
            }
        }
        
        [self.tableView reloadData];
        [DejalBezelActivityView removeViewAnimated:YES];
        [[self class] cancelPreviousPerformRequestsWithTarget:self];
        
        [timer invalidate];
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"newsCell";
    
    newsTableViewCell *cell = (newsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[newsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    //get portalID
    NSString *portalType = self.idToDetail[self.newsArray[indexPath.row][0]][2];//type
    //image
    cell.portalImage.image = [UIImage imageNamed:building_type[portalType]];
    
    NSString *title = self.newsArray[indexPath.row][1];
    cell.newsTitle.text = title;
    
    NSString *intro = self.newsArray[indexPath.row][2];
    cell.detailText.text = intro;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    newsViewController *tempnews = [[newsViewController alloc] init];
    tempnews.url = self.newsArray[indexPath.row][3];
    UINavigationController *tempnav = [[UINavigationController alloc] initWithRootViewController:tempnews];
    [self presentViewController:tempnav animated:YES completion:nil];
}

#pragma mark -logout
- (void) alertWithTitle:(NSString *)title withMsg:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"重试"
                                          otherButtonTitles:@"取消", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.idArray) {
            [self assignFornewsArray:YES];
        }else{
            [self assignFornewsArray:NO];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        
    }
    else{
        UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:171];
        //NSLog(@"%d", (int)scrollView.contentOffset.x / 320);
        pageControl.currentPage = scrollView.contentOffset.x / 320;
    }
}

- (void)timerFired {

    [self alertWithTitle:@"网络异常" withMsg:@"载入超时"];
    
    [DejalBezelActivityView removeViewAnimated:YES];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (timer) {
        [timer invalidate];
    }
}

@end
