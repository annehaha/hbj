//
//  homehistoryViewController.m
//  hbj_app
//
//  Created by eidision on 14/11/23.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "homehistoryViewController.h"

@interface homehistoryViewController ()


@end

@implementation homehistoryViewController
@synthesize pieView;
@synthesize monthTable;
@synthesize myScrollView;
@synthesize pickerview;
@synthesize gdfb;
@synthesize month;
@synthesize season;
@synthesize year;
@synthesize yxldb;
@synthesize top;
@synthesize cbbh;

- (void)viewDidLoad {
    [super viewDidLoad];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"历史查看";
    self.navigationItem.titleView = titleLabel;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbackground"]]];
    
    //    navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    //    [navRightButton setBackgroundImage:[UIImage imageNamed:@"home_map_locate"] forState:UIControlStateNormal];
    //    [navRightButton addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    //
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightButton];
    
    _mmMainFX = self.view.bounds.origin.x;
    _mmMainFY = 20 + 44;
    //    _mmMainFY = [[UIBaseClass shareInstance] getViewFramOY];
    _clearFlag = YES;
    
    [self initNavBtn];
    [self initView];
    [self rightNavBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)singlepoint
{
    
}

-(void)multipoint
{
    
}

-(void)initNavBtn
{
    //    UIButton * navLeftButton= [UIButton buttonWithType:UIButtonTypeCustom];
    //    [navLeftButton setFrame:CGRectMake(0, 0, 13, 22)];
    //    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navBack-26X44"] forState:UIControlStateNormal];
    //    [navLeftButton addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    //
    //    UIBarButtonItem* leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    //    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
    //
    navRightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [navRightButton setFrame:CGRectMake(281, 17, 28, 12)];
    [navRightButton setBackgroundImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [navRightButton addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:navRightButton];
    
    //  UIButton *navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    
    
    //    UIBarButtonItem* rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:navRightButton];
    //    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    
}
-(void)rightNavBtn
{
    titleLabel.text = @"历史查看";
    if (_clearFlag)
    {
        [self hideView];
        CGAffineTransform navRound =CGAffineTransformMakeRotation(M_PI/-3);//先顺时钟旋转90
        navRound =CGAffineTransformTranslate(navRound,0,0);
        
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction|
                                     UIViewAnimationOptionBeginFromCurrentState)
                         animations:^(void) {
                             
                             _lcksBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             _wjxxBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,1*-10,45*1);
                             _jkpgBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,2*-10,45*2);
                             _gdfbBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,3*-10,45*3);
                             _sszjBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,5*-10,45*4);
                             _khssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,6*-10,45*5);
                             _jhssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,4*-10,45*6);
                             _lcksBtn.alpha = 1;
                             _wjxxBtn.alpha = 1;
                             _jkpgBtn.alpha = 1;
                             _gdfbBtn.alpha = 1;
                             _jhssBtn.alpha = 1;
                             _sszjBtn.alpha = 1;
                             _khssBtn.alpha = 1;
                             
                             [navRightButton setTransform:navRound];
                             
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                 
                                 _lcksBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,40.0*0);
                                 _wjxxBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,1*-10,40.0*1);
                                 _jkpgBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,2*-10,40.0*2);
                                 _gdfbBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,3*-10,40.0*3);
                                 _sszjBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,5*-10,40.0*4);
                                 _khssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,6*-10,40.0*5);
                                 _jhssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,4*-10,40.0*6);
                                 
                             } completion:NULL];
                         }];
    }
    else
    {
        [self showView];
        
        CGAffineTransform navRound =CGAffineTransformMakeRotation(0);//先顺时钟旋转90
        navRound =CGAffineTransformIdentity;
        
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction|
                                     UIViewAnimationOptionBeginFromCurrentState)
                         animations:^(void) {
                             
                             _lcksBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             _wjxxBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,1*-10,45*0);
                             _jkpgBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,2*-10,45*0);
                             _gdfbBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,3*-10,45*0);
                             _jhssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,4*-10,45*0);
                             _sszjBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,5*-10,45*0);
                             _khssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,6*-10,45*0);
                             _lcksBtn.alpha = 0;
                             _wjxxBtn.alpha = 0;
                             _jkpgBtn.alpha = 0;
                             _gdfbBtn.alpha = 0;
                             _jhssBtn.alpha = 0;
                             _sszjBtn.alpha = 0;
                             _khssBtn.alpha = 0;
                             
                             [navRightButton setTransform:navRound];
                             
                         }
                         completion:^(BOOL finished) {
                             
                             
                         }];
    }
    
    _clearFlag = !_clearFlag;
    
    NSLog(@"navRightButton = %f,%f",navRightButton.frame.size.width, navRightButton.frame.size.height);
}

