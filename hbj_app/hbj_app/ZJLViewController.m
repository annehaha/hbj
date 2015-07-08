//
//  ZJLViewController.m
//  zhanKaiTableView
//
//  Created by 张欣琳 on 14-2-11.
//  Copyright (c) 2014年 张欣琳. All rights reserved.
//

#import "ZJLViewController.h"
#import "MainCell.h"
#import "AttachedCell.h"
#import "SceneViewController.h"
#import "attentionTableTableViewController.h"

@interface ZJLViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableDictionary *dic;//存对应的数据
    NSMutableArray *selectedArr;//二级列表是否展开状态
    NSMutableArray *titleDataArray;
    NSArray *dataArray;//数据源，显示每个cell的数据
    NSMutableDictionary *stateDic;//三级列表是否展开状态
    NSMutableArray *grouparr0;
    NSMutableArray *grouparr1;
    NSMutableArray *grouparr2;
    NSMutableDictionary *building_type;
}

@end

@implementation ZJLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"特别关注";
    self.navigationItem.titleView = titleLabel;

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
    
    UIButton *managerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
    
    UIButton *right_arrow = [[UIButton alloc] initWithFrame:CGRectMake(45, 6, 10, 18)];
    [right_arrow setBackgroundImage:[UIImage imageNamed:@"menu_right"] forState:UIControlStateNormal];
    [right_arrow addTarget:self action:@selector(manager) forControlEvents:UIControlEventTouchUpInside];
    [managerButton addSubview:right_arrow];
    
    [managerButton setTitle:@"管理" forState:UIControlStateNormal];
    managerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    managerButton.titleLabel.textColor = [UIColor whiteColor];
    managerButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [managerButton addTarget:self action:@selector(manager) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:managerButton];

    dic = [[NSMutableDictionary alloc] init];
    //selectedArr = [[NSMutableArray alloc] init];
    selectedArr = [[NSMutableArray alloc] initWithObjects:@"0", nil];
    dataArray = [[NSArray alloc] init];
    
    [self readFromPlist];
    
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,[UIScreen mainScreen].bounds.size.height + 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    //不要分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(attentionToDetail:)
                                                 name:(@"attentionToDetail")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(attentionphone:)
                                                 name:(@"attentionphone")
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(attentionmessage:)
                                                 name:(@"attentionmessage")
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self initDataSource];
}

-(void)readFromPlist
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"buildings" ofType:@"plist"];
    building_type = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

-(void)initDataSource
{
    idToName = [[NSUserDefaults standardUserDefaults] objectForKey:@"idToNameAndAddr"];

    attentionMsg = [[NSUserDefaults standardUserDefaults] objectForKey:@"attentionMsg"];
    
    tel = [[NSUserDefaults standardUserDefaults] objectForKey:@"tel"];

    titleDataArray = [[NSMutableArray alloc] initWithObjects:@"指标异常地点", @"智能提醒地点", @"指标正常地点",nil];
    
    /*NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"肖利",@"ID",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"段婷婷",@"ID",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"毛凡",@"ID",@"NO",@"state",nil];
    
    grouparr0 = [[NSMutableArray alloc] initWithObjects:nameAndStateDic1,nameAndStateDic2,nameAndStateDic3, nil];
    
    NSMutableDictionary *nameAndStateDic4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"晨晨姐",@"ID",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"李涛",@"ID",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic6 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"海波",@"ID",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic7 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"张敏",@"ID",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic8 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"杨浩",@"ID",@"NO",@"state",nil];
    
    grouparr1 = [[NSMutableArray alloc]initWithObjects:nameAndStateDic4,nameAndStateDic5,nameAndStateDic6,nameAndStateDic7, nameAndStateDic8, nil];
*/
    grouparr0 = [[NSMutableArray alloc] init];
    grouparr1 = [[NSMutableArray alloc] init];
    grouparr2 = [[NSMutableArray alloc] init];
    
    for (NSString *attentionID in attentionMsg.allKeys) {
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",
                    attentionID,@"ID",
                    @"NO",@"state",nil];
        if (![attentionMsg[attentionID][0] isEqualToString:@""]) {
            [grouparr0 addObject:tempDict];
        }else if(![attentionMsg[attentionID][1] isEqualToString:@""]){
            [grouparr1 addObject:tempDict];
        }else{
            [grouparr2 addObject:tempDict];
        }
    }
    
    [dic setValue:grouparr0 forKey:@"0"];
    [dic setValue:grouparr1 forKey:@"1"];
    [dic setValue:grouparr2 forKey:@"2"];
}

#pragma mark----tableViewDelegate
//返回几个表头
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return titleDataArray.count;
}

//每一个表头下返回几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    
    if ([selectedArr containsObject:string]) {
        
        UIImageView *imageV = (UIImageView *)[_tableView viewWithTag:20000+section];
        imageV.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
        
        NSArray *array1 = dic[string];
        return array1.count;
    }
    return 0;
}

//设置表头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//Section Footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 12;
    }else{
        return 0.2;
    }
}

//设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, tableView.frame.size.width-40, 30)];
    titleLabel.text = [titleDataArray objectAtIndex:section];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    titleLabel.textColor = [UIColor grayColor];
    [view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 15, 15)];
    imageView.tag = 20000+section;

    //判断是不是选中状态
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    
    if ([selectedArr containsObject:string]) {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
    }
    else
    {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_right@2x.png"];
    }
    [view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 320, 40);
    //button.backgroundColor = [UIColor redColor];
    button.tag = 100+section;
    [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, 320, 1)];
    lineImage.image = [UIImage imageNamed:@"line.png"];
    [view addSubview:lineImage];
   
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    
    if ([dic[indexStr][indexPath.row][@"cell"] isEqualToString:@"MainCell"])
    {
        return 60;
    }
    else
        return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当前是第几个表头
    NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    
    if ([dic[indexStr][indexPath.row][@"cell"] isEqualToString:@"MainCell"]) {
        
        static NSString *CellIdentifier = @"MainCell";
    
        MainCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        if ([selectedArr containsObject:indexStr]) {
            NSString *nowtype = idToName[dic[indexStr][indexPath.row][@"ID"]][2];//type
            //根据观测点类型标注左侧图标
            cell.Headerphoto.image = [UIImage imageNamed:building_type[nowtype]];

            cell.nameLabel.text = idToName[dic[indexStr][indexPath.row][@"ID"]][0];
            
            cell.IntroductionLabel.text = idToName[dic[indexStr][indexPath.row][@"ID"]][1];
            
            if (indexPath.section == 0) {
                cell.networkLabel.text = attentionMsg[dic[indexStr][indexPath.row][@"ID"]][0];
                cell.networkLabel.textColor = [UIColor redColor];
            }else if (indexPath.section == 1){
                cell.networkLabel.text = attentionMsg[dic[indexStr][indexPath.row][@"ID"]][1];
                cell.networkLabel.textColor = [UIColor colorWithRed:187/255.0 green:165/255.0 blue:59/255.0 alpha:1];
            }else{
                cell.networkLabel.text = @"指标正常";
                cell.networkLabel.textColor = [UIColor colorWithRed:42/255.0 green:200/255.0 blue:51/255.0 alpha:1];
            }
        }
        
        if (indexPath.row == dataArray.count-1) {
            cell.imageLine.image = nil;
        }
        else
            cell.imageLine.image = [UIImage imageNamed:@"line.png"];
        
        return cell;
    }
    else if([dic[indexStr][indexPath.row][@"cell"] isEqualToString:@"AttachedCell"]){
        
        static NSString *CellIdentifier = @"AttachedCell";
        
        AttachedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[AttachedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.imageLine.image = [UIImage imageNamed:@"line.png"];
            cell.index = dic[indexStr][indexPath.row][@"ID"];
        }
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    
    NSIndexPath *path = nil;
    
    if ([dic[indexStr][indexPath.row][@"cell"] isEqualToString:@"MainCell"]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
    }
    else
    {
        path = indexPath;
    }
    
    if ([dic[indexStr][indexPath.row][@"state"] boolValue]) {
        
        // 关闭附加cell
        
        switch (indexPath.section) {
            case 0:
            {
                grouparr0[(path.row-1)][@"state"] = @"NO";
                [grouparr0 removeObjectAtIndex:path.row];
                break;
            }
                
            case 1:
            {
                grouparr1[(path.row-1)][@"state"] = @"NO";
                [grouparr1 removeObjectAtIndex:path.row];
                break;
            }
            
            case 2:
            {
                grouparr2[(path.row-1)][@"state"] = @"NO";
                [grouparr2 removeObjectAtIndex:path.row];
                break;
            }
                
            default:
                break;
        }
        
         [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationMiddle];
        [_tableView endUpdates];
        
    }
    else
    {
        NSString *tempID = dic[indexStr][indexPath.row][@"ID"];
        // 打开附加cell
        switch (indexPath.section) {
            case 0:
            {
                grouparr0[(path.row-1)][@"state"] = @"YES";
                NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AttachedCell",@"cell",tempID,@"ID",@"YES",@"state",nil];
                [grouparr0 insertObject:nameAndStateDic1 atIndex:path.row];
                 break;
            }
               
            case 1:
            {
                grouparr1[(path.row-1)][@"state"] = @"YES";
                NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AttachedCell",@"cell",tempID,@"ID",@"YES",@"state",nil];
                [grouparr1 insertObject:nameAndStateDic1 atIndex:path.row];
                break;
            }
                
            case 2:
            {
                grouparr2[(path.row-1)][@"state"] = @"YES";
                NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AttachedCell",@"cell",tempID,@"ID",@"YES",@"state",nil];
                [grouparr2 insertObject:nameAndStateDic1 atIndex:path.row];
                break;
            }
                
            default:
                break;
        }
        
        [_tableView beginUpdates];
        [_tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        [_tableView endUpdates];
        
    }
}

-(void)doButton:(UIButton *)sender
{
    NSString *string = [NSString stringWithFormat:@"%ld",sender.tag-100];
    
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    if ([selectedArr containsObject:string])
    {
        [selectedArr removeObject:string];
    }
    else
    {
        //NSLog(@"before add:%@", selectedArr);
        [selectedArr addObject:string];
        //NSLog(@"after add:%@", selectedArr);
    }
    
    [_tableView reloadData];
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark- methods_for_attache_cell
-(void) attentionToDetail:(NSNotification *)notify
{
    NSString *id = notify.userInfo[@"id"];
    
    SceneViewController *sceneViewController = [[SceneViewController alloc] init];
    sceneViewController.portalID = id;
    sceneViewController.portalname = idToName[id][0];
    //在父视图中才能修改back
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
    backbutton.title = @"特别关注";
    
    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController pushViewController:sceneViewController animated:YES];
}

-(void) attentionphone:(NSNotification *)notify
{
    NSString *id = notify.userInfo[@"id"];
    NSString *phonenumber = tel[id];
    
    if (!phonenumber || [phonenumber isEqualToString:@""]) {
        return;
    }
    
    UIWebView *callWebview =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    NSURL *telURL =[NSURL URLWithString:[@"tel://" stringByAppendingString:phonenumber]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    callWebview.backgroundColor = [UIColor blackColor];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

-(void) attentionmessage:(NSNotification *)notify
{
    NSString *id = notify.userInfo[@"id"];
    NSString *phonenumber = tel[id];
    
    if (!phonenumber || [phonenumber isEqualToString:@""]) {
        return;
    }
    
    NSString *text;
    if (![attentionMsg[id][0] isEqualToString:@""]) {
        text = attentionMsg[id][0];
    }else if (![attentionMsg[id][1] isEqualToString:@""]){
        text = attentionMsg[id][1];
    }else{
        text = @"";
    }
    
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
    NSLog(@"can send SMS [%d]", canSendSMS);
    if (canSendSMS) {
        
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.navigationBar.tintColor = [UIColor blackColor];
        if ([text isEqualToString:@""]) {
            picker.body = [NSString stringWithFormat:@"%@情况良好，请继续保持。", idToName[id][0]];
        }else{
            picker.body = [NSString stringWithFormat:@"%@,请注意观察。", idToName[id][0]];
        }
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

- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];  
    
}

-(void) manager
{
    attentionTableTableViewController *attentionmanagerView = [[attentionTableTableViewController alloc] init];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"特别关注";
    
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:attentionmanagerView animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
#warning post to server
    //do something to self.toAttentionDic
    
}

-(void)cancelPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
