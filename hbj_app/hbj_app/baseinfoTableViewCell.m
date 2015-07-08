//
//  baseinfoTableViewCell.m
//  hbj_app
//
//  Created by eidision on 14/12/1.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "baseinfoTableViewCell.h"

@implementation baseinfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)initSubViews
{
    UILabel *titleLable = [[UILabel alloc] init];//WithFrame:CGRectMake(5, 5, 100, 40)];
    UILabel *valueLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(110, 5, 200, 40)];
    
    //NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    
//    if ([[self.value class] isSubclassOfClass:NSString.class]) {
//        valueLabel.text = self.value;
//    }else if([[self.value class] isSubclassOfClass:NSNumber.class]){
//        valueLabel.text = [numberFormatter stringFromNumber:self.value];
//    }else{
//        valueLabel.text = [self.value stringValue];
//    }
    
    titleLable.text = self.title;
    valueLabel.text = self.value;
    //valueLabel.textvalueLabel.text = self.value;
    titleLable.textAlignment = NSTextAlignmentCenter;
    valueLabel.textAlignment = NSTextAlignmentLeft;
    
    CGSize size = CGSizeMake(170, 0);
    
    CGSize labelsize = [self.value boundingRectWithSize:size
                                                options:NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading
                                             attributes:@{
                                                          NSFontAttributeName:[UIFont fontWithName:nil size:18]
                                                          }
                                                context:nil].size;
    
    valueLabel.numberOfLines = 0;
    
    valueLabel.frame = CGRectMake(140, 5, 170, labelsize.height);
    titleLable.frame = CGRectMake(5, 5, 130, labelsize.height);
    
    valueLabel.font = [UIFont systemFontOfSize: 15.0];
    titleLable.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:16.0];
    
    [self addSubview:titleLable];
    [self addSubview:valueLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