-(void)initView
{
    _vFX = _mmMainFX;
    _vFY = _mmMainFY;
    
    //    _clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 320, 460+(iPhone5?88:0)-44)];
    _clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 320, 460+88-44)];
    _clearImg.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:244.0/255 alpha:0.9];
    _clearImg.hidden = YES;
    
    _vFX = _mmMainFX;
    _vFY = _mmMainFY;
    _lcksBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lcksBtn setFrame:CGRectMake(132, _vFY, 200, 40)];
    [_lcksBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1]forState:UIControlStateNormal];
    [_lcksBtn setTitle:@"SPM日平均月度报表" forState:UIControlStateNormal];
    
    _wjxxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wjxxBtn setFrame:CGRectMake(132, _vFY, 200, 40)];
    [_wjxxBtn setTitle:@"SPM日平均季度报表" forState:UIControlStateNormal];
    [_wjxxBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1]forState:UIControlStateNormal];
    
    _jkpgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jkpgBtn setFrame:CGRectMake(132, _vFY, 200, 40)];
    [_jkpgBtn setTitle:@"SPM日平均年度报表" forState:UIControlStateNormal];
    [_jkpgBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1]forState:UIControlStateNormal];
    
    _sszjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sszjBtn setFrame:CGRectMake(132, _vFY, 200, 40)];
    [_sszjBtn setTitle:@"超标率前五名监测点" forState:UIControlStateNormal];
    [_sszjBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1]forState:UIControlStateNormal];
    
    _gdfbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_gdfbBtn setFrame:CGRectMake(132, _vFY, 200, 40)];
    [_gdfbBtn setTitle:@"    工地分布范围" forState:UIControlStateNormal];
    [_gdfbBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1]forState:UIControlStateNormal];
    
    _khssBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_khssBtn setFrame:CGRectMake(132, _vFY, 200, 40)];
    [_khssBtn setTitle:@"整体超标情况变化趋势" forState:UIControlStateNormal];
    [_khssBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1]forState:UIControlStateNormal];
    
    //    _jhssBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [_jhssBtn setFrame:CGRectMake(132, _vFY, 240, 40)];
    //    [_jhssBtn setTitle:@"江北区重庆市工地均值对比" forState:UIControlStateNormal];
    //
    
    _lcksBtn.alpha = 0;
    _wjxxBtn.alpha = 0;
    _jkpgBtn.alpha = 0;
    _gdfbBtn.alpha = 0;
    _jhssBtn.alpha = 0;
    _sszjBtn.alpha = 0;
    _khssBtn.alpha = 0;
    
    [_lcksBtn addTarget:self action:@selector(monthTable) forControlEvents:UIControlEventTouchUpInside];
    [_wjxxBtn addTarget:self action:@selector(seasonTable) forControlEvents:UIControlEventTouchUpInside];
    [_jkpgBtn addTarget:self action:@selector(yearTable) forControlEvents:UIControlEventTouchUpInside];
    [_gdfbBtn addTarget:self action:@selector(gdfbSelect) forControlEvents:UIControlEventTouchUpInside];
    [_jhssBtn addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
    [_sszjBtn addTarget:self action:@selector(topSelect) forControlEvents:UIControlEventTouchUpInside];
    [_khssBtn addTarget:self action:@selector(cbbhSelect) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_clearImg];
    [self.view addSubview:_lcksBtn];
    [self.view addSubview:_wjxxBtn];
    [self.view addSubview:_jkpgBtn];
    [self.view addSubview:_gdfbBtn];
    [self.view addSubview:_jhssBtn];
    [self.view addSubview:_sszjBtn];
    [self.view addSubview:_khssBtn];
}
-(void)hideView
{
    _clearImg.hidden = NO;
    cbbh.hidden=YES;
    top.hidden=YES;
    yxldb.hidden=YES;
    gdfb.hidden=YES;
    year.hidden=YES;
    season.hidden=YES;
    month.hidden=YES;
    pickerview.hidden=YES;
    pieView.hidden=YES;
    myScrollView.hidden=YES;
    ok.hidden=YES;
}

