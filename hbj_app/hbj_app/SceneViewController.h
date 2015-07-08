//
//  SceneViewController.h
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sideTableViewController.h"
#import "baseInfoView.h"
#import <MessageUI/MessageUI.h>
#import "FSLineChart.h"
#import "DejalActivityView.h"

@interface SceneViewController : UIViewController <UIGestureRecognizerDelegate, MFMessageComposeViewControllerDelegate>
{
    sideTableViewController *sidetableViewController;
    UIView                  *sideView;
    UILabel                 *_addressLabel;
    UILabel                 *_titleLabel;
    UIView                  *mainView;
    NSDictionary            *_baseinfodic;
    
    NSMutableArray* chartData;
    NSMutableArray* chartData2;
     NSMutableArray* chartData3;

}

@property (nonatomic, strong) NSString       *portalID;
@property (nonatomic, strong) NSString       *portalname;
@property (nonatomic, strong) NSMutableArray *basevaluearray;

@end
