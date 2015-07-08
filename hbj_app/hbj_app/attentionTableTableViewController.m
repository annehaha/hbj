//
//  attentionTableTableViewController.m
//  hbj_app
//
//  Created by eidision on 14/12/21.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "attentionTableTableViewController.h"
#import "myNetworking.h"

@interface attentionTableTableViewController ()
{
    NSMutableDictionary *building_type;
    NSString *userid;
}

@end

@implementation attentionTableTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    //navigationItem左按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    
    UIButton *left_arrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 10, 18)];
    [left_arrow setBackgroundImage:[UIImage imageNamed:@"menu_left"] forState:UIControlStateNormal];
    [left_arrow addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    [backButton addSubview:left_arrow];
    
    [backButton setTitle:@"特别关注" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    backButton.titleLabel.textColor = [UIColor whiteColor];
    backButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [backButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"buildings" ofType:@"plist"];
    building_type = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    attentionDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"attentionDic"];
    idToDetail = [[NSUserDefaults standardUserDefaults] objectForKey:@"idToNameAndAddr"];
    idArray = [attentionDic allKeys];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [attentionDic.allKeys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SWITCH";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchview addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchview;
        cell.textLabel.numberOfLines = 0;
        switchview.tag = indexPath.row + 3000;
    }
    
    NSString *id = idArray[indexPath.row];

    cell.textLabel.text = idToDetail[id][0];
    
    NSString *type = idToDetail[id][2];
    
    //根据type确定picture
    cell.imageView.image = [UIImage imageNamed:building_type[type]];
    UISwitch *temp = (UISwitch *)cell.accessoryView;
    NSString *value = (NSString *)attentionDic[id];
    if ([value isEqualToString:@"no"]) {
        temp.on = NO;
    }else{
        temp.on = YES;
    }
    
    return cell;
}

-(void) updateSwitchAtIndexPath:(id)sender
{
    UISwitch *myswitch = (UISwitch *)sender;
    NSString *portalid = idArray[myswitch.tag - 3000];
    if (myswitch.on) {
        NSLog(@"before:%@", attentionDic[portalid]);
        
        attentionDic[portalid] = @"yes";
        
        NSString *create = @"userfocus/create/";
        
        NSString *ask = [create stringByAppendingString:[NSString stringWithFormat:@"%@/%@", userid, portalid]];

        [[myNetworking sharedClient] POST:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
        
        NSLog(@"after:%@", attentionDic[portalid]);
    }
    else{
        NSLog(@"before:%@", attentionDic[portalid]);
        attentionDic[portalid] = @"no";
        
        NSString *create = @"userfocus/delete/";
        
        NSString *ask = [create stringByAppendingString:[NSString stringWithFormat:@"%@/%@", userid, portalid]];
        
        [[myNetworking sharedClient] POST:ask parameters:nil success: ^(AFHTTPRequestOperation *operation, id result) {
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
        
        NSLog(@"after:%@", attentionDic[portalid]);
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self postChange];
}

-(void)postChange
{
    [[NSUserDefaults standardUserDefaults] setObject:attentionDic forKey:@"attentionDic"];
    
}

-(void)cancelPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
