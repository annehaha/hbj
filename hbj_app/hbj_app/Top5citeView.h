//
//  Top5citeView.h
//  hbj_app
//
//  Created by anne on 14/12/21.
//  Copyright (c) 2014年 zhaoxiaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NALLabelsMatrix.h"
#import "myNetworking.h"
#import "DejalActivityView.h"
@interface Top5citeView : UIView
<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UILabel *label;
    UIPickerView *pickerview;
    UILabel *txt2;
    UILabel *txt3;
    UILabel *txt4;
    
    NSArray *arr1;
    
    UIButton* ok;
    
}
@property NALLabelsMatrix* monthTable;
@property UIScrollView *myScrollView;
@property NSArray *condition;
@end