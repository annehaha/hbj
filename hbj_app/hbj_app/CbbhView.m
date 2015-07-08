//
//  SeasonReportView.m
//  hbj_app
//
//  Created by anne on 14/12/21.
//  Copyright (c) 2014年 zhaoxiaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CbbhView.h"

@interface CbbhView ()


@end

@implementation CbbhView

@synthesize monthTable;
@synthesize myScrollView;

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    [self monthTableShow];
    
    return self;
}


-(void)monthTableShow
{
    label=[[UILabel alloc]initWithFrame:CGRectMake(10.0,80.0,300,20.0)];
    label.text=@"当前SPM日均浓度超标值为：0.3mg／m3";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1];
    
    label2=[[UILabel alloc]initWithFrame:CGRectMake(10.0,110.0,300,20.0)];
    label2.text=@"小时浓度超标值为：1.0mg／m3";
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = [UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1];
    
    
    [myScrollView removeFromSuperview];
    monthTable = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, 330, 500) andColumnsWidths:[[NSArray alloc] initWithObjects:@80,@80,@82,@82, nil]];
    
    UIView *viewToUse = self;
    [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
    [monthTable addRecord:[[NSArray alloc] initWithObjects:@"当月日均值超标数/率",@"上月日均值超标数/率", @"当月小时均值超标数/率", @"上月小时均值超标数/率", nil]];
    
    //get data info from web
    NSString *ask1 = @"infos/user/";
    NSString *userID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    ask1=[ask1 stringByAppendingString:userID];
    
    [[myNetworking sharedClient] GET:ask1 parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = result;
        [monthTable addRecord:[[NSArray alloc] initWithObjects:[array[0] stringByAppendingString:[NSString stringWithFormat:@"/%@",array[1]]], [array[2] stringByAppendingString:[NSString stringWithFormat:@"/%@",array[3]]], [array[4] stringByAppendingString:[NSString stringWithFormat:@"/%@",array[5]]], [array[6] stringByAppendingString:[NSString stringWithFormat:@"/%@",array[7]]], nil]];
        [DejalBezelActivityView removeViewAnimated:YES];
        [[self class] cancelPreviousPerformRequestsWithTarget:self];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(5, 180, 320, 320)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:monthTable];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(monthTable.frame.size.width,
                                          monthTable.frame.size.height);
    [myScrollView setScrollEnabled:YES];
    myScrollView.delegate = self;
    
    [self addSubview:label];
    [self addSubview:label2];
    [self addSubview:myScrollView];
    
    
}

@end