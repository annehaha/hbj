//
//  hometableViewController.h
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+FSPalette.h"
#import "SimpleBarChart.h"
#import "myNetworking.h"
#import "DejalActivityView.h"

#define degreeTOradians(x) (M_PI * (x)/180)

@interface hometableViewController : UIViewController<SimpleBarChartDataSource, SimpleBarChartDelegate>
{
    NSArray *_values;
    SimpleBarChart *_chart;
    NSArray *_barColors;
    NSInteger _currentBarColor;
    NSInteger count;
    NSString         *type;
    NSString         *isRt;
}
@property UIScrollView *myScrollView;;
@property UIButton *nowTableBtn;
@property UIButton *hourTableBtn;
@property UIButton *noiseButton;
@property UIButton *dustButton;
@property NSMutableArray *getArray;
@property NSMutableArray *getArray2;
@property NSArray *ids;
@end
