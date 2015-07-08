//
//  SeasonReportView.m
//  hbj_app
//
//  Created by anne on 14/12/21.
//  Copyright (c) 2014年 zhaoxiaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YearReportView.h"

@interface YearReportView ()


@end

@implementation YearReportView

@synthesize monthTable;
@synthesize myScrollView;
@synthesize condition;

NSString *yearY=@"2013",*typeY=@"全部";

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    [self selectCon];
    
    return self;
}


#pragma mark pickerview function

/* return cor of pickerview*/
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

/*return row number*/
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
        return [arr1 count];
    }
    else if(component==1)
    {
        return [arr2 count];
    }
    
    return -1;
    
}

/*return component row str*/
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0)
    {
        return [arr1 objectAtIndex:row];
    }
    else if(component==1)
    {
        return [arr2 objectAtIndex:row];
    }
    
    return @"";
}
//返回三列各列宽度
-(CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component==0)
    {
        return 60.0f;
    }
    else if(component==1)
    {
        return 70.0f;
        
    }
    return 0.0f;
}
//返回row高度
-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 20.0f;
}

/*choose com is component,row's function*/
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(component==0)
    {
        yearY=[arr1 objectAtIndex:row];
    }
    else if(component==1)
    {
        typeY=[arr2 objectAtIndex:row];
    }
    
    NSLog(@"!?? %@ %@ !!!.",yearY,typeY);
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentLeft];
        pickerLabel.textColor=[UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)selectCon
{
    label=[[UILabel alloc]initWithFrame:CGRectMake(10.0,60.0,200,20.0)];
    label.text=@"选择数据类型:";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    
    
    pickerview=[[UIPickerView alloc]initWithFrame:CGRectMake(100.0,20.0,150,10.0)];
    
    arr1=@[@"2013",@"2014"];
    arr2=@[@"全部",@"基础",@"结构"];
    pickerview.delegate=self;
    pickerview.dataSource=self;
    pickerview.showsSelectionIndicator = YES;
    
    //按钮
    ok			= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ok.frame				= CGRectMake(260.0,
                                         90.0,
                                         55.0,
                                         25.0);
    [ok setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [ok addTarget:self action:@selector(monthTableShow) forControlEvents:UIControlEventTouchDown];
    
    
    [self addSubview:label];
    [self addSubview:ok];
    [self addSubview:pickerview];
    
}


-(void)monthTableShow
{
    [noInfo removeFromSuperview];
    [myScrollView removeFromSuperview];
    monthTable = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, 330, 500) andColumnsWidths:[[NSArray alloc] initWithObjects:@72,@55,@65,@50,@50,@40, nil]];
    
    UIView *viewToUse = self;
    [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];

    [monthTable addRecord:[[NSArray alloc] initWithObjects:@"监测点名称",@"监测点号", @"年平均浓度", @"最大值",@"最小值",@"有效天数", nil]];
    
    //get data info from web
    NSString *ask = @"stat/user/";
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    ask=[ask stringByAppendingString:userID];
    ask=[ask stringByAppendingString:@"/"];
    
    ask=[ask stringByAppendingString:yearY ];
    ask=[ask stringByAppendingString:@"300" ];
    if([typeY isEqualToString:@"全部"]){
        ask=[ask stringByAppendingString:@"0" ];
    }else if([typeY isEqualToString:@"基础"]){
        ask=[ask stringByAppendingString:@"1" ];
    }
    else if([typeY isEqualToString:@"结构"]){
        ask=[ask stringByAppendingString:@"2" ];
    }
    
    [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = result;
        NSLog(@"%@", result);
        if([array count]!=0){
            for (int i = 0 ; i < array.count; i ++) {
                NSDictionary *temp = array[i];
                
                [monthTable addRecord:[[NSArray alloc] initWithObjects:[temp objectForKey:@"name"],[temp objectForKey:@"num"],[temp objectForKey:@"average"],[temp objectForKey:@"max"],[temp objectForKey:@"min"],[temp objectForKey:@"day_count"], nil]];
            }
        }
        else{
            noInfo= [[UILabel alloc]initWithFrame:CGRectMake(100.0,220.0,300,20.0)];
            noInfo.textColor=[UIColor grayColor];
            noInfo.text=@"没有该时段数据";
            noInfo.font = [UIFont systemFontOfSize:15];
            [self addSubview:noInfo];
        }
        [DejalBezelActivityView removeViewAnimated:YES];
        [[self class] cancelPreviousPerformRequestsWithTarget:self];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(5, 140, 320, 320)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:monthTable];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(monthTable.frame.size.width,
                                          monthTable.frame.size.height+500);
    [myScrollView setScrollEnabled:YES];
    myScrollView.delegate = self;
    
    [self addSubview:myScrollView];
    
    
}

@end