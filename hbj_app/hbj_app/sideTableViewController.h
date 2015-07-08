//
//  sideTableViewController.h
//  hbj_app
//
//  Created by eidision on 14/11/29.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sideTableViewController : UITableViewController
{
@private
    NSArray *_listArray;
    NSArray *_imageArray;
}

@property (nonatomic) NSInteger selectionNum;

@end
