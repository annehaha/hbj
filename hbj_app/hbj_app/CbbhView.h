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
@interface CbbhView : UIView

{
    UILabel *label;
     UILabel *label2;
    UIButton* ok;
    
}
@property NALLabelsMatrix* monthTable;
@property UIScrollView *myScrollView;

@end