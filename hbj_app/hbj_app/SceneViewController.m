//
//  SceneViewController.m
//  hbj_app
//
//  Created by eidision on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "SceneViewController.h"
#import "sideTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "baseInfoView.h"
#import "imagesView.h"
#import "cameraView.h"
#import "statisticsInfoView.h"
#import "supervisorInfoView.h"
#import "myNetworking.h"

#define RCloseDuration 0.3f
#define ROpenDuration 0.4f
#define RContentOffset 170.0f

typedef NS_ENUM(NSInteger, RMoveDirection) {
    RMoveDirectionLeft = 0,
    RMoveDirectionRight
};

@interface SceneViewController (){
    MFMessageComposeViewController *controller;
    UIView *left_upper;
    UIView *right_upper;
    UIView *right_lower;
}

@end

@implementation SceneViewController
{
    CGSize size;
    CGFloat width;
    NSInteger flag;
    UITapGestureRecognizer *_tapGestureRec;
    UIView *shadow;
    CGRect myframe;
    NSString *contactName;
    NSString *contactNum;
    NSMutableArray *photosArray;
}

-(void)loadView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGSize screensize = [UIScreen mainScreen].applicationFrame.size;
    CGFloat barheight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusheight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    myframe = CGRectMake(0, barheight + statusheight, screensize.width, screensize.height - barheight);
    
    width = screensize.width;
    
    flag = 0;
    
    UIView *baseview = [[UIView alloc] initWithFrame:myframe];
    self.view = baseview;
    self.tabBarController.tabBar.hidden = YES;
    
    //navigationItem左按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
    
    UIButton *left_arrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 10, 18)];
    [left_arrow setBackgroundImage:[UIImage imageNamed:@"menu_left"] forState:UIControlStateNormal];
    [left_arrow addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    [backButton addSubview:left_arrow];
    
    [backButton setTitle:@"地图" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    backButton.titleLabel.textColor = [UIColor whiteColor];
    backButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [backButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *chooseButton = [[UIBarButtonItem alloc] initWithTitle:@"操作" style:UIBarButtonItemStylePlain target:self action:@selector(operation)];
    [chooseButton setTitleTextAttributes:@{
                                          NSFontAttributeName: [UIFont systemFontOfSize:16],
                                          NSForegroundColorAttributeName: [UIColor whiteColor],
                                          }
                                forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = chooseButton;
    
    sidetableViewController = [[sideTableViewController alloc] init];
    [self addChildViewController:sidetableViewController];
    sideView = [[UIView alloc] initWithFrame:CGRectMake(width, 60, 170, 503)];
    //[self.view addSubview:sideView];
    
    //[sideView addSubview: sidetableViewController.view];
    
    sidetableViewController.selectionNum = 0;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 25)];
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 140, 15)];
    
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    
    _addressLabel.text = self.portalname;
    _addressLabel.textAlignment = NSTextAlignmentCenter;
    _addressLabel.textColor = [UIColor whiteColor];
    [_addressLabel setFont:[UIFont fontWithName:@"GeezaPro" size:12]];
    
    [topView addSubview:_titleLabel];
    [topView addSubview:_addressLabel];
    
    self.navigationItem.titleView = topView;
    //    [self.navigationItem.titleView addSubview:_titleLabel];
    //    [self.navigationItem.titleView addSubview:_addressLabel];
    
    //给菜单添加手势
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                             action:@selector(operation)];
    _tapGestureRec.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:_tapGestureRec];
    _tapGestureRec.delegate = self;
    _tapGestureRec.enabled = NO;
    
    //shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width-100, height)];
    //shadow.alpha = 0.1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(chooseDone)
                                                 name:(@"chooseDone")
                                               object:nil];
    
    //中央mainView
    sidetableViewController.selectionNum = 0;
    [self chooseDone];
    
    [self.view addSubview:mainView];

    [self.view bringSubviewToFront:mainView];
    
    photosArray = [[NSMutableArray array] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statisticsLeft)
                                                 name:(@"statisticsLeft")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statisticsRight)
                                                 name:(@"statisticsRight")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(makephone:)
                                                 name:(@"makephone")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(makemessage:)
                                                 name:(@"makemessage")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(left)
                                                 name:(@"left")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(right)
                                                 name:(@"right")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(up)
                                                 name:(@"up")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(down)
                                                 name:(@"down")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(in)
                                                 name:(@"in")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(out)
                                                 name:(@"out")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(no)
                                                 name:(@"no")
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)operation {
    
    CGAffineTransform conT;
    
    if (!flag) {
        
        if (!shadow) {

            shadow = [[UIView alloc] initWithFrame:self.view.frame];
            shadow.backgroundColor = [UIColor colorWithWhite:0.0f alpha:1];
            
            UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction)];
            [shadow addGestureRecognizer:bgTap];
        }
        
        conT = [self transformWithDirection:RMoveDirectionLeft];
        flag = 1;
        [UIView animateWithDuration:ROpenDuration
                         animations:^{
                             sideView.transform = conT;
                             
                             shadow.alpha = 0.3f;
                             sideView.alpha = 1;
                             
                             shadow.alpha = 0.5f;
                             sideView.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             [self.view addSubview:shadow];

                             [sideView addSubview: sidetableViewController.view];
                             [self.view addSubview:sideView];
                             [self.view bringSubviewToFront:sideView];
                             
                             _tapGestureRec.enabled = YES;
                         }
         ];
        
    }
    
    else {
        
        conT = [self transformWithDirection:RMoveDirectionRight];
        flag = 0;
        [UIView animateWithDuration:ROpenDuration
                         animations:^{
                             sideView.transform = conT;
                             
                             shadow.alpha = 0.5f;
                             sideView.alpha = 0.5;
                             
                             shadow.alpha = 0.3f;
                             sideView.alpha = 0.3f;
                         }
                         completion:^(BOOL finished) {
                             [shadow removeFromSuperview];
                             [sideView removeFromSuperview];
                             
                             _tapGestureRec.enabled = NO;
                         }];
        

    }
}

