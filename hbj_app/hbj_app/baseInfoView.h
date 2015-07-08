//
//  baseInfoView.h
//  hbj_app
//
//  Created by eidision on 14/11/29.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baseInfoView : UIView <UITableViewDelegate, UITableViewDataSource>

{
@private
    int _length;
}

@property (nonatomic, strong) NSString            *portalID;
@property (nonatomic, strong) UITableView         *baseInfoTableView;
@property (nonatomic)         NSArray             *baseInfo;
@property (nonatomic)         NSArray             *observationItem;
@property (nonatomic)         NSMutableArray      *value;
@property (nonatomic)         NSString            *name;
@property (nonatomic)         UILabel             *tempLabel;

//- (void) loadvalue;
-(void) loadname;
@end
