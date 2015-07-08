//
//  cameraView.m
//  hbj_app
//
//  Created by eidision on 14/11/29.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "cameraView.h"

@implementation cameraView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    if (self) {
        self.cameraView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 54, 300, 350)];
        [self.cameraView setImage:[UIImage imageNamed:@"camera_wait"]];
        
        self.lu = [[UIButton alloc] initWithFrame:CGRectMake(20, 415, 35, 35)];
        [self.lu setBackgroundImage:[UIImage imageNamed:@"camera_lu"] forState:UIControlStateNormal];
        
        self.l = [[UIButton alloc] initWithFrame:CGRectMake(20, 455, 35, 35)];
        [self.l setBackgroundImage:[UIImage imageNamed:@"camera_l"] forState:UIControlStateNormal];
        [self.l addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
        
        self.ld = [[UIButton alloc] initWithFrame:CGRectMake(20, 495, 35, 35)];
        [self.ld setBackgroundImage:[UIImage imageNamed:@"camera_ld"] forState:UIControlStateNormal];
        
        self.ru = [[UIButton alloc] initWithFrame:CGRectMake(100, 415, 35, 35)];
        [self.ru setBackgroundImage:[UIImage imageNamed:@"camera_ru"] forState:UIControlStateNormal];
        
        self.r = [[UIButton alloc] initWithFrame:CGRectMake(100, 455, 35, 35)];
        [self.r setBackgroundImage:[UIImage imageNamed:@"camera_r"] forState:UIControlStateNormal];
        [self.r addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
        
        self.rd = [[UIButton alloc] initWithFrame:CGRectMake(100, 495, 35, 35)];
        [self.rd setBackgroundImage:[UIImage imageNamed:@"camera_rd"] forState:UIControlStateNormal];
        
        self.cu = [[UIButton alloc] initWithFrame:CGRectMake(60, 415, 35, 35)];
        [self.cu setBackgroundImage:[UIImage imageNamed:@"camera_cu"] forState:UIControlStateNormal];
        [self.cu addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpInside];
        
        self.c = [[UIButton alloc] initWithFrame:CGRectMake(60, 455, 35, 35)];
        [self.c setBackgroundImage:[UIImage imageNamed:@"camera_c"] forState:UIControlStateNormal];
        [self.c addTarget:self action:@selector(no) forControlEvents:UIControlEventTouchUpInside];
        
        self.cd = [[UIButton alloc] initWithFrame:CGRectMake(60, 495, 35, 35)];
        [self.cd setBackgroundImage:[UIImage imageNamed:@"camera_cd"] forState:UIControlStateNormal];
        [self.cd addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
        
        self.firstUp = [[UIButton alloc] initWithFrame:CGRectMake(265, 430, 35, 35)];
        [self.firstUp setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [self.firstUp addTarget:self action:@selector(out) forControlEvents:UIControlEventTouchUpInside];
        
        self.firstDown = [[UIButton alloc] initWithFrame:CGRectMake(165, 430, 35, 35)];
        [self.firstDown setBackgroundImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
        [self.firstDown addTarget:self action:@selector(in) forControlEvents:UIControlEventTouchUpInside];
        
        self.secondUp = [[UIButton alloc] initWithFrame:CGRectMake(265, 470, 35, 35)];
        [self.secondUp setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [self.secondUp addTarget:self action:@selector(out) forControlEvents:UIControlEventTouchUpInside];
        
        self.secondDown = [[UIButton alloc] initWithFrame:CGRectMake(165, 470, 35, 35)];
        [self.secondDown setBackgroundImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
        [self.secondDown addTarget:self action:@selector(in) forControlEvents:UIControlEventTouchUpInside];
        
        self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(205, 430, 55, 35)];
        self.firstLabel.text = @"焦距";
        self.firstLabel.font = [UIFont systemFontOfSize:16];
        self.firstLabel.textAlignment = NSTextAlignmentCenter;
        self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(205, 470, 55, 35)];
        self.secondLabel.text = @"焦点";
        self.secondLabel.textAlignment = NSTextAlignmentCenter;
        self.secondLabel.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:self.cameraView];
        [self addSubview:self.lu];
        [self addSubview:self.l];
        [self addSubview:self.ld];
        [self addSubview:self.cu];
        [self addSubview:self.c];
        [self addSubview:self.cd];
        [self addSubview:self.ru];
        [self addSubview:self.r];
        [self addSubview:self.rd];
        [self addSubview:self.firstUp];
        [self addSubview:self.firstDown];
        [self addSubview:self.secondUp];
        [self addSubview:self.secondDown];
        [self addSubview:self.firstLabel];
        [self addSubview:self.secondLabel];
    }
    return self;
}

-(void) left
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"left"
                                                        object:nil
                                                      userInfo:nil];
}

-(void) right
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"right"
                                                        object:nil
                                                      userInfo:nil];
}

-(void) up
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"up"
                                                        object:nil
                                                      userInfo:nil];
}

-(void) down
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"down"
                                                        object:nil
                                                      userInfo:nil];
}

-(void) in
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"in"
                                                        object:nil
                                                      userInfo:nil];
}

-(void) out
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"out"
                                                        object:nil
                                                      userInfo:nil];
}

-(void) no
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"no"
                                                        object:nil
                                                      userInfo:nil];
}

@end
