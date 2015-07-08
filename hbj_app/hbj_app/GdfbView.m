//
//  GdfbView.m
//  hbj_app
//
//  Created by anne on 14/12/21.
//  Copyright (c) 2014年 zhaoxiaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GdfbView.h"

@interface GdfbView ()<ZHPickViewDelegate>


@end

@implementation GdfbView

@synthesize pieView;
@synthesize pickerview;
@synthesize pick;
@synthesize myScrollView;
NSString *kindG=@"噪声",*typeG=@"时均值",*citeName;

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    [self gdfbSelect];
    return self;
}


#pragma mark pickerview function

/* return cor of pickerview*/
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
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
    else if(component ==2)
    {
        return [arr3 count];
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
    else if(component ==2)
    {
        return [arr3 objectAtIndex:row];
        
    }
    return @"";
}
//返回三列各列宽度
-(CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component==0)
    {
        return 200.0f;
    }
    else if(component==1)
    {
        return 34.0f;
        
    }
    else if(component ==2)
    {
        return 68.0f;
    }
    return 0.0f;
}
//返回row高度
-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}

/*choose com is component,row's function*/
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(component==0)
    {
        citeName=[arr1 objectAtIndex:row];
    }
    else if(component==1)
    {
        kindG=[arr2 objectAtIndex:row];
    }
    else if(component==2)
    {
        typeG=[arr3 objectAtIndex:row];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumFontSize = 8;
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

-(void)gdfbSelect
{
    
    
    
    ok			= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ok.frame				= CGRectMake(240.0,
                                         190.0,
                                         55.0,
                                         25.0);
    [ok setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [ok addTarget:self action:@selector(gdfbCheck) forControlEvents:UIControlEventTouchDown];
    
    
    //get cite name first
    NSString *ask = @"address/user/";
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    ask=[ask stringByAppendingString:userID];
    
    cites= [[NSMutableArray alloc]init];
    addr =[[NSMutableDictionary alloc] init];
    
    [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = result;
        
        
        for (int i = 0 ; i < array.count; i ++) {
              NSDictionary *temp = array[i];
             [cites addObject:[temp objectForKey:@"name"]];
              NSLog(@"%@", array[i]);
          //  [cites addObject:array[i]];
            [addr setObject:[temp objectForKey:@"name"] forKey:[temp objectForKey:@"id"]];
            
        }
        arr1= [NSMutableArray arrayWithArray:cites];
        citeName=arr1[0];
        
        pickerview=[[UIPickerView alloc]initWithFrame:CGRectMake(0.0,0.0,355,10.0)];
        
        arr2=@[@"噪声",@"SPM"];
        arr3=@[@"时均值",@"日均值"];
        
        pickerview.delegate=self;
        pickerview.dataSource=self;
        [self addSubview:pickerview];
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
    UIButton *endDate= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    endDate.frame				= CGRectMake(10.0,
                                             195.0,
                                             100.0,
                                             30.0);
    [endDate setTitle:@"选择结束时间" forState:UIControlStateNormal];
    [endDate setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [endDate addTarget:self action:@selector(endSltEnd:) forControlEvents:UIControlEventTouchDown];
    UIButton *startDate= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startDate.frame				= CGRectMake(10.0,
                                             160.0,
                                             100.0,
                                             30.0);
    [startDate setTitle:@"选择开始时间" forState:UIControlStateNormal];
    [startDate addTarget:self action:@selector(endSlt:) forControlEvents:UIControlEventTouchDown];
    [startDate setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    startShow=[[UILabel alloc]initWithFrame:CGRectMake(120.0,165.0,130,20.0)];
    endShow=[[UILabel alloc]initWithFrame:CGRectMake(120.0,200.0,130,20.0)];
    
    [self addSubview:ok];
    
    [self addSubview:endDate];
    [self addSubview:startDate];
}

- (IBAction)endSlt:(id)sender
{
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:4000000];
    pick=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    pick.delegate=self;
    ifStart=0;
    [self addSubview:pick];
    
}

- (IBAction)endSltEnd:(id)sender
{
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    pick=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    pick.delegate=self;
    ifStart=1;
    [self addSubview:pick];
    
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if(ifStart==0){
        startShow.text=[resultString substringToIndex:10];
        
        [self addSubview:startShow];
    }
    if(ifStart==1){
        endShow.text=[resultString substringToIndex:10];
        
        [self addSubview:endShow];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}


-(void)gdfbCheck
{
    [noInfo removeFromSuperview];
    [myScrollView removeFromSuperview];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
    NSDate *dateS =[dateFormat dateFromString:startShow.text];
    NSDate *dateE =[dateFormat dateFromString:endShow.text];
    islate=[dateE isEqualToDate:[dateS laterDate:dateE]];
    
    if(startShow.text&&endShow.text){
        if(!islate)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message: @"起始时间不能晚于结束时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            
            NSString *ask = @"range/";
            //get data info from web
          //  ask=[ask stringByAppendingString:citeName ];
            for (id key in addr)
            {
                if([[addr objectForKey:key] isEqualToString:citeName])
                    ask=[ask stringByAppendingString:key];
            }
            NSLog(@"%@&&&&&,%@", ask,addr);
            
            if([kindG isEqualToString:@"噪声"]){
                ask=[ask stringByAppendingString:@"&0" ];
            }
            else if([kindG isEqualToString:@"SPM"]){
                ask=[ask stringByAppendingString:@"&1" ];
            }
            if([typeG isEqualToString:@"时均值"]){
                ask=[ask stringByAppendingString:@"&0&" ];
            }else if([typeG isEqualToString:@"日均值"]){
                ask=[ask stringByAppendingString:@"&1&" ];
            }
            
            ask=[ask stringByAppendingString:startShow.text];
            ask=[ask stringByAppendingString:@"&" ];
            ask=[ask stringByAppendingString:endShow.text ];
            
            ask = [ask stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            UIView *viewToUse = self;
            [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
            
            [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
                
                NSArray *array = result;
                if([array count]!=0){
                    
                    [pieView removeFromSuperview];
                    pieView =[[Example2PieView alloc]initWithFrame:CGRectMake(0.0,0.0,380,270.0)];
                    pieView.backgroundColor=[UIColor clearColor];
                    if([kindG isEqualToString:@"噪声"]){
                    for(int year =0; year <5; year++){
                        MyPieElement* elem = [MyPieElement pieElementWithValue:[array[year] floatValue] color:[self randomColor]];
                        NSLog(@"%f", [array[year] floatValue]);
                        //              [pieView.layer addValues:[NSNumber numberWithFloat:array[year]]  animated:NO];[array[year] floatValue]
                        [pieView.layer addValues:@[elem]  animated:NO];
                        
                        
                        if (year==0) {
                            elem.title = @"50.0以下:";
                                                    }
                        else if (year==1) {
                            elem.title = @"50－60:";
                            
                        }
                        else if (year==2) {
                            elem.title = @"60-70:";
                        }
                        else if (year==3) {
                            elem.title = @"70-80:";
                        }else if (year==4) {
                            elem.title = @"80以上:";
                        }
                        float b=[array[year] floatValue]*100;
                        NSString *a =[NSString stringWithFormat:@"%.1f%%" , b] ;
                        elem.title = [elem.title stringByAppendingString:a];

                    }
                    }
                    else{
                        for(int year =0; year <4; year++){
                            MyPieElement* elem = [MyPieElement pieElementWithValue:[array[year] floatValue] color:[self randomColor]];
                            NSLog(@"%f", [array[year] floatValue]);
                            //              [pieView.layer addValues:[NSNumber numberWithFloat:array[year]]  animated:NO];[array[year] floatValue]
                            [pieView.layer addValues:@[elem]  animated:NO];
                            
                            
                            if (year==0) {
                                elem.title = @"0.3以下:";
                                //                            NSString *a=[NSString stringWithFormat:@"%.2f%" , [array[year] floatValue]*100] ;
                                //                            elem.title = [elem.title stringByAppendingString:[a stringValue]];
                            }
                            else if (year==1) {
                                elem.title = @"0.3-0.5:";
                            }
                            else if (year==2) {
                                elem.title = @"0.5-1.0:";
                            }
                            else if (year==3) {
                                elem.title = @"1.0以上:";
                            }
                            float b=[array[year] floatValue]*100;
                            NSString *a =[NSString stringWithFormat:@"%.1f%%" , b] ;
                            elem.title = [elem.title stringByAppendingString:a];
                        }

                    }
                    //mutch easier do this with array outside
                    pieView.layer.transformTitleBlock = ^(PieElement* elem){
                        return [(MyPieElement*)elem title];
                    };
                    pieView.layer.showTitles = ShowTitlesAlways;
                    myScrollView = [[UIScrollView alloc]initWithFrame:
                                    CGRectMake(0, 230, 320, 260)];
                    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
                    
                    [myScrollView addSubview:pieView];
                    myScrollView.minimumZoomScale = 0.5;
                    myScrollView.maximumZoomScale = 2;
                    myScrollView.contentSize = CGSizeMake(pieView.frame.size.width+20,
                                                          pieView.frame.size.height);
                    [myScrollView setScrollEnabled:YES];
                    myScrollView.delegate = self;
                    
                    [self addSubview:myScrollView];
                }
                else{
                    noInfo= [[UILabel alloc]initWithFrame:CGRectMake(100.0,300.0,300,20.0)];
                    noInfo.textColor=[UIColor grayColor];
                    noInfo.text=@"该地区无此信息";
                    noInfo.font = [UIFont systemFontOfSize:16];
                    [self addSubview:noInfo];
                }
                
                [DejalBezelActivityView removeViewAnimated:YES];
                [[self class] cancelPreviousPerformRequestsWithTarget:self];
  
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@", error);
            }];
            
            
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message: @"请选择时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.3];
}
@end