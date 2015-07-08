//
//  statisticsInfoView.m
//  hbj_app
//
//  Created by eidision on 14/11/29.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "statisticsInfoView.h"

@implementation statisticsInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(70, 50, 90, 30)];
        [self.leftButton setTitle:@"SPM" forState:UIControlStateNormal];
        [self.leftButton setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        [self.leftButton setBackgroundImage:[UIImage imageNamed:@"left_chosen"] forState:UIControlStateSelected];
        self.leftButton.tag = 511;
        self.leftButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [self.leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.leftButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.leftButton addTarget:self action:@selector(statisticsLeft) forControlEvents:UIControlEventTouchUpInside];
        
        self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 50, 90, 30)];
        [self.rightButton setTitle:@"noise" forState:UIControlStateNormal];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"right_chosen"] forState:UIControlStateSelected];
        self.rightButton.tag = 512;
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [self.rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.rightButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.rightButton addTarget:self action:@selector(statisticsRight) forControlEvents:UIControlEventTouchUpInside];
        
//        self.upperView = [[UIView alloc] initWithFrame:CGRectMake(10, 84, 300, 230)];
//        self.lowerView = [[UIView alloc] initWithFrame:CGRectMake(10, 315, 300, 230)];
        
        self.day=[[UILabel alloc]initWithFrame:CGRectMake(20.0,120.0,300,20.0)];
        self.night=[[UILabel alloc]initWithFrame:CGRectMake(20.0,330.0,300,20.0)];
        self.day.font = [UIFont systemFontOfSize:14];
        self.day.textColor = [UIColor grayColor];
        
        self.night.font = [UIFont systemFontOfSize:14];
        self.night.textColor = [UIColor grayColor];

        self.label = [[UILabel alloc]initWithFrame:CGRectMake(120.0,100.0,300,20.0)];
        self.label.font = [UIFont systemFontOfSize:14];
        self.label.text=@"十天内变化情况";
        self.label.textColor = [UIColor colorWithRed:34/255.0 green:151/255.0 blue:65/255.0 alpha:1];
        
        [self addSubview:self.label];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
//        [self addSubview:self.upperView];
//        [self addSubview:self.lowerView];
        [self addSubview:self.day];
        [self addSubview:self.night];
        [self.leftButton setSelected:YES];
        self.chosen = self.leftButton.tag;
    }
    return self;
}

-(void)statisticsLeft
{
    if (self.leftButton.tag == self.chosen) {
        return;
    }
    UIButton *preButton = (UIButton *)[self viewWithTag:self.chosen];
    [preButton setSelected:NO];
    self.chosen = self.leftButton.tag;
    [self.leftButton setSelected:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"statisticsLeft"
                                                        object:nil
                                                      userInfo:nil];
}

-(void)statisticsRight
{
    if (self.rightButton.tag == self.chosen) {
        return;
    }
    UIButton *preButton = (UIButton *)[self viewWithTag:self.chosen];
    [preButton setSelected:NO];
    self.chosen = self.rightButton.tag;
    [self.rightButton setSelected:YES];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"statisticsRight"
                                                        object:nil
                                                      userInfo:nil];
}

@end
