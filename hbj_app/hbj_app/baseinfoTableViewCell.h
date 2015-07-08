//
//  baseinfoTableViewCell.h
//  hbj_app
//
//  Created by eidision on 14/12/1.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baseinfoTableViewCell : UITableViewCell

@property (nonatomic) NSString *title;
@property (nonatomic) id value;

- (void)initSubViews;

@end
