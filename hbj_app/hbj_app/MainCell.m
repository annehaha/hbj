//
//  MainCell.m
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _Headerphoto = [[UIImageView alloc]initWithFrame:CGRectMake(11, 10, 40, 40)];
        [self.contentView addSubview:_Headerphoto];
    
        //名字
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 160, 25)];
        _nameLabel.backgroundColor  = [UIColor clearColor];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        
        //简介
        _IntroductionLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 28, 240, 25)];
        _IntroductionLabel.backgroundColor  = [UIColor clearColor];
        _IntroductionLabel.textColor = [UIColor lightGrayColor];
        _IntroductionLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_IntroductionLabel];
        
        //网络
        _networkLabel = [[UILabel alloc]initWithFrame:CGRectMake(225, 5, 90, 25)];
        _networkLabel.backgroundColor  = [UIColor clearColor];
        _networkLabel.textColor = [UIColor lightGrayColor];
        _networkLabel.font = [UIFont systemFontOfSize:13];
        _networkLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_networkLabel];
        
        //分割线
        _imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 59, 320, 1)];
        [self.contentView addSubview:_imageLine];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)setMainCell
{
    
}

@end

