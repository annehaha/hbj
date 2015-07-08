//
//  Top5citeView.m
//  hbj_app
//
//  Created by anne on 14/12/21.
//  Copyright (c) 2014年 zhaoxiaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Top5citeView.h"

@interface Top5citeView ()


@end

@implementation Top5citeView

@synthesize monthTable;
@synthesize myScrollView;
@synthesize condition;

NSString *typeTop=@"本月日均值超标率前5名监测点";

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
    return 1;
}

/*return row number*/
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
        return [arr1 count];
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
    
    return @"";
}
//返回三列各列宽度
-(CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component==0)
    {
        return 250.0f;
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
        typeTop=[arr1 objectAtIndex:row];
    }
    
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumFontSize = 13.;
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
    
    txt2=[[UILabel alloc]initWithFrame:CGRectMake(10.0,165.0,200,20.0)];
    txt2.text=@"本月日均值超标率前5名监测点";
    txt2.font = [UIFont systemFontOfSize:13];
    txt2.textColor = [UIColor grayColor];
    txt3=[[UILabel alloc]initWithFrame:CGRectMake(10.0,385.0,300,20.0)];
    txt3.text=@"当前SPM日均值浓度超标值为：0.3mg／m3";
    txt3.font = [UIFont systemFontOfSize:13];
    txt3.textColor = [UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1];
    txt4=[[UILabel alloc]initWithFrame:CGRectMake(10.0,405.0,300,20.0)];
    txt4.text=@"小时浓度超标值为：1.0mg／m3";
    txt4.font = [UIFont systemFontOfSize:13];
    txt4.textColor = [UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1];
    
    pickerview=[[UIPickerView alloc]initWithFrame:CGRectMake(40.0,20.0,220,10.0)];
    
    arr1=@[@"本月日均值超标率前5名监测点",@"本月小时均值超标率前5名监测点",@"上月日均值超标率前5名监测点"
           ,@"上月小时均值超标率前5名监测点"];
    
    pickerview.delegate=self;
    pickerview.dataSource=self;
    pickerview.showsSelectionIndicator = YES;
    
    //按钮
    ok			= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ok.frame				= CGRectMake(265.0,
                                         90.0,
                                         50.0,
                                         25.0);
    [ok setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [ok addTarget:self action:@selector(monthTableShow) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:txt2];
    [self addSubview:txt3];
    [self addSubview:txt4];
    [self addSubview:label];
    [self addSubview:ok];
    [self addSubview:pickerview];
    
}


-(void)monthTableShow
{
    [myScrollView removeFromSuperview];
    monthTable = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 0, 330, 500) andColumnsWidths:[[NSArray alloc] initWithObjects:@120,@60,@70,@60, nil]];
    
    UIView *viewToUse = self;
    [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
    [monthTable addRecord:[[NSArray alloc] initWithObjects:@"监测点名称",@"超标次数", @"有效数据数", @"超标率", nil]];
    
    //get data info from web
    NSString *ask = @"rank/";
    if([typeTop isEqualToString:@"本月日均值超标率前5名监测点"]){
        ask=[ask stringByAppendingString:@"0" ];
    }else if([typeTop isEqualToString:@"本月小时均值超标率前5名监测点"]){
        ask=[ask stringByAppendingString:@"1" ];
    }
    else if([typeTop isEqualToString:@"上月日均值超标率前5名监测点"]){
        ask=[ask stringByAppendingString:@"2" ];
    }
    else if([typeTop isEqualToString:@"上月小时均值超标率前5名监测点"]){
        ask=[ask stringByAppendingString:@"3" ];
    }
    ask=[ask stringByAppendingString:@"/user/"];
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    ask=[ask stringByAppendingString:userID];
    
    
    [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = result;
        NSLog(@"%@", result);
        for (int i = 0 ; i < array.count; i ++) {
            NSDictionary *temp = array[i];
            
            [monthTable addRecord:[[NSArray alloc] initWithObjects:[temp objectForKey:@"name"],[temp objectForKey:@"count"],[temp objectForKey:@"ex_count"],[temp objectForKey:@"percent"], nil]];
            
        }
        [DejalBezelActivityView removeViewAnimated:YES];
        [[self class] cancelPreviousPerformRequestsWithTarget:self];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(5, 200, 320, 320)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:monthTable];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(monthTable.frame.size.width,
                                          monthTable.frame.size.height+20);
    [myScrollView setScrollEnabled:YES];
    myScrollView.delegate = self;
    
    [self addSubview:myScrollView];
    
    
}

@end