-(void)bgTappedAction
{
    [self operation];
}

/*- (void)closeSideBar
{
    flag = 0;
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
    [UIView animateWithDuration:ROpenDuration
                     animations:^{
                         sideView.transform = conT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = NO;
                     }];
    
}*/

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}

- (CGAffineTransform)transformWithDirection:(RMoveDirection)direction
{
    CGFloat translateX = 0;
    
    switch (direction) {
        case RMoveDirectionLeft:
            translateX = -RContentOffset;
            break;
        case RMoveDirectionRight:
            translateX = RContentOffset;
            break;
        default:
            break;
    }
    
    //CGAffineTransformMakeTranslation：移动，创建一个平移的变化
    //它将返回一个CGAffineTransform类型的仿射变换，这个函数的两个参数指定x和y方向上以点为单位的平移量。
    //假设是一个视图，那么它的起始位置 x 会加上tx , y 会加上 ty
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    
    //CGAffineTransformMakeScale：缩放，创建一个给定比例放缩的变换
    //假设是一个图片视图引用了这个变换，那么图片的宽度就会变为 width*sx ，对应高度变为 hight * sy。
    CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0, 1);//RContentScale = 0.83f
    
    //CGAffineTransformConcat 通过两个已经存在的放射矩阵生成一个新的矩阵t' = t1 * t2
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}

#pragma mark -load_different_view
-(void) chooseDone
{
    if (mainView) {
        [mainView removeFromSuperview];
    }
    
    switch (sidetableViewController.selectionNum) {
        case 0:
        {
            UIView *viewToUse = self.view;
            [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];

            [self loadbaseInfoView];
            break;
        }
        case 1:
            [self loadstatisticsInfoView];
            break;
            
        case 2:
        {
            UIView *viewToUse = self.view;
            [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];
            
            [self loadimagesView];
            break;
        }
            
        case 3:
        {
            UIView *viewToUse = self.view;
            [DejalBezelActivityView activityViewForView:viewToUse withLabel:@"载入中..." width:100];

            [self loadcameraView];
            break;
        }
            
        case 4:
            [self loadsupervisorInfoView];
            break;
        default:
            break;
    }
    
    NSLog(@"%ld", (long)sidetableViewController.selectionNum);
    [self.view addSubview:mainView];
    [self.view bringSubviewToFront:sideView];
    
    //if the sideview is showing
    if (flag == 1) {
        [self operation];
    }
}

