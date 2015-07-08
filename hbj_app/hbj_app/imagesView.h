//
//  imagesView.h
//  hbj_app
//
//  Created by eidision on 14/12/7.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface imagesView : UIView<UIScrollViewDelegate>

//@property (nonatomic, strong)NSString  *portalID;//portal id
@property int count;//the total amount of count
@property (nonatomic ,strong)UIScrollView *scrollview;
@property (nonatomic, strong)UILabel *titleLable;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)NSMutableArray *timeArray;
@property (nonatomic, strong)UIImageView *waitImageView;
-(void)resizeScrollView;
-(void)assignforView: (NSMutableArray *)imageArray;

@end
