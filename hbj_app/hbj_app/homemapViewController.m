//
//  homemapViewController.m
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "homemapViewController.h"
#import "SceneViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "myNetworking.h"
#import "ZJLViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "loginView.h"
#import "plistOperation.h"

@interface homemapViewController ()
{
    UIButton *drawButton;
    UIButton *enterButton;
    UIButton *relocateButton;
    UIButton *left_side;
    double size_width;
    double size_height;
    double xSum;
    double ySum;
    NSString *userID;
}
@end

@implementation homemapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbackground"]]];
    
    size_width = (double)[UIScreen mainScreen].applicationFrame.size.width;
    size_height = (double)[UIScreen mainScreen].applicationFrame.size.height;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"地图方式查看";
    self.navigationItem.titleView = titleLabel;
    
    xSum = 0.0;
    ySum = 0.0;
    
    //left
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 85, 30)];
    UIButton *left_arrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 10, 18)];
    [left_arrow addTarget:self action:@selector(enterinto_attention) forControlEvents:UIControlEventTouchUpInside];
    [left_arrow setBackgroundImage:[UIImage imageNamed:@"menu_left"] forState:UIControlStateNormal];
    [backButton addSubview:left_arrow];
    [backButton setTitle:@"特别关注" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    backButton.titleLabel.textColor = [UIColor whiteColor];
    backButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [backButton addTarget:self action:@selector(enterinto_attention) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    //right
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"quit"] forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logoutButton];

    //assign for selectionItems
    [self assignForSelectionItems];
    