-(void) loadbaseInfoView
{
    _titleLabel.text = @"监测点基本信息";
    baseInfoView *tempbaseInfoView = [[baseInfoView alloc] initWithFrame:myframe];
    //tempbaseInfoView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:1];
    tempbaseInfoView.portalID = self.portalID;
    tempbaseInfoView.name = self.portalname;
    
    [tempbaseInfoView loadname];

    if (self.basevaluearray == nil || [self.basevaluearray count] != 17)
    {
        NSString *askbase = @"wholemonitor/maxtime/";
        NSString *ask = [askbase stringByAppendingString:tempbaseInfoView.portalID];

        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            
            NSDictionary *baseinfodic = result;
            self.basevaluearray = [[NSMutableArray alloc] init];
            NSString *address = [baseinfodic objectForKey:@"address"];
            
            //NSString *name = [baseinfodic objectForKey:@"name"];
            
            NSString *type = [baseinfodic objectForKey:@"type"];
            NSString *locationX = [baseinfodic objectForKey:@"locationX"] ;
            NSString *locationY = [baseinfodic objectForKey:@"locationY"];
            //NSString *introduction = [temp objectForKey:@"introduction"];
            
            NSString *startDate = nil;
            
            if ([[[baseinfodic objectForKey:@"startDate"] class] isSubclassOfClass:NSNull.class]) {
                startDate = @"";
            }else{
                startDate = [baseinfodic objectForKey:@"startDate"];
            }
            
            NSString *endDate = nil;
            
            if ([[[baseinfodic objectForKey:@"endDate"] class] isSubclassOfClass:NSNull.class]) {
                endDate = @"";
            }else{
                endDate = [baseinfodic objectForKey:@"endDate"];
            }
            
            NSString *company = nil;
            
            if ([[[baseinfodic objectForKey:@"company"] class] isSubclassOfClass:NSNull.class]) {
                company = @"";
            }else{
                company = [baseinfodic objectForKey:@"company"];
            }
            
            contactName = [baseinfodic objectForKey:@"contact"];
            contactNum = [baseinfodic objectForKey:@"phone"];

            [self.basevaluearray addObject:address];
            [self.basevaluearray addObject:locationX];
            [self.basevaluearray addObject:locationY];
            [self.basevaluearray addObject:company];
            [self.basevaluearray addObject:type];
            //[self.value addObject:introduction];
            [self.basevaluearray addObject:startDate];
            [self.basevaluearray addObject:endDate];
            [self.basevaluearray addObject:contactName];
            [self.basevaluearray addObject:contactNum];
            
            //[tempbaseInfoView.baseInfoTableView reloadData];

            NSString *time = [baseinfodic objectForKey:@"time"];
            NSString *spm = [baseinfodic objectForKey:@"spm"];
            NSString *noise = [baseinfodic objectForKey:@"noise"];
            NSString *windDirection = [baseinfodic objectForKey:@"windDirection"];
            NSString *windSpeed = [baseinfodic objectForKey:@"windSpeed"];
            NSString *temperature = [baseinfodic objectForKey:@"temperature"];
            NSString *humidity = [baseinfodic objectForKey:@"humidity"];
            NSString *pressure = [baseinfodic objectForKey:@"pressure"];
            
            [self.basevaluearray addObject:time];
            [self.basevaluearray addObject:spm];
            [self.basevaluearray addObject:noise];
            [self.basevaluearray addObject:windDirection];
            [self.basevaluearray addObject:windSpeed];
            [self.basevaluearray addObject:temperature];
            [self.basevaluearray addObject:humidity];
            [self.basevaluearray addObject:pressure];
            
            tempbaseInfoView.value = self.basevaluearray;
            [tempbaseInfoView.baseInfoTableView reloadData];
            
            [DejalBezelActivityView removeViewAnimated:YES];
            [[self class] cancelPreviousPerformRequestsWithTarget:self];
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"fuck");
        }];
    }

    tempbaseInfoView.value = self.basevaluearray;
    //[tempbaseInfoView loadvalue];
    mainView = tempbaseInfoView;
    //NSLog(@"basevaluearray：%@", self.basevaluearray);
}

-(void) loadimagesView
{
    _titleLabel.text = @"监测点照片";
    imagesView *tempimageView = [[imagesView alloc] initWithFrame:myframe];
    
    //tempimageView.portalID = self.portalID;
    
    //get images from server

    //NSString *ask = [askbase stringByAppendingString:tempimageView.portalID];
    tempimageView.count = 10;
    
    [tempimageView resizeScrollView];
    
    [[myNetworking sharedClient1] GET:@"viewPhoto" parameters:@{@"csite_id":self.portalID} success: ^(AFHTTPRequestOperation *operation, id result) {
        NSArray *photos = result;
        
        [DejalBezelActivityView removeViewAnimated:YES];
        [[self class] cancelPreviousPerformRequestsWithTarget:self];
        
        if (photos != nil) {
            for (int i = 0 ; i < tempimageView.count; i ++) {
                NSDictionary *temp = photos[i];
                NSString *photo_time = [temp objectForKey:@"time"];
                NSString *url = [temp objectForKey:@"url"];
                [photosArray addObject:@[photo_time, url]];
            }
            [tempimageView assignforView: photosArray];
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"image fail");
    }];
    
    
    mainView = tempimageView;
}

-(void) loadcameraView
{
    _titleLabel.text = @"监测点实时";
    cameraView *tempcameraview = [[cameraView alloc] initWithFrame:myframe];
    mainView = tempcameraview;
    [self no];
}

-(void) loadstatisticsInfoView
{
    _titleLabel.text = @"监测点统计信息";
    statisticsInfoView *statisticsinfoView = [[statisticsInfoView alloc] initWithFrame:myframe];
    mainView = statisticsinfoView;
    [self statisticsLeft];
}

-(void) loadsupervisorInfoView
{
    _titleLabel.text = @"负责人信息";
    supervisorInfoView *tempvisorinfoView = [[supervisorInfoView alloc] initWithFrame:myframe];
    
    //tempvisorinfoView.photoImageView.image = [UIImage imageNamed:@""];
    tempvisorinfoView.nameLabel.text = contactName;
    tempvisorinfoView.phoneNumLabel.text = contactNum;
    tempvisorinfoView.remarkLabel.text = @"";
    
    mainView = tempvisorinfoView;
}

#pragma mark -left&right
-(void) loadstatisticsleftInfo
{
    //here get smp info
}

-(void) loadstatisticsrigthInfo
{
    //here get noise info
}


