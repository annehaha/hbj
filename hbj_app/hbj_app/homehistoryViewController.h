//
//  homehistoryViewController.h
//  hbj_app
//
//  Created by eidision on 14/11/23.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Example2PieView.h"
#import "MyPieElement.h"
#import "PieLayer.h"
#import "NALLabelsMatrix.h"
#import "GdfbView.h"
#import "MonthReportView.h"
#import "SeasonReportView.h"
#import "YearReportView.h"
#import "YxldbView.h"
#import "Top5citeView.h"
#import "CbbhView.h"

@interface homehistoryViewController : UIViewController
<UIPickerViewDelegate,UIPickerViewDataSource>
{
    // UILabel *label;
    UIPickerView *pickerview;
    UIPickerView *pickerview2;
    UIPickerView *pickerview3;
    
    UILabel *titleLabel;
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
    
    UIButton * navRightButton;
    UIImageView* _clearImg;
    bool _clearFlag;
    
    UIButton* _lcksBtn;
    UIButton* _wjxxBtn;
    UIButton* _jkpgBtn;
    UIButton* _gdfbBtn;
    UIButton* _jhssBtn;
    UIButton* _sszjBtn;
    UIButton* _khssBtn;
    
    UIButton* ok;
    
    int _mmMainFX;
    int _mmMainFY;
    int _vFX;
    int _vFY;
}
@property (nonatomic,retain) IBOutlet UILabel *label;
@property (nonatomic,retain) IBOutlet UIPickerView *pickerview;

@property Example2PieView* pieView;
@property NALLabelsMatrix* monthTable;
@property UIScrollView *myScrollView;
@property GdfbView *gdfb;
@property MonthReportView *month;
@property SeasonReportView *season;
@property YearReportView *year;
@property YxldbView *yxldb;
@property Top5citeView *top;
@property CbbhView *cbbh;
@end
