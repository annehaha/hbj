//
//  GdfbView.h
//  hbj_app
//
//  Created by anne on 14/12/21.
//  Copyright (c) 2014年 zhaoxiaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Example2PieView.h"
#import "MyPieElement.h"
#import "PieLayer.h"
#import "ZHPickView.h"
#import "myNetworking.h"
#import "DejalActivityView.h"
@interface GdfbView : UIView
<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UILabel *startShow;
    UILabel *endShow;
    
    
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
    
    NSMutableArray *cites;
    
    UIButton* ok;
    
    int ifStart;
    BOOL islate;
    
    int _mmMainFX;
    int _mmMainFY;
    int _vFX;
    int _vFY;
    
    UILabel *noInfo;
    
    NSMutableDictionary *addr;
}

@property (nonatomic,retain) IBOutlet UIPickerView *pickerview;
@property UIScrollView *myScrollView;
@property Example2PieView* pieView;
@property ZHPickView *pick;
@end