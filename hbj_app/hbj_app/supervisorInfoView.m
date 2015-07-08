//
//  supervisorInfoView.m
//  hbj_app
//
//  Created by eidision on 14/11/29.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "supervisorInfoView.h"

@implementation supervisorInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.photoImageView setImage:[UIImage imageNamed:@"headicon"]];
        [self addSubview:self.photoImageView];
                                                                            
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 1, [UIScreen mainScreen].applicationFrame.size.width - 65, 58)];
        [self.nameLabel setFont:[UIFont boldSystemFontOfSize:20]];
        self.nameLabel.textColor = [UIColor colorWithRed:60/255.0 green:180/255.0 blue:80/255.0 alpha:1];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nameLabel];
        
        UIImageView *lineView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        lineView1.frame = CGRectMake(5, 60, [UIScreen mainScreen].applicationFrame.size.width - 5, 1);
        [self addSubview:lineView1];
        
        UILabel *phoneTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, 60, 12)];
        phoneTitle.text = @"联系电话";
        phoneTitle.font = [UIFont systemFontOfSize:11];
        phoneTitle.textColor = [UIColor grayColor];
        phoneTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:phoneTitle];
        
        self.phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 200, 29)];
        [self.phoneNumLabel setFont:[UIFont systemFontOfSize:20]];
        self.phoneNumLabel.textAlignment = NSTextAlignmentLeft;
        self.phoneNumLabel.textColor = [UIColor colorWithRed:60/255.0 green:180/255.0 blue:80/255.0 alpha:1];
        [self addSubview:self.phoneNumLabel];
        
        UIButton *phone = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width - 85, 65, 35, 44)];
        [phone setImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
        [phone addTarget:self action:@selector(makephone) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:phone];
        
        UIButton *msg = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width - 41, 65, 35, 44)];
        [msg setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        [msg addTarget:self action:@selector(makemessage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:msg];
        
        UIImageView *lineView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        lineView2.frame = CGRectMake(5, 110, [UIScreen mainScreen].applicationFrame.size.width - 5, 1);
        [self addSubview:lineView2];
        
        UILabel *remark = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, 40, 12)];
        remark.text = @"备注";
        remark.font = [UIFont systemFontOfSize:11];
        remark.textColor = [UIColor grayColor];
        remark.textAlignment = NSTextAlignmentLeft;
        [self addSubview:remark];
        
        self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, [UIScreen mainScreen].applicationFrame.size.width - 10 - 5, 59)];
        [self addSubview:self.remarkLabel];
        
        UIImageView *lineView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        lineView3.frame = CGRectMake(5, 190, [UIScreen mainScreen].applicationFrame.size.width - 5, 1);
        [self addSubview:lineView3];
    }
    return self;
}

-(void) makephone
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"makephone"
                                                        object:nil
                                                      userInfo:@{@"num":self.phoneNumLabel.text
                                                                 }];
}

-(void) makemessage
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"makemessage"
                                                        object:nil
                                                      userInfo:@{@"num":self.phoneNumLabel.text
                                                                 }];
}

@end
