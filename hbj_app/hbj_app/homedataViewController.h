//
//  homedataViewController.h
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NALLabelsMatrix.h"
#import "myNetworking.h"
#import "DejalActivityView.h"
@interface homedataViewController : UIViewController{
@private
    
    CGFloat          rowheight;//row height
    NSString         *selectionName;
    NSString         *flag;
    NSString         *type;
    NSString         *isRt;
}
@property NALLabelsMatrix* matrixNow;
@property NALLabelsMatrix* matrixHour;
@property UIButton *tableNowButton;
@property UIButton *tableHourButton;
@property UIButton *noiseButton;
@property UIButton *spmButton;
@property UIButton *dustButton;

@property UIScrollView *myScrollView;
@property NSArray *ids;

@end
