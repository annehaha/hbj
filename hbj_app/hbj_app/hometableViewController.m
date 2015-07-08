//
//  hometableViewController.m
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "hometableViewController.h"


@interface hometableViewController ()

@end

@implementation hometableViewController

@synthesize myScrollView;
@synthesize getArray;
@synthesize getArray2;
@synthesize nowTableBtn;
@synthesize hourTableBtn;
@synthesize dustButton;
@synthesize noiseButton;
@synthesize ids;

-  (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        
    }
    return self;
}

- (void)loadView
{
    UIView *baseview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view = baseview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"图表方式查看";
    self.navigationItem.titleView = titleLabel;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbackground"]]];
    
    //日均值Button
    nowTableBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 160, 30)];
    [nowTableBtn setTitle:@"实时数据" forState:UIControlStateNormal];
    //mapDayAverageButton.tag = 101;
    //[nowTableBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [nowTableBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nowTableBtn setBackgroundImage:[UIImage imageNamed:@"slide_button"] forState:UIControlStateSelected];
    nowTableBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [nowTableBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [nowTableBtn setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [nowTableBtn setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateSelected];
    [nowTableBtn addTarget:self action:@selector(nowBtn:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nowTableBtn];
    
    //时均值Button
    hourTableBtn= [[UIButton alloc] initWithFrame:CGRectMake(160, 70, 160, 30)];
    [hourTableBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //[hourTableBtn setBackgroundColor:[UIColor whiteColor]];
    [hourTableBtn setBackgroundImage:[UIImage imageNamed:@"slide_button"] forState:UIControlStateSelected];
    [hourTableBtn setTitle:@"小时数据" forState:UIControlStateNormal];
    //mapHourAverageButton.tag = 102;
    hourTableBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [hourTableBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [hourTableBtn setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [hourTableBtn setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateSelected];
    [hourTableBtn addTarget:self action:@selector(hourBtn:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hourTableBtn];
    
    
    noiseButton= [[UIButton alloc] initWithFrame:CGRectMake(70, 110, 90, 30)];
    [ noiseButton setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [ noiseButton setBackgroundImage:[UIImage imageNamed:@"left_chosen"] forState:UIControlStateSelected];
    [ noiseButton setTitle:@"噪声" forState:UIControlStateNormal];
    //mapHourAverageButton.tag = 102;
    noiseButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [ noiseButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [ noiseButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [ noiseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [ noiseButton addTarget:self action:@selector(noiseButton:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: noiseButton];
    //时均值Button
    dustButton= [[UIButton alloc] initWithFrame:CGRectMake(160, 110, 90, 30)];
    [dustButton setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [dustButton setBackgroundImage:[UIImage imageNamed:@"right_chosen"] forState:UIControlStateSelected];
    [dustButton setTitle:@"扬尘" forState:UIControlStateNormal];
    //mapHourAverageButton.tag = 102;
    dustButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [dustButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [dustButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [dustButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [dustButton addTarget:self action:@selector(dustButton:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dustButton];
    
    [nowTableBtn setSelected:YES];
    [noiseButton setSelected:YES];
    type=@"噪声";
    isRt=@"实时数据";
    
}

- (IBAction)noiseButton:(id)sender
{
    [myScrollView removeFromSuperview];
    type=@"噪声";
    [noiseButton setSelected:YES];
    [dustButton setSelected:NO];
    
    if([isRt isEqualToString:@"小时数据"]){
        [self loadChartHour];
    }
    else if([isRt isEqualToString:@"实时数据"]){
        [self loadChartNow];
    }
}

- (IBAction)dustButton:(id)sender
{
    [myScrollView removeFromSuperview];
    
    type=@"扬尘";
    
    [noiseButton setSelected:NO];
    [dustButton setSelected:YES];
    if([isRt isEqualToString:@"小时数据"]){
        [self loadChartHour];
    }
    else if([isRt isEqualToString:@"实时数据"]){
        [self loadChartNow];
    }
}


-(void)loadChartNow
{
    [myScrollView removeFromSuperview];
    //get realtime data info from web
    NSString *ask = @"rtdup/user/";
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    ask=[ask stringByAppendingString:userID];
    
    getArray = [[NSMutableArray alloc] init];
    getArray2 = [[NSMutableArray alloc] init];
    if([type  isEqualToString:@"噪声"]){
        UIView *viewToUse = self.view;
        [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
        
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            count=array.count;
            if(count>0){
                if([ids count]!=0){
                    for (int i = 0 ; i < count; i ++) {
                        NSDictionary *temp = array[i];
                        if(temp !=[NSNull null]&&[ids containsObject:[temp objectForKey:@"mdid"]]){
                            if([temp objectForKey:@"name"]&&[temp objectForKey:@"noise"]!=[NSNull null]){
                                [getArray2 addObject: [temp objectForKey:@"name"]];
                                NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"noise"] doubleValue]];
                                [getArray addObject: n];
                            }
                        }
                    }
                }
                else{
                    for (int i = 0 ; i < count; i ++) {
                        NSDictionary *temp = array[i];
                        if(temp !=[NSNull null]){
                            if([temp objectForKey:@"name"]&&[temp objectForKey:@"noise"]!=[NSNull null]){
                                [getArray2 addObject: [temp objectForKey:@"name"]];
                                NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"noise"] doubleValue]];
                                [getArray addObject: n];
                            }
                        }
                    }
                    
                }
                _values							= [NSMutableArray arrayWithArray:getArray];
                
                [self paint];
                [self loadNoise];
                [DejalBezelActivityView removeViewAnimated:YES];
                [[self class] cancelPreviousPerformRequestsWithTarget:self];
            }
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    else  if([type  isEqualToString:@"扬尘"]){
        UIView *viewToUse = self.view;
        [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
        
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            count=array.count;
            
            if(count>0){
                if([ids count]!=0){
                    for (int i = 0 ; i < count; i ++) {
                        NSDictionary *temp = array[i];
                        if(temp !=[NSNull null]&&[ids containsObject:[temp objectForKey:@"mdid"]]){
                            if([temp objectForKey:@"name"]&&[temp objectForKey:@"spm"]!=[NSNull null]){
                                [getArray2 addObject: [temp objectForKey:@"name"]];
                                NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"spm"] doubleValue]];
                                [getArray addObject: n];
                            }
                        }
                    }
                }
                else{
                    for (int i = 0 ; i < count; i ++) {
                        NSDictionary *temp = array[i];
                        if(temp !=[NSNull null]){
                            if([temp objectForKey:@"name"]&&[temp objectForKey:@"spm"]!=[NSNull null]){
                                [getArray2 addObject: [temp objectForKey:@"name"]];
                                NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"spm"] doubleValue]];
                                [getArray addObject: n];
                            }
                        }
                    }
                    
                }
                
                _values							= [NSMutableArray arrayWithArray:getArray];
                
                [self paint];
                [self loadSpm];
                
                [DejalBezelActivityView removeViewAnimated:YES];
                [[self class] cancelPreviousPerformRequestsWithTarget:self];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
    
}
-(void)loadChartHour
{
    
    //get hour data info from web
    NSString *ask = @"rtdup/01/user/";
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    ask=[ask stringByAppendingString:userID];
    
    getArray = [[NSMutableArray alloc] init];
    getArray2 = [[NSMutableArray alloc] init];
    if([type  isEqualToString:@"噪声"]){
        UIView *viewToUse = self.view;
        [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
        
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            count=array.count;
            if(count>0){
                if([ids count]!=0){
                    for (int i = 0 ; i < count; i ++) {
                        NSDictionary *temp = array[i];
                        if(temp !=[NSNull null]&&[ids containsObject:[temp objectForKey:@"id"]]){
                            if([temp objectForKey:@"name"]&&[temp objectForKey:@"noise"]!=[NSNull null]){
                                [getArray2 addObject: [temp objectForKey:@"name"]];
                                NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"noise"] doubleValue]];
                                [getArray addObject: n];
                            }
                        }
                    }
                }
                else{
                    for (int i = 0 ; i < count; i ++) {
                        NSDictionary *temp = array[i];
                        if(temp !=[NSNull null]){
                            if([temp objectForKey:@"name"]&&[temp objectForKey:@"noise"]!=[NSNull null]){
                                [getArray2 addObject: [temp objectForKey:@"name"]];
                                NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"noise"] doubleValue]];
                                [getArray addObject: n];
                            }
                        }
                    }
                    
                }
                _values							= [NSMutableArray arrayWithArray:getArray];
                [myScrollView removeFromSuperview];
                [self paint];
                [self loadNoise];
                [DejalBezelActivityView removeViewAnimated:YES];
                [[self class] cancelPreviousPerformRequestsWithTarget:self];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    else  if([type  isEqualToString:@"扬尘"]){
        UIView *viewToUse = self.view;
        [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            count=array.count;
            if(count){
                if([ids count]!=0){
                    for (int i = 0 ; i < count; i ++) {
                        NSDictionary *temp = array[i];
                        if(temp !=[NSNull null]&&[ids containsObject:[temp objectForKey:@"id"]]){
                            if([temp objectForKey:@"name"]&&[temp objectForKey:@"spm"]!=[NSNull null]){
                                [getArray2 addObject: [temp objectForKey:@"name"]];
                                NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"spm"] doubleValue]];
                                [getArray addObject: n];
                            }
                        }
                    }
                }
                else{
                    for (int i = 0 ; i < count; i ++) {
                        NSDictionary *temp = array[i];
                        if(temp !=[NSNull null]){
                            if([temp objectForKey:@"name"]&&[temp objectForKey:@"spm"]!=[NSNull null]){
                                [getArray2 addObject: [temp objectForKey:@"name"]];
                                NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"spm"] doubleValue]];
                                [getArray addObject: n];
                            }
                        }
                    }
                    
                }
                [myScrollView removeFromSuperview];
                _values							= [NSMutableArray arrayWithArray:getArray];
                
                [self paint];
                [self loadSpm];
                
                [DejalBezelActivityView removeViewAnimated:YES];
                [[self class] cancelPreviousPerformRequestsWithTarget:self];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
    
}
-(void)paint
{
    
    _barColors						= @[[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:0.1]];
    _currentBarColor				= 0;
    
    CGRect chartFrame				= CGRectMake(0.0,
                                                 0.0,
                                                 360.0,
                                                 300.0);
    _chart							= [[SimpleBarChart alloc] initWithFrame:chartFrame];
    
    NSArray *a=  [NSMutableArray arrayWithArray:getArray2];
    [_chart getXSource:a];
    
    _chart.center					= CGPointMake(self.view.frame.size.width / 2.0+20, self.view.frame.size.height / 2.5);
    _chart.delegate					= self;
    _chart.dataSource				= self;
    _chart.barShadowOffset			= CGSizeMake(2.0, 1.0);
    _chart.animationDuration		= 1.0;
    _chart.barShadowColor			= [UIColor grayColor];
    _chart.barShadowAlpha			= 0.5;
    _chart.barShadowRadius			= 1.0;
    _chart.barWidth					= 15.0;
    _chart.xLabelType				= SimpleBarChartXLabelTypeAngled;
    _chart.incrementValue			= 10;
    _chart.barTextType				= SimpleBarChartBarTextTypeTop;
    _chart.barTextColor				= [UIColor blackColor];
    _chart.gridColor				= [UIColor grayColor];
    
    //滚动条
    myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(10, 150, 360, 480)];
    myScrollView.accessibilityActivationPoint = CGPointMake(0, 0);
    
    [myScrollView addSubview:_chart];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(_chart.frame.size.width+100,
                                          _chart.frame.size.height+200);
    myScrollView.delegate = self;
    
    //旋转柱状图
    //    myScrollView.transform = CGAffineTransformIdentity;
    //    myScrollView.transform = CGAffineTransformMakeRotation(degreeTOradians(90));
    
    [self.view addSubview:myScrollView];
    
}


- (void)loadSpm
{
    
    NSArray *a=  [NSMutableArray arrayWithArray:getArray2];
    [_chart getXSource:a];
    
    //set data with standard
    [_chart reloadData:1];
}

- (void)loadNoise
{
    
    NSArray *a=  [NSMutableArray arrayWithArray:getArray2];
    [_chart getXSource:a];
    
    //set data with standard
    [_chart reloadData:70];
}
#pragma mark SimpleBarChartDataSource

- (NSUInteger)numberOfBarsInBarChart:(SimpleBarChart *)barChart
{
    return _values.count;
}

- (CGFloat)barChart:(SimpleBarChart *)barChart valueForBarAtIndex:(NSUInteger)index
{
    return [[_values objectAtIndex:index] floatValue];
}

- (NSString *)barChart:(SimpleBarChart *)barChart textForBarAtIndex:(NSUInteger)index
{
    return [[_values objectAtIndex:index] stringValue];
}

- (NSString *)barChart:(SimpleBarChart *)barChart xLabelForBarAtIndex:(NSUInteger)index
{
    return [[_values objectAtIndex:index] stringValue];
}

- (UIColor *)barChart:(SimpleBarChart *)barChart colorForBarAtIndex:(NSUInteger)index
{
    return [_barColors objectAtIndex:_currentBarColor];
}

-(IBAction)nowBtn:(id)sender
{
    [myScrollView removeFromSuperview];
    [nowTableBtn setSelected:YES];
    [hourTableBtn setSelected:NO];
    isRt=@"实时数据";
    [self loadChartNow];
    
}

-(IBAction)hourBtn:(id)sender
{
    [myScrollView removeFromSuperview];
    
    [nowTableBtn setSelected:NO];
    [hourTableBtn setSelected:YES];
    isRt=@"小时数据";
    [self loadChartHour];
    
}

-(void)push
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [myScrollView removeFromSuperview];
    
    //self.idToDetail = [[NSUserDefaults standardUserDefaults] objectForKey:@"idToNameAndAddr"];
    
    //拿到selectedID
    self.ids = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedIDs"];
    NSLog(@"%@",self.ids);
    if (self.ids) {
        
        //将selectedIDs清零
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"selectedIDs"];
    }
    else{
        //self.idArray =
    }
    
    [self loadChartNow];
    
}


- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


-(void)viewDidDisappear:(BOOL)animated{
    ids=nil;
    [myScrollView removeFromSuperview];

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