#pragma mark- proxy
-(void) makephone:(NSNotification *)notify
{
    NSString *phonenumber = notify.userInfo[@"num"];
    if (!phonenumber || [phonenumber isEqualToString:@""]) {
        return;
    }
    UIWebView *callWebview =[[UIWebView alloc] initWithFrame:CGRectMake(0, 320, 320, 200)];
    NSURL *telURL =[NSURL URLWithString:[@"tel://" stringByAppendingString:phonenumber]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    callWebview.backgroundColor = [UIColor blackColor];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

//-(void) makemessage:(NSNotification *)notify
//{
//    NSString *phonenumber = notify.userInfo[@"num"];
//    UIWebView *callWebview =[[UIWebView alloc] initWithFrame:mainView.frame];
//    NSURL *telURL =[NSURL URLWithString:[@"sms://" stringByAppendingString:phonenumber]];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
//    callWebview.backgroundColor = [UIColor blackColor];
//    //记得添加到view上
//    [self.view addSubview:callWebview];
//}

-(void) makemessage:(NSNotification *)notify
{
    NSString *phonenumber = notify.userInfo[@"num"];
    
    if (!phonenumber || [phonenumber isEqualToString:@""]) {
        return;
    }
    
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
    NSLog(@"can send SMS [%d]", canSendSMS);
    if (canSendSMS) {
        
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.navigationBar.tintColor = [UIColor blackColor];
        picker.body = [NSString stringWithFormat:@"%@出现异常，请重点观察。", self.portalname];
        // 默认收件人(可多个)
        picker.recipients = [NSArray arrayWithObject:phonenumber];
        //[self presentModalViewController:picker animated:YES];
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)messageComposeViewController :(MFMessageComposeViewController *)controller didFinishWithResult :( MessageComposeResult)result {
    
    // Notifies users about errors associated with the interface
    switch (result) {
        case MessageComposeResultCancelled:
            if (DEBUG) NSLog(@"Result: canceled");
            break;
        case MessageComposeResultSent:
            if (DEBUG) NSLog(@"Result: Sent");
            break;
        case MessageComposeResultFailed:
            if (DEBUG) NSLog(@"Result: Failed");
            break;
        default:
            break;
    }
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- statistics
-(void)statisticsLeft
{
     statisticsInfoView *tempview1 = (statisticsInfoView *)mainView;
//    [tempview1 addSubview:[self chart1]];
//    tempview1.upperView=[self chart1];
    left_upper = [self chart1];
    tempview1.day.text=@"";
    
    if (right_lower) {
        [right_lower removeFromSuperview];
        right_lower = nil;
    }
    
    if (right_upper) {
        [right_upper removeFromSuperview];
        right_upper = nil;
    }
    
    [tempview1 addSubview:left_upper];
    
    tempview1.night.text=@"";
}

-(void)statisticsRight
{
    
     statisticsInfoView *tempview2 = (statisticsInfoView *)mainView;
    tempview2.day.text=@"日间噪声变化：";
    
    tempview2.night.text=@"夜间噪声变化：";
    
    if (left_upper) {
        [left_upper removeFromSuperview];
        left_upper = nil;
    }
    
    right_upper=[self chart2];
    right_lower=[self chartNight];
    
    [tempview2 addSubview:right_lower];
    [tempview2 addSubview:right_upper];
//    [tempview2 addSubview:[self chart2]];
//    [tempview2 addSubview:[self chartNight]];
}

#pragma mark -imageAction
-(void)left
{
    [self do_something_with_camera:@"LEFT"];
}

-(void)right
{
    [self do_something_with_camera:@"RIGHT"];
}

-(void)up
{
    [self do_something_with_camera:@"UP"];
}

-(void)down
{
    [self do_something_with_camera:@"DOWN"];
}

-(void)in
{
    [self do_something_with_camera:@"IN"];
}

-(void)out
{
    [self do_something_with_camera:@"OUT"];
}

-(void)no
{
    [self do_something_with_camera:@"NO"];
}

- (void) do_something_with_camera: (NSString*) order {
    cameraView *tempview = (cameraView *)mainView;
    [tempview.cameraView setImage:[UIImage imageNamed:@"camera_wait"]];
    [[myNetworking sharedClient1] GET:@"takePhoto" parameters:@{@"csite_id":self.portalID, @"order":order}
                             success: ^(AFHTTPRequestOperation *operation, id result) {
                                 NSDictionary *photo = result;
                                 if (photo != nil) {
                                     NSURL *tempurl = [NSURL URLWithString:[photo objectForKey:@"url"]];
                                     [tempview.cameraView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:tempurl]]];
                                 }
                                 
                                 [DejalBezelActivityView removeViewAnimated:YES];
                                 [[self class] cancelPreviousPerformRequestsWithTarget:self];
                                 
                             } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                                 [tempview.cameraView setImage:[UIImage imageNamed:@"camera_wait_fail"]];
                             }];
    
}

#pragma mark- return
-(void)cancelPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

-(FSLineChart*)chart1
{
    //  NSMutableArray* chartData= [NSMutableArray arrayWithCapacity:10];
    srand(time(nil));
    
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(25, 140, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    NSString *ask = @"day10/";
    if(self.portalID){
        ask=[ask stringByAppendingString:self.portalID];
        //ask=[ask stringByAppendingString:@"897"];
        
        NSLog(@"%@",ask);
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            if([array count]!=0){
                chartData= [[NSMutableArray alloc]init];
                for (int i = 0 ; i < array.count; i ++) {
                    NSDictionary *temp = array[i];
                    if([[temp objectForKey:@"spm"] doubleValue]>0.00){
                        NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"spm"] doubleValue]];
                        
                        [chartData addObject:n];
                    }
                }
                [chartData addObject:[NSNumber numberWithInt:1]];
                [chartData addObject:[NSNumber numberWithInt:1]];
                
                // Creating the line chart
                
                lineChart.verticalGridStep = 3;
                lineChart.horizontalGridStep = 15;
                //lineChart.fillColor = nil;
                
                lineChart.labelForIndex = ^(NSUInteger item) {
                    return [NSString stringWithFormat:@"%lu",(unsigned long)item];
                };
                
                lineChart.labelForValue = ^(CGFloat value) {
                    return [NSString stringWithFormat:@"%.f", value];
                };
                
                [lineChart setChartData:chartData];

            }
            
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
    return lineChart;
}


