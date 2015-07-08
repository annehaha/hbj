//
//  Yxldb.h
//  hbj_app
//
//  Created by anne on 14/12/21.
//  Copyright (c) 2014年 zhaoxiaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPickView.h"
#import "UIColor+FSPalette.h"
#import "SimpleBarChart.h"
#import "myNetworking.h"

@interface YxldbView : UIView
<SimpleBarChartDataSource, SimpleBarChartDelegate>
{
    NSArray *_values;
    SimpleBarChart *_chart;
    NSArray *_barColors;
    NSInteger _currentBarColor;
    NSInteger count;
    
    UILabel *startShow;
    UILabel *endShow;
    
    UIButton* ok;
    BOOL islate;
    int ifStart;
}
@property UIScrollView *myScrollView;;
@property NSMutableArray *getArray;
@property NSMutableArray *getArray2;
@property ZHPickView *pick;
@end