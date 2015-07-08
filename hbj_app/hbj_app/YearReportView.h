//
//  SeasonReportView.h
//  hbj_app
//
//  Created by anne on 14/12/21.
//  Copyright (c) 2014年 zhaoxiaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NALLabelsMatrix.h"
#import "myNetworking.h"
#import "DejalActivityView.h"
@interface YearReportView : UIView
<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UILabel *label;
    UIPickerView *pickerview;
    UILabel *noInfo;
    
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
    
    UIButton* ok;
    
}
@property NALLabelsMatrix* monthTable;
@property UIScrollView *myScrollView;
@property NSArray *condition;
@end