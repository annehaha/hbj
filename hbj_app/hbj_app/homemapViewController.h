//
//  homemapViewController.h
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AnnotationInMap.h"

@interface homemapViewController : UIViewController <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate, UIAlertViewDelegate>
{
@private
    
    UIImageView *drawImageView;
    CGMutablePathRef pathRef;
    
    CGFloat          rowheight;//row height
    NSString         *selectionName;
    NSMutableArray   *currentAnnotations;
    NSString         *flag;
    NSString         *_choosePlaceId;
    NSString         *_portalName;
}

#pragma mark -properties for ui
@property (nonatomic) MKMapView              *mapview;
@property (nonatomic) UILabel                *messagelabel;
@property (nonatomic) CLLocationCoordinate2D regionCoord;
@property (nonatomic) UIButton               *selectionButton;//下拉button
@property (nonatomic) UITableView            *selectionView;//下拉菜单
@property (nonatomic) BOOL                   isHidden;
@property (nonatomic) UIButton               *nowButton;

#pragma mark -properties for logic
@property (nonatomic) NSMutableDictionary *addressInfo;//观测点地址
@property (nonatomic) NSMutableDictionary *observation;//观测指数
@property (nonatomic) NSArray             *selectionItems;//下拉列表数据 (selectionItems 是 observation 的key组成的)

@property (nonatomic) NSMutableArray      *idFromDraw;

-(void) assignForObservation;
-(void) assignForAddressInfo;

/*
 addressInfo
 addressName  : (CGPoint)
 point
 
 observation
 observation1 : (NSDictionary)
 |--addressName1 : (NSString)
 |--valueForDay [0]
 |--valueForHour[1]
 |--addressName2 : (NSString)
 |--valueForDay [0]
 |--valueForHour[1]
 observation2 :
 observation3 :
 observation4 :
 */

@end