-(void)showView
{
    _clearImg.hidden = YES;
    cbbh.hidden=NO;
    top.hidden=NO;
    yxldb.hidden=NO;
    gdfb.hidden=NO;
    year.hidden=NO;
    season.hidden=NO;
    month.hidden=NO;
    pickerview.hidden=NO;
    pieView.hidden=NO;
    myScrollView.hidden=NO;
    ok.hidden=NO;
}

-(void)removeView
{
    [pieView removeFromSuperview];
    [cbbh removeFromSuperview];
    [top removeFromSuperview];
    [yxldb removeFromSuperview];
    [gdfb removeFromSuperview];
    [year removeFromSuperview];
    [season removeFromSuperview];
    [month removeFromSuperview];
    [myScrollView removeFromSuperview];
    [ok removeFromSuperview];
    [pickerview removeFromSuperview];
}
-(void)btnSelect{
    
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
        return 70.0f;
    }
    else if(component==1)
    {
        return 80.0f;
        
    }
    else if(component ==2)
    {
        return 95.0f;
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
    
}

-(void)gdfbSelect
{
    
    _clearFlag = NO;
    [self rightNavBtn];
    [self removeView];
    gdfb= [[GdfbView alloc] init];
    [self.view addSubview:gdfb];
    titleLabel.text = @"工地分布范围";
    
}

-(void)monthTable
{
    _clearFlag = NO;
    [self rightNavBtn];
    [self removeView];
    month=[[MonthReportView alloc] init];
    [self.view addSubview:month];
    titleLabel.text = @"spm平均月度报表";
}

-(void)seasonTable
{
    _clearFlag = NO;
    [self rightNavBtn];
    [self removeView];
    season=[[SeasonReportView alloc] init];
    [self.view addSubview:season];
    titleLabel.text = @"spm平均季度报表";
}

-(void)yearTable
{
    _clearFlag = NO;
    [self rightNavBtn];
    [self removeView];
    year=[[YearReportView alloc] init];
    [self.view addSubview:year];
    titleLabel.text = @"spm平均年度报表";
}

-(void)yxldbSelect
{
    _clearFlag = NO;
    [self rightNavBtn];
    [self removeView];
    yxldb=[[YxldbView alloc] init];
    [self.view addSubview:yxldb];
}

-(void)topSelect
{
    _clearFlag = NO;
    [self rightNavBtn];
    [self removeView];
    top= [[Top5citeView alloc] init];
    [self.view addSubview:top];
    titleLabel.text = @"超标率前五名监测点";
}

-(void)cbbhSelect
{
    _clearFlag = NO;
    [self rightNavBtn];
    [self removeView];
    cbbh= [[CbbhView alloc] init];
    [self.view addSubview:cbbh];
    titleLabel.text = @"整体超标情况变化趋势";
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
