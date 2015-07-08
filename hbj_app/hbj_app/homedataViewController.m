//
//  homedataViewController.m
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "homedataViewController.h"


@interface homedataViewController ()

@end

@implementation homedataViewController

@synthesize matrixHour;
@synthesize matrixNow;
@synthesize tableHourButton;
@synthesize tableNowButton;
@synthesize myScrollView;
@synthesize dustButton;
@synthesize noiseButton;
@synthesize spmButton;
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
    titleLabel.text = @"数据方式查看";
    self.navigationItem.titleView = titleLabel;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbackground"]]];
    
    //    //日均值Button
    //    tableNowButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 70, 90, 30)];
    //    [tableNowButton setTitle:@"实时数据" forState:UIControlStateNormal];
    //    //mapDayAverageButton.tag = 101;
    //    [tableNowButton setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    //    [tableNowButton setBackgroundImage:[UIImage imageNamed:@"left_chosen"] forState:UIControlStateSelected];
    //    tableNowButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    //    [tableNowButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //    [tableNowButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    //    [tableNowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    //    [tableNowButton addTarget:self action:@selector(nowButton)
    //             forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:tableNowButton];
    //
    //    //时均值Button
    //    tableHourButton= [[UIButton alloc] initWithFrame:CGRectMake(170, 70, 90, 30)];
    //    [tableHourButton setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    //    [tableHourButton setBackgroundImage:[UIImage imageNamed:@"right_chosen"] forState:UIControlStateSelected];
    //    [tableHourButton setTitle:@"小时数据" forState:UIControlStateNormal];
    //    //mapHourAverageButton.tag = 102;
    //    tableHourButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    //    [tableHourButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //    [tableHourButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    //    [tableHourButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    //    [tableHourButton addTarget:self action:@selector(hourButton)
    //              forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:tableHourButton];
    //
    //日均值Button
    tableNowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 160, 30)];
    [tableNowButton setTitle:@"实时数据" forState:UIControlStateNormal];
    //mapDayAverageButton.tag = 101;
    //[tableNowButton setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [tableNowButton setBackgroundColor:[UIColor whiteColor]];
    [tableNowButton setBackgroundImage:[UIImage imageNamed:@"slide_button"] forState:UIControlStateSelected];
    tableNowButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [tableNowButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [tableNowButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [tableNowButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateSelected];
    [tableNowButton addTarget:self action:@selector(nowButton)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tableNowButton];
    
    //时均值Button
    tableHourButton= [[UIButton alloc] initWithFrame:CGRectMake(160, 70, 160, 30)];
    //[tableHourButton setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [tableHourButton setBackgroundColor:[UIColor whiteColor]];
    //[tableHourButton setBackgroundImage:[UIImage imageNamed:@"right_chosen"] forState:UIControlStateSelected];
    [tableHourButton setBackgroundImage:[UIImage imageNamed:@"slide_button"] forState:UIControlStateSelected];
    [tableHourButton setTitle:@"小时数据" forState:UIControlStateNormal];
    //mapHourAverageButton.tag = 102;
    tableHourButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [tableHourButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [tableHourButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [tableHourButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateSelected];
    [tableHourButton addTarget:self action:@selector(hourButton)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tableHourButton];
    //时均值Button
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
    
    
    [tableNowButton setSelected:YES];
    [noiseButton setSelected:YES];
    type=@"噪声";
    isRt=@"实时数据";
    
    
}

-(void)push
{
    
}

- (IBAction)noiseButton:(id)sender
{
    [matrixHour removeFromSuperview];
    [matrixNow removeFromSuperview];
    type=@"噪声";
    
    [noiseButton setSelected:YES];
    [dustButton setSelected:NO];
    [spmButton setSelected:NO];
    if([isRt isEqualToString:@"小时数据"]){
        [self loadHour];
    }
    else if([isRt isEqualToString:@"实时数据"]){
        [self loadNow];
    }
}

- (IBAction)dustButton:(id)sender
{
    [matrixHour removeFromSuperview];
    [matrixNow removeFromSuperview];
    type=@"扬尘";
    
    [noiseButton setSelected:NO];
    [dustButton setSelected:YES];
    [spmButton setSelected:NO];
    
    if([isRt isEqualToString:@"小时数据"]){
        [self loadHour];
    }
    else if([isRt isEqualToString:@"实时数据"]){
        [self loadNow];
    }
    
}

- (IBAction)spmButton:(id)sender
{
    [matrixHour removeFromSuperview];
    [matrixNow removeFromSuperview];
    type=@"水";
    [noiseButton setSelected:NO];
    [dustButton setSelected:NO];
    [spmButton setSelected:YES];
    if([isRt isEqualToString:@"小时数据"]){
        [self loadHour];
    }
    else if([isRt isEqualToString:@"实时数据"]){
        [self loadNow];
    }
    
    
}



-(void)loadNow
{
    
    
    if([type  isEqualToString:@"水"]){
        
        matrixNow = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, 330, 500) andColumnsWidths:[[NSArray alloc] initWithObjects:@34,@80,@100,@100, nil]];
        
        [matrixNow addRecord:[[NSArray alloc] initWithObjects:@"序号",@"监测对象", @"流速",@"时间", nil]];
        
        //get realtime data info from web
        //    NSString *ask = @"rt";
        //
        //
        //    [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
        //        NSArray *array = result;
        //        NSLog(@"%@", result);
        //
        //        for (int i = 0 ; i < array.count; i ++) {
        //            NSDictionary *temp = array[i];
        //
        //            [matrixNow addRecord:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",i+1],[temp objectForKey:@"name"],[temp objectForKey:@"spm"],[temp objectForKey:@"noise"],@"0.222",[temp objectForKey:@"time"], nil]];
        //
        //        }
        //
        //    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        //        NSLog(@"%@", error);
        //    }];
    }
    
    else if([type  isEqualToString:@"噪声"]){
        matrixNow = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, 330, 500) andColumnsWidths:[[NSArray alloc] initWithObjects:@34,@100,@80,@100, nil]];
        
        [matrixNow addRecord:[[NSArray alloc] initWithObjects:@"序号",@"监测对象", @"噪声dB(A)",@"时间", nil]];
        
        //get realtime data info from web
        NSString *ask = @"rt/user/";
        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        //NSString *userID=@"2";
        ask=[ask stringByAppendingString:userID];
        UIView *viewToUse = self.view;
        [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
        
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            if([ids count]!=0){
                for (int i = 0,j=0 ; i < array.count; i ++) {
                    NSDictionary *temp = array[i];
                    // NSLog(@"aaaaaaa");
                    // 是否含有改监测点
                    if([ids containsObject:[temp objectForKey:@"mdid"]])
                        
                        if([temp objectForKey:@"name"]!=[NSNull null]&&[temp objectForKey:@"noise"]!=[NSNull null]&&[temp objectForKey:@"time"]!=[NSNull null]){
                            
                            [matrixNow addRecord:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",j+1],[temp objectForKey:@"name"],[temp objectForKey:@"noise"],[temp objectForKey:@"time"], nil]];
                            j+=1;
                        }
                }
            }
            else{
                for (int i = 0 ; i <array.count; i ++) {
                    NSDictionary *temp = array[i];
                    if(temp !=[NSNull null]){
                        if([temp objectForKey:@"name"]&&[temp objectForKey:@"noise"]!=[NSNull null]&&[temp objectForKey:@"time"]!=[NSNull null]){
                            [matrixNow addRecord:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",i+1],[temp objectForKey:@"name"],[temp objectForKey:@"noise"],[temp objectForKey:@"time"], nil]];
                        }
                    }
                }
            }
            [DejalBezelActivityView removeViewAnimated:YES];
            [[self class] cancelPreviousPerformRequestsWithTarget:self];
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
    else if([type  isEqualToString:@"扬尘"]){
        matrixNow = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, 330, 500) andColumnsWidths:[[NSArray alloc] initWithObjects:@34,@100,@80,@100, nil]];
        UIView *viewToUse = self.view;
        [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
        
        [matrixNow addRecord:[[NSArray alloc] initWithObjects:@"序号",@"监测对象",@"扬尘(mg/m3)",@"时间", nil]];
        
        //get realtime data info from web
        NSString *ask = @"rt/user/";
        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        ask=[ask stringByAppendingString:userID];
        
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            if([ids count]!=0){
                for (int i = 0 ,j=0; i < array.count; i ++) {
                    NSDictionary *temp = array[i];
                    if(temp !=[NSNull null]&&[ids containsObject:[temp objectForKey:@"mdid"]]){
                        if([temp objectForKey:@"name"]!=[NSNull null]&&[temp objectForKey:@"spm"]!=[NSNull null]&&[temp objectForKey:@"time"]!=[NSNull null]){
                            [matrixNow addRecord:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",j+1],[temp objectForKey:@"name"],[temp objectForKey:@"spm"],[temp objectForKey:@"time"], nil]];
                            j+=1;
                        }
                    }
                }
            }
            else{
                for (int i = 0 ; i < array.count; i ++) {
                    NSDictionary *temp = array[i];
                    if(temp !=[NSNull null]){
                        if([temp objectForKey:@"name"]!=[NSNull null]&&[temp objectForKey:@"spm"]!=[NSNull null]&&[temp objectForKey:@"time"]!=[NSNull null]){
                            [matrixNow addRecord:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",i+1],[temp objectForKey:@"name"],[temp objectForKey:@"spm"],[temp objectForKey:@"time"], nil]];
                        }
                        
                    }
                }
            }
            [DejalBezelActivityView removeViewAnimated:YES];
            [[self class] cancelPreviousPerformRequestsWithTarget:self];
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
    myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(5, 160, 320, 320)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:matrixNow];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(matrixNow.frame.size.width,
                                          matrixNow.frame.size.height+600);
    [myScrollView setScrollEnabled:YES];
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
}

-(void)loadHour
{
    
    if([type  isEqualToString:@"水"]){
        
        matrixHour = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, 330, 500) andColumnsWidths:[[NSArray alloc] initWithObjects:@34,@100,@80,@100, nil]];
        
        [matrixHour addRecord:[[NSArray alloc] initWithObjects:@"序号",@"监测对象", @"流速",@"时间", nil]];
        
        //get realtime data info from web
        //    NSString *ask = @"rt";
        //
        //
        //    [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
        //        NSArray *array = result;
        //        NSLog(@"%@", result);
        //
        //        for (int i = 0 ; i < array.count; i ++) {
        //            NSDictionary *temp = array[i];
        //
        //            [matrixNow addRecord:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",i+1],[temp objectForKey:@"name"],[temp objectForKey:@"spm"],[temp objectForKey:@"noise"],@"0.222",[temp objectForKey:@"time"], nil]];
        //
        //        }
        //
        //    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        //        NSLog(@"%@", error);
        //    }];
    }
    
    else if([type  isEqualToString:@"噪声"]){
        matrixHour = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, 330, 500) andColumnsWidths:[[NSArray alloc] initWithObjects:@34,@100,@80,@100, nil]];
        
        UIView *viewToUse = self.view;
        [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
        
        [matrixHour addRecord:[[NSArray alloc] initWithObjects:@"序号",@"监测对象", @"噪声dB(A)",@"时间", nil]];
        
        //get realtime data info from web
        NSString *ask = @"rt/01/user/";
        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        ask=[ask stringByAppendingString:userID];
        
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            if([array count]!=0){
                for (int i = 0,j=0 ; i <array.count; i ++) {
                    NSDictionary *temp = array[i];
                    if(temp !=[NSNull null]&&[ids containsObject:[temp objectForKey:@"id"]]){
                        if([temp objectForKey:@"name"]!=[NSNull null]&&[temp objectForKey:@"noise"]!=[NSNull null]&&[temp objectForKey:@"time"]!=[NSNull null]){
                            [matrixHour addRecord:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",j+1],[temp objectForKey:@"name"],[temp objectForKey:@"noise"],[temp objectForKey:@"time"], nil]];
                            j+=1;
                        }
                    }
                    
                }
            }else
            {
                for (int i = 0 ; i <array.count; i ++) {
                    NSDictionary *temp = array[i];
                    if(temp !=[NSNull null]){
                        if([temp objectForKey:@"name"]!=[NSNull null]&&[temp objectForKey:@"noise"]!=[NSNull null]&&[temp objectForKey:@"time"]!=[NSNull null]){
                            [matrixHour addRecord:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",i+1],[temp objectForKey:@"name"],[temp objectForKey:@"noise"],[temp objectForKey:@"time"], nil]];
                        }
                    }
                    
                }
            }
            [DejalBezelActivityView removeViewAnimated:YES];
            [[self class] cancelPreviousPerformRequestsWithTarget:self];
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
    else if([type  isEqualToString:@"扬尘"]){
        matrixHour = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, 330, 500) andColumnsWidths:[[NSArray alloc] initWithObjects:@34,@100,@80,@100, nil]];
        UIView *viewToUse = self.view;
        [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
        
        [matrixHour addRecord:[[NSArray alloc] initWithObjects:@"序号",@"监测对象",@"扬尘(mg/m3)",@"时间", nil]];
        //get realtime data info from web
        NSString *ask = @"rt/01/user/";
        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        ask=[ask stringByAppendingString:userID];
        
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            if([array count]!=0){
                for (int i = 0 ,j=0; i < array.count; i ++) {
                    NSDictionary *temp = array[i];
                    if(temp !=[NSNull null]&&[ids containsObject:[temp objectForKey:@"id"]]){
                        
                        if([temp objectForKey:@"name"]!=[NSNull null]&&[temp objectForKey:@"spm"]!=[NSNull null]&&[temp objectForKey:@"time"]!=[NSNull null]){
                            [matrixHour addRecord:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",j+1],[temp objectForKey:@"name"],[temp objectForKey:@"spm"],[temp objectForKey:@"time"], nil]];
                            j+=1;
                        }
                    }
                }
            }
            else{
                for (int i = 0 ; i < array.count; i ++) {
                    NSDictionary *temp = array[i];
                    if(temp !=[NSNull null]){
                        if([temp objectForKey:@"name"]!=[NSNull null]&&[temp objectForKey:@"spm"]!=[NSNull null]&&[temp objectForKey:@"time"]!=[NSNull null]){
                            [matrixHour addRecord:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",i+1],[temp objectForKey:@"name"],[temp objectForKey:@"spm"],[temp objectForKey:@"time"], nil]];
                        }
                    }
                }
                
            }
            [DejalBezelActivityView removeViewAnimated:YES];
            [[self class] cancelPreviousPerformRequestsWithTarget:self];
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
    myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(5, 160, 320, 320)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:matrixNow];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(matrixHour.frame.size.width,
                                          matrixHour.frame.size.height+600);
    [myScrollView setScrollEnabled:YES];
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
}

-(void)nowButton
{
    [matrixHour removeFromSuperview];
    [matrixNow removeFromSuperview];
    [tableNowButton setSelected:YES];
    [tableHourButton setSelected:NO];
    
    isRt=@"实时数据";
    [self loadNow];
}

-(void)hourButton
{
    [matrixHour removeFromSuperview];
    [matrixNow removeFromSuperview];
    
    [tableHourButton setSelected:YES];
    [tableNowButton setSelected:NO];
    isRt=@"小时数据";
    [self loadHour];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [matrixHour removeFromSuperview];
    [matrixNow removeFromSuperview];
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
    //    [self assignFornewsArray];
    [self loadNow];
}


- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


-(void)viewDidDisappear:(BOOL)animated{
    ids=nil;
   
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
