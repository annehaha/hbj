//
//  attentionTableTableViewController.h
//  hbj_app
//
//  Created by eidision on 14/12/21.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface attentionTableTableViewController : UITableViewController
{
    NSMutableDictionary *attentionDic;//{id:yes/no}
    NSMutableDictionary *idToDetail;//{id:[name, addr, type]}
    NSArray *idArray;
}

@end