//    NSString *documentDirectory = [plistOperation applicationDocumentsDirectory];
//    NSString *path = [documentDirectory stringByAppendingPathComponent:@"logininfo.plist"];//不应该从资源文件中读取数据，资源文件中的数据没有更改，要从沙箱中的资源文件读取数据
//    
//    NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];//从资源文件中加载内容
//    userID = userInfoDic[@"userid"];
//    
//    NSLog(@"id : %@", userID);
//    
//    //assign for addressInfo
//    if (userID) {
//        [[NSUserDefaults standardUserDefaults] setValue:userInfoDic[@"userid"] forKey:@"userid"];
//    }else{
////        loginView *loginview = [[loginView alloc] initWithNibName:@"loginView" bundle:nil];
////        [self presentViewController:loginview animated:YES completion:nil];
//        [self logout];
//    }
    
    userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    [self assignForAddressInfo];
    
    //下拉菜单
    self.isHidden = YES;
    //初始在界面上展现的属性名称
    if ([self.selectionItems count] == 0) {
        NSLog(@"error");
        return;
    }
    selectionName = self.selectionItems[0];
    flag = @"Day";
    //选择按钮
    self.selectionButton = [[UIButton alloc] initWithFrame:CGRectMake(1/16.0 * size_width, 70, 10/32.0 * size_width, 30)];
    self.selectionView = [[UITableView alloc] initWithFrame:CGRectMake(1/16.0 * size_width, 100, 10/32.0 * size_width, 0)];
    [self.selectionButton setTitle:selectionName forState:UIControlStateNormal];
    [self.selectionButton setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [self.selectionButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [self.selectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.selectionButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [self.selectionButton addTarget:self action:@selector(expandableButton:) forControlEvents:UIControlEventTouchUpInside];
    self.selectionView.delegate = self;
    self.selectionView.dataSource = self;
    
    left_side = [[UIButton alloc] initWithFrame:CGRectMake(15/64.0 * size_width, 5, 1/16.0 * size_width, 20)];
    [left_side addTarget:self action:@selector(expandableButton:) forControlEvents:UIControlEventTouchUpInside];
    [left_side setImage:[UIImage imageNamed:@"left_down"] forState:UIControlStateNormal];
    [self.selectionButton addSubview:left_side];
    
    [self.view addSubview:self.selectionButton];
    [self.view addSubview:self.selectionView];
    
    //init idfromdraw
    self.idFromDraw = [[NSMutableArray alloc] init];
    
    //给下拉菜单添加手势
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(singleTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleRecognizer];
    singleRecognizer.delegate = self;
    
    //rowheight
    rowheight = 30;
    
    
    //日均值Button
    UIButton *mapDayAverageButton = [[UIButton alloc] initWithFrame:CGRectMake(3/8.0 * size_width, 70, 9/32.0 * size_width, 30)];
    [mapDayAverageButton setTitle:@"日均值" forState:UIControlStateNormal];
    //mapDayAverageButton.tag = 101;
    [mapDayAverageButton setBackgroundImage:[UIImage imageNamed:@"middle"] forState:UIControlStateNormal];
    [mapDayAverageButton setBackgroundImage:[UIImage imageNamed:@"middle_chosen"] forState:UIControlStateSelected];
    mapDayAverageButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [mapDayAverageButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [mapDayAverageButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [mapDayAverageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [mapDayAverageButton addTarget:self action:@selector(dayAverage:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapDayAverageButton];
    
    //时均值Button
    UIButton *mapHourAverageButton = [[UIButton alloc] initWithFrame:CGRectMake(21/32.0 * size_width, 70, 9/32.0 * size_width, 30)];
    [mapHourAverageButton setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [mapHourAverageButton setBackgroundImage:[UIImage imageNamed:@"right_chosen"] forState:UIControlStateSelected];
    [mapHourAverageButton setTitle:@"时均值" forState:UIControlStateNormal];
    //mapHourAverageButton.tag = 102;
    mapHourAverageButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [mapHourAverageButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [mapHourAverageButton setTitleColor:[UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [mapHourAverageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [mapHourAverageButton addTarget:self action:@selector(hourAverage:)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapHourAverageButton];
    
    //nowButton
    self.nowButton = mapDayAverageButton;
    [self.nowButton setSelected:TRUE];
    
    //init mapview
    //default for mapviewForDay
    self.mapview = [[MKMapView alloc] initWithFrame:CGRectMake(0, 105, size_width, size_height - 134)];
    self.mapview.delegate = self;
    self.mapview.mapType = MKMapTypeStandard;
    
//    [self relocate];
    [self.view addSubview:self.mapview];
    
    //button to enter drawimage
    drawButton = [[UIButton alloc] init];
    drawButton.frame = CGRectMake(1/32.0 * size_width, 200, 9/64.0 * size_width, 9/64.0 * size_width);
    //[drawButton setTitle:@"draw" forState:UIControlStateNormal];
    [drawButton setBackgroundImage:[UIImage imageNamed:@"drawicon"] forState:UIControlStateNormal];
    [drawButton addTarget:self action:@selector(enterIntoDrawImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:drawButton];
    [self.view bringSubviewToFront:drawButton];
    
    //button to relocate
    relocateButton = [[UIButton alloc] init];
    relocateButton.frame = CGRectMake(1/32.0 * size_width, 270, 9/64.0 * size_width, 9/64.0 * size_width);
    [relocateButton setBackgroundImage:[UIImage imageNamed:@"locateicon"] forState:UIControlStateNormal];
    [relocateButton addTarget:self action:@selector(relocate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:relocateButton];
    [self.view bringSubviewToFront:relocateButton];
    
    
//    [self relocate];
}

#pragma mark -preperations
//addressInfo
-(void) assignForRegionCoord
{
    //CLLocationCoordinate2D coordinate = {29.57052, 106.522288};
    if (xSum == 0.0 || ySum == 0.0) {
        [self alertWithTitle:@"网络异常" withMsg:@"网络不给力，请稍后重试"];
    }else{
        double x = xSum / [self.addressInfo count];
        double y = ySum / [self.addressInfo count];
        CLLocationCoordinate2D coordinate = {x, y};
        self.regionCoord = coordinate;
    }
}

- (void) alertWithTitle:(NSString *)title withMsg:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:@"取消", nil];
    [alert show];
}

-(void) assignForAddressInfo
{
    self.addressInfo = [[NSMutableDictionary alloc] init];
    self.observation = [[NSMutableDictionary alloc] init];
    
    //get location info from web
    NSString *ask = @"watchmonitor/user/";
    NSLog(@"id:%@", userID);
    
    [[myNetworking sharedClient] GET:[ask stringByAppendingString:userID] parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = result;
        NSMutableDictionary *tempnoise = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *tempsmp = [[NSMutableDictionary alloc] init];
        
        NSMutableDictionary *idtoNameAddr = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *attentionDic = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *tel = [[NSMutableDictionary alloc] init];
        
        //get attentionList
        NSMutableDictionary *attentionMsg = [[NSMutableDictionary alloc] init];
        
        NSDate *date = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:NSCalendarUnitHour fromDate:date];
        
        NSString *strHour = [NSString stringWithFormat:@"hour is %ld", (long)[components hour]];
        
        for (int i = 0 ; i < array.count; i ++) {
            NSDictionary *temp = array[i];
            
            NSString *locationX = [temp objectForKey:@"locationX"];
            NSString *locationY = [temp objectForKey:@"locationY"];
            NSString *Type = [temp objectForKey:@"type"];
            
            xSum += [locationX doubleValue];
            ySum += [locationY doubleValue];
            
            NSString *portalName = [temp objectForKeyedSubscript:@"name"];
            NSString *name = [temp objectForKey:@"address"];
            NSString *cityid = [temp objectForKey:@"monitorID"];
            CGPoint point = CGPointMake([locationX doubleValue],
                                        [locationY doubleValue]);
            
            [self.addressInfo setObject:@[name, [NSValue valueWithCGPoint:point], portalName] forKey:cityid];
            [idtoNameAddr setObject:@[portalName, name, Type] forKey:cityid];
            
            NSString *spm = [temp objectForKey:@"spmDay"];
            NSString *spmhour = [temp objectForKey:@"spmHour"];
            NSString *noise = [temp objectForKey:@"noiseDay"];
            NSString *noisehour = [temp objectForKey:@"noiseHour"];
            
            [tempsmp   setObject:@[spm, spmhour] forKey:cityid];
            [tempnoise setObject:@[noise, noisehour] forKey:cityid];
            
            NSString *attention = [temp objectForKeyedSubscript:@"attention"];
            NSString *phonenum = [temp objectForKeyedSubscript:@"phone"];
            NSString *noti = [temp objectForKey:@"notification"];
            [tel setObject:phonenum forKey:cityid];

            if ([attention isEqualToString:@"YES"]) {
                [attentionDic setObject:@"yes" forKey:cityid];
                
                NSString *msg = @"";
                //make the msg
                NSString *ar_notification = @"";
                //make ar_notification
                
                if ([strHour intValue] >= 6 && [strHour intValue] <= 22) {
                    if ([noisehour doubleValue] > 70) {
                        msg = [msg stringByAppendingString:@"噪声"];
                    }
                }else{
                    if ([noisehour doubleValue] > 55) {
                        msg = [msg stringByAppendingString:@"噪声"];
                    }
                }
                
                if ([spmhour doubleValue] > 1.0) {
                    if ([msg isEqualToString:@""]) {
                        msg = [msg stringByAppendingString:@"spm"];
                    }else{
                        msg = [msg stringByAppendingString:@",spm"];
                    }
                }
                
                if (![msg isEqualToString:@""]) {
                    msg = [msg stringByAppendingString:@"超标"];
                }else if (![noti isEqualToString:@""]){
                    ar_notification = noti;
                }
                
                //[attentionMsg setObject:msg forKey:cityid];
                [attentionMsg setObject:@[msg, ar_notification] forKey:cityid];
            }else{
                [attentionDic setObject:@"no" forKey:cityid];
            }
        }
        
        [self.observation setObject:tempnoise forKey:@"noise"];
        [self.observation setObject:tempsmp forKey:@"SPM"];
        
        if ([self.observation count] == 2) {
            [self assignForRegionCoord];
            
            [self relocate];
            
            [[NSUserDefaults standardUserDefaults] setObject:idtoNameAddr forKey:@"idToNameAndAddr"];
            [[NSUserDefaults standardUserDefaults] setObject:attentionDic forKey:@"attentionDic"];
            [[NSUserDefaults standardUserDefaults] setObject:attentionMsg forKey:@"attentionMsg"];
            [[NSUserDefaults standardUserDefaults] setObject:tel forKey:@"tel"];
            
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//observation
-(void) assignForObservation
{
    self.observation = [[NSMutableDictionary alloc] init];
}

//selectionItems
-(void) assignForSelectionItems
{
    self.selectionItems = @[@"SPM", @"noise"];
    //self.selectionItems = [self.observation allKeys];s
}

#pragma mark -selection
-(void) expandableButton:(UIButton* )sender
{
    [UIView animateWithDuration:0.2f animations:^{
        sender.userInteractionEnabled = NO;
        if (self.isHidden) {
            self.selectionView.frame = CGRectMake(1/16.0 * size_width, 100, 5/16.0 * size_width, (int)rowheight * self.selectionItems.count);
            [self.view bringSubviewToFront:self.selectionView];
        }else{
            [self hiddenTableView];
        }
    } completion:^(BOOL finished) {
        sender.userInteractionEnabled = YES;
        self.isHidden = !self.isHidden;
    }];
}

-(void) singleTap:(UITapGestureRecognizer*)recognizer
{
    CGPoint tapPoint = [recognizer locationInView:self.view];
    if (self.isHidden == NO && !CGRectContainsPoint(self.selectionView.frame, tapPoint)) {
        [self hiddenTableView];
        self.isHidden = YES;
    }
}

#pragma mark - IGestureRecognizerDelegate methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}

-(void)hiddenTableView
{
    self.selectionView.frame = CGRectMake(1/16.0 * size_width, 100, 5/16.0 * size_width, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectionItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowheight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    
    cell.textLabel.text = self.selectionItems[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithRed:82/255.0 green:190/255.0 blue:100/255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([selectionName isEqualToString:self.selectionItems[indexPath.row]]) {
        [self hiddenTableView];
        self.isHidden = YES;
        return;
    }
    selectionName = self.selectionItems[indexPath.row];
    [self.selectionButton setTitle:selectionName forState:UIControlStateNormal];
    [self hiddenTableView];
    self.isHidden = YES;
    [self.mapview removeAnnotations:currentAnnotations];
    currentAnnotations = nil;
    [self loadMap];
}

#pragma mark -mapView
//绘制地图
-(void)loadMap
{
    //example
    //121.434125,31.033182
    currentAnnotations = [[NSMutableArray alloc] init];
    NSDictionary *tempdict = [[NSDictionary alloc] initWithDictionary:self.observation[selectionName]];
    for (NSString *particularAddr in tempdict.allKeys) {
        CGPoint temppoint = [self.addressInfo[particularAddr][1] CGPointValue];
        double x = temppoint.x;
        double y = temppoint.y;
        CLLocationCoordinate2D tempcoordinate = {x, y};
        AnnotationInMap *annotationInMap = [[AnnotationInMap alloc] initWithCGLocation:tempcoordinate];
        NSArray *temparray = [tempdict objectForKey:particularAddr];
        if ([flag isEqualToString:@"Day"]) {
            annotationInMap.title = [NSString stringWithFormat:@"%.3f", [temparray[0] doubleValue]];
        }else{
            annotationInMap.title = [NSString stringWithFormat:@"%.3f", [temparray[1] doubleValue]];
        }
        
        annotationInMap.subtitle = [self.addressInfo objectForKey:particularAddr][2] ;//@"ok";
        annotationInMap.tag = particularAddr;
        [currentAnnotations addObject:annotationInMap];
        [self.mapview addAnnotation:annotationInMap];
    }
}

//点击每日图触发的函数
-(void)dayAverage:(id)sender
{
    if ([flag isEqualToString:@"Day"]) {
        return;
    }
    
    [self.nowButton setSelected:NO];
    self.nowButton = (UIButton *)sender;
    [self.nowButton setSelected:TRUE];
    
    [self hiddenTableView];
    //将下拉列表收起
    if (self.isHidden == NO) {
        self.isHidden = YES;
        return;
    }
    
    [self.mapview removeAnnotations:currentAnnotations];
    currentAnnotations = nil;
    flag = @"Day";
    [self loadMap];
}

//点击小时图触发的函数
-(void)hourAverage:(id)sender
{
    if ([flag isEqualToString:@"Hour"]) {
        return;
    }
    
    [self.nowButton setSelected:NO];
    
    self.nowButton = (UIButton *)sender;
    [self.nowButton setSelected:TRUE];
    [self hiddenTableView];
    //将下拉列表收起
    if (self.isHidden == NO) {
        self.isHidden = YES;
    }
    
    [self.mapview removeAnnotations:currentAnnotations];
    currentAnnotations = nil;
    flag = @"Hour";
    [self loadMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"heavy");
    // Dispose of any resources that can be recreated.
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView
           viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"annotation";
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:identifier];
    }
    
    if ([annotation isKindOfClass:[AnnotationInMap class]]) {
        
        if ([selectionName isEqualToString:@"SPM"]) {
            if ([((AnnotationInMap *)annotation).title doubleValue] > 1.0) {
                pinView.pinColor = MKPinAnnotationColorRed;
            }else{
                pinView.pinColor = MKPinAnnotationColorGreen;
            }
        }else{
            //get current time
            NSDate *date = [NSDate date];
            NSCalendar *cal = [NSCalendar currentCalendar];
            NSDateComponents *components = [cal components:NSCalendarUnitHour fromDate:date];
            
            NSString *strHour = [NSString stringWithFormat:@"hour is %ld", (long)[components hour]];
            
            NSLog(@"%@", strHour);
            
            if ([strHour intValue] >= 6 && [strHour intValue] <= 22) {
                if ([((AnnotationInMap *)annotation).title doubleValue] > 70) {
                    pinView.pinColor = MKPinAnnotationColorRed;
                    NSLog(@"hrer");
                }else{
                    pinView.pinColor = MKPinAnnotationColorGreen;
                }
            }else{
                if ([((AnnotationInMap *)annotation).title doubleValue] > 55) {
                    pinView.pinColor = MKPinAnnotationColorRed;
                }else{
                    pinView.pinColor = MKPinAnnotationColorGreen;
                }
            }
            
        }
        //pinView.pinColor = MKPinAnnotationColorRed;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        pinView.annotation = annotation;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton setImage:[UIImage imageNamed:@"enter_arrow"] forState:UIControlStateNormal];
         [rightButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
         pinView.rightCalloutAccessoryView = rightButton;
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[AnnotationInMap class]] == NO) {
        return;
    }
    AnnotationInMap *annotation = (AnnotationInMap *)view.annotation;
    _choosePlaceId = annotation.tag;
    _portalName = annotation.subtitle;
}

#pragma mark -relocate

-(void) relocate
{
    //精度
    MKCoordinateSpan span= {0.1, 0.1};
    MKCoordinateRegion region = {self.regionCoord, span};
    [self.mapview setRegion:region animated:YES];
    
    if ([currentAnnotations count]) {
        [self.mapview removeAnnotations:currentAnnotations];
    }
    
    currentAnnotations = nil;
    [self loadMap];
}

#pragma mark -drawImage
-(void) enterIntoDrawImage
{
    drawImageView = [[UIImageView alloc] initWithFrame:self.mapview.frame];
    drawImageView.image = [UIImage imageNamed:@"edit_bg.png"];
    drawImageView.userInteractionEnabled = YES;
    [self.view addSubview:drawImageView];
    
    /*
     |  Set the draw size
     |  设置画布大小
     */
    UIGraphicsBeginImageContext(drawImageView.frame.size);
    [drawImageView.image drawInRect:CGRectMake(0, 0, drawImageView.frame.size.width, drawImageView.frame.size.height)];
    
    /*
     |  Init line
     |  初始化线条；
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 53.0/255, 177.0/255, 20.0/255, 1.0);
    CGContextSetLineCap(context,kCGLineCapRound);
    CGContextSetLineWidth(context, 7.0);
    
    //[self removeAnnotationsOnTheMap];
    [drawButton setUserInteractionEnabled:NO];
    [enterButton setUserInteractionEnabled:NO];
    [relocateButton setUserInteractionEnabled:NO];
    [drawButton setAlpha:0.2f];
    [enterButton setAlpha:0.2f];
    [relocateButton setAlpha:0.2f];
    
    
}

-(void)clearFunction
{
    [drawImageView removeFromSuperview];
    UIGraphicsEndImageContext();
    
    UIActionSheet *jumpSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"选中%lu个地点\n请继续选择", (unsigned long)[self.idFromDraw count]]
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"柱状图对比", @"数据对比", @"相关新闻", nil];
    jumpSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [jumpSheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    //测试
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"showselectedItems"
//                                                        object:nil
//                                                      userInfo:@{@"ids":@[@"0001",@"0002"],
//                                                                 @"itemnum":[NSString stringWithFormat:@"%ld", (long)buttonIndex]
//                                                                 }];
    
//    real
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showselectedItems"
                                                        object:nil
                                                      userInfo:@{@"ids":self.idFromDraw,
                                                                 @"itemnum":[NSString stringWithFormat:@"%ld", (long)buttonIndex]
                                                                 }];
}

#pragma mark -touch && move
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view == drawImageView)
    {
        CGPoint location = [touch locationInView:drawImageView];
        pathRef = CGPathCreateMutable();
        CGPathMoveToPoint(pathRef, NULL, location.x, location.y);
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view == drawImageView)
    {
        /*
         |  Start draw point
         |  开始画线的第一个点
         */
        
        CGPoint location = [touch locationInView:drawImageView];
        
        /*
         |  draw line
         |  开始画线的路线
         */
        CGPoint pastLocation = [touch previousLocationInView:drawImageView];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, pastLocation.x, pastLocation.y);
        CGContextAddLineToPoint(context, location.x, location.y);
        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
        drawImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        CGPathAddLineToPoint(pathRef, NULL, location.x, location.y);
        
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*
     |  End draw
     |  结束绘画
     */
    UITouch *touch = [touches anyObject];
    if (touch.view == drawImageView)
    {
        /*
         |  Get Data and add point
         */
        
        CGPathCloseSubpath(pathRef);
        CLLocationCoordinate2D temLocation;
        CGPoint locationConverToImage;
        if ([self.addressInfo.allKeys count]>0)
        {
            
            if ([self.idFromDraw count]) {
                [self.idFromDraw removeAllObjects];
            }
            
            for (NSString *id in self.addressInfo.allKeys) {
                CGPoint temppoint = [self.addressInfo[id][1] CGPointValue];
                temLocation.latitude = temppoint.x;
                temLocation.longitude = temppoint.y;
                
                locationConverToImage = [self.mapview convertCoordinate:temLocation toPointToView:drawImageView];
                
                if (CGPathContainsPoint(pathRef, NULL, locationConverToImage, NO))
                {
                    [self.idFromDraw addObject:id];
                }
            }
        }

        [drawButton setUserInteractionEnabled:YES];
        [enterButton setUserInteractionEnabled:YES];
        [relocateButton setUserInteractionEnabled:YES];
        [drawButton setAlpha:0.6f];
        [enterButton setAlpha:0.6f];
        [relocateButton setAlpha:0.6f];
    }

    [self clearFunction];
    
}

#pragma mark -enterintoattention
-(void) enterinto_attention
{
    ZJLViewController *attentionView = [[ZJLViewController alloc] init];
    
    //[self.navigationController pushViewController:attentionView animated:NO];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:attentionView animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
}

#pragma mark -enterintodetail
-(void)push
{
    SceneViewController *sceneViewController = [[SceneViewController alloc] init];
    sceneViewController.portalID = _choosePlaceId;
    sceneViewController.portalname = _portalName;
    
    [self.navigationController pushViewController:sceneViewController animated:YES];
}


#pragma mark -logout
-(void) logout
{
    [self alertWithTitle:@"提醒" withMsg:@"确定登出？"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        //loginView *loginview = [[loginView alloc] initWithNibName:@"loginView" bundle:nil];
        //[self presentViewController:loginview animated:YES completion:nil];
    }
}

#pragma mark -tapGesture
//action for singleTap
//-(void) singleTap:(UITapGestureRecognizer *)recognizer
//{
//
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = NO;
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

@end