-(FSLineChart*)chart2
{
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(25, 140, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    srand(time(nil));
    
    NSString *ask = @"day10/";
    if(self.portalID){
        ask=[ask stringByAppendingString:self.portalID];
        //ask=[ask stringByAppendingString:@"897"];
        
        NSLog(@"%@",ask);
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            if([array count]!=0){
                chartData2= [[NSMutableArray alloc]init];
                for (int i = 0 ; i < array.count; i ++) {
                    NSDictionary *temp = array[i];
                    if([[temp objectForKey:@"day_noise"] doubleValue]>0.00){
                        NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"day_noise"] doubleValue]];
                        
                        [chartData2 addObject:n];
                    }
                }
                [chartData2 addObject:[NSNumber numberWithInt:70]];
                [chartData2 addObject:[NSNumber numberWithInt:70]];
                
                // Creating the line chart
                
                lineChart.verticalGridStep = 3;
                lineChart.horizontalGridStep = 15;
                //lineChart.fillColor = nil;
                
                lineChart.labelForIndex = ^(NSUInteger item) {
                    return [NSString stringWithFormat:@"%lu",(unsigned long)item];
                };
                
                lineChart.labelForValue = ^(CGFloat value) {
                    return [NSString stringWithFormat:@"%.f", value];
                };
                
                [lineChart setChartData:chartData2];

            }
            
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
    return lineChart;
}

-(FSLineChart*)chartNight
{
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(25, 360, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    srand(time(nil));
    
    NSString *ask = @"day10/";
    if(self.portalID){
        ask=[ask stringByAppendingString:self.portalID];
        //ask=[ask stringByAppendingString:@"897"];
        
        NSLog(@"%@",ask);
        [[myNetworking sharedClient] GET:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            NSArray *array = result;
            NSLog(@"%@", result);
            if([array count]!=0){
                chartData3= [[NSMutableArray alloc]init];
                for (int i = 0 ; i < array.count; i ++) {
                    NSDictionary *temp = array[i];
                    if([[temp objectForKey:@"night_noise"] doubleValue]>0.00){
                        NSNumber *n=[[NSNumber alloc]initWithFloat:[[temp objectForKey:@"night_noise"] doubleValue]];
                        
                        [chartData3 addObject:n];
                    }
                }
                [chartData3 addObject:[NSNumber numberWithInt:70]];
                [chartData3 addObject:[NSNumber numberWithInt:70]];
                
                // Creating the line chart
                
                lineChart.verticalGridStep = 3;
                lineChart.horizontalGridStep = 15;
                //lineChart.fillColor = nil;
                
                lineChart.labelForIndex = ^(NSUInteger item) {
                    return [NSString stringWithFormat:@"%lu",(unsigned long)item];
                };
                
                lineChart.labelForValue = ^(CGFloat value) {
                    return [NSString stringWithFormat:@"%.f", value];
                };
                
                [lineChart setChartData:chartData3];
            }
            
            
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
    return lineChart;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
