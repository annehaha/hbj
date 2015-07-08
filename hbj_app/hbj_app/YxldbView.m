//
//  YxldbView.m
//  hbj_app
//
//  Created by anne on 14/12/21.
//  Copyright (c) 2014年 zhaoxiaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YxldbView.h"

@interface YxldbView ()<ZHPickViewDelegate>


@end
@implementation YxldbView

@synthesize pick;
@synthesize myScrollView;
@synthesize getArray;
@synthesize getArray2;

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    [self gdfbSelect];
    return self;
}



-(void)gdfbSelect
{
    
    
    ok			= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ok.frame				= CGRectMake(240.0,
                                         70.0,
                                         100.0,
                                         30.0);
    [ok setTitle:@"查询" forState:UIControlStateNormal];
    [ok addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchDown];

    
    UIButton *endDate= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    endDate.frame				= CGRectMake(10.0,
                                             90.0,
                                             100.0,
                                             30.0);
    [endDate setTitle:@"选择结束时间" forState:UIControlStateNormal];
    [endDate addTarget:self action:@selector(endSltEnd:) forControlEvents:UIControlEventTouchDown];
    UIButton *startDate= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startDate.frame				= CGRectMake(10.0,
                                             60.0,
                                             100.0,
                                             30.0);
    [startDate setTitle:@"选择开始时间" forState:UIControlStateNormal];
    [startDate addTarget:self action:@selector(endSlt:) forControlEvents:UIControlEventTouchDown];
    
    startShow=[[UILabel alloc]initWithFrame:CGRectMake(120.0,65.0,130,20.0)];
    endShow=[[UILabel alloc]initWithFrame:CGRectMake(120.0,95.0,130,20.0)];
    
    [self addSubview:ok];
    [self addSubview:endDate];
    [self addSubview:startDate];
}

- (IBAction)endSlt:(id)sender
{
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
    pick=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    pick.delegate=self;
    ifStart=0;
    [self addSubview:pick];
    
}

- (IBAction)endSltEnd:(id)sender
{
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
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


- (IBAction)check:(id)sender
{
    [myScrollView removeFromSuperview];
    //[self loadChartNow];
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
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
        //get realtime data info from web
        NSString *ask = @"rt";
        getArray = [[NSMutableArray alloc] init];
        getArray2 = [[NSMutableArray alloc] init];
        
//        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
//            NSArray *array = result;
//            NSLog(@"%@", result);
//            count=array.count;
        
                for (int i = 0 ; i < 7; i ++) {
                    //NSDictionary *temp = array[i];
                    [getArray2 addObject: @"name"];
                    //NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"noise"] doubleValue]];
                    [getArray addObject: @40];
                }
            
//            for (int i = 0 ; i < count; i ++) {
//                NSDictionary *temp = array[i];
//                [getArray2 addObject: [temp objectForKey:@"name"]];
//                NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"noise"] doubleValue]];
//                [getArray addObject: n];
   //         }
            _values							= [NSMutableArray arrayWithArray:getArray];
            [self paint];
            [self loadNow];
            
//        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"%@", error);
//        }];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message: @"请选择时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(void)paint
{
    
    _barColors						= @[ [UIColor orangeColor]];
    _currentBarColor				= 0;
    
    CGRect chartFrame				= CGRectMake(0.0,
                                                 0.0,
                                                 320.0,
                                                 300.0);
    _chart							= [[SimpleBarChart alloc] initWithFrame:chartFrame];
    
    NSArray *a=  [NSMutableArray arrayWithArray:getArray2];
    [_chart getXSource:a];
    
    _chart.center					= CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.5);
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
                    CGRectMake(10, 120, 360, 480)];
    myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    
    [myScrollView addSubview:_chart];
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 2;
    myScrollView.contentSize = CGSizeMake(_chart.frame.size.width+50,
                                          _chart.frame.size.height);
    myScrollView.delegate = self;
    [self addSubview:myScrollView];
    
}


- (void)loadNow
{
    
    NSArray *a=  [NSMutableArray arrayWithArray:getArray2];
    [_chart getXSource:a];
    
    //set data with standard
    [_chart reloadData:24.3];
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


@end