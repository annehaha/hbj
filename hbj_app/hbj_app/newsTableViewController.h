//
//  newsTableViewController.h
//  hbj_app
//
//  Created by eidision on 14/12/27.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DejalActivityView.h"

@interface newsTableViewController : UITableViewController <UIScrollViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray      *idArray;
@property (nonatomic, strong) NSMutableDictionary *idToDetail;//{id:[name, addr, type]}
@property (nonatomic, strong) NSMutableArray      *newsArray; //[id, title, text,url]

@end
