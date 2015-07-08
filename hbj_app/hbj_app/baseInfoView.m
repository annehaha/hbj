//
//  baseInfoView.m
//  hbj_app
//
//  Created by eidision on 14/11/29.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "baseInfoView.h"
#import "baseinfoTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "myNetworking.h"

@implementation baseInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.baseInfo = [[NSArray alloc] init];
        self.observationItem = [[NSArray alloc] init];
        [self loadbaseInfo];
        [self loadobservationItem];

        self.baseInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)
                                                              style:UITableViewStylePlain];
        [self addSubview:self.baseInfoTableView];
        
        UIView *tempview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 40)];
        self.tempLabel.text = self.name;

        self.tempLabel.textColor = [UIColor blueColor];
        self.tempLabel.textAlignment = NSTextAlignmentCenter;
        [self.tempLabel setFont:[UIFont fontWithName:@"GeezaPro" size:18]];
        [tempview addSubview:self.tempLabel];
        
        self.baseInfoTableView.tableHeaderView = tempview;
        
        self.baseInfoTableView.delegate = self;
        self.baseInfoTableView.dataSource = self;
    }
    return self;
}

-(void) loadname
{
    self.tempLabel.text = self.name;
    self.tempLabel.textColor = [UIColor colorWithRed:56/255.0 green:180/255.0 blue:73/255.0 alpha:0.7];
}

- (void) loadbaseInfo
{
    self.baseInfo = @[@"地址",
                      @"纬度",
                      @"经度",
                      @"单位",
                      @"监测类型",
                      @"起始日期（工地）",
                      @"终止日期（工地）",
                      @"联系人",
                      @"联系电话"
                      ];
    _length = (int)[self.baseInfo count];
}

- (void) loadobservationItem
{
    self.observationItem = @[@"时间",
                             @"SPM(mg/m3)",
                             @"噪声dB(A)",
                             @"风向",
                             @"风速(m/s)",
                             @"温度(℃)",
                             @"湿度(%)",
                             @"气压(mbar)"
                             ];
}

- (void) loadvalue
{
    //self.value = [[NSArray alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.baseInfo count];
    }else{
        return [self.observationItem count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"信息概况";
    }else{
        return @"基本指标";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] init];
    customView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:0.7];
    
    UIImageView *tempview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 12, 12)];
    tempview.image = [UIImage imageNamed:@"arrow_down"];
    
    // create the button object
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, 90, 12)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor colorWithRed:56/255.0 green:180/255.0 blue:73/255.0 alpha:0.7];
    
    if (section == 0) {
        headerLabel.text = @"信息概况";
    }else{
        headerLabel.text = @"基本指标";
    }
    
    headerLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [customView addSubview:tempview];
    [customView addSubview:headerLabel];
    
    return customView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    baseinfoTableViewCell *cell = [[baseinfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    
    if (indexPath.section == 0) {
        cell.title = self.baseInfo[indexPath.row];
        cell.value = self.value[indexPath.row];
    }else{
        cell.title = self.observationItem[indexPath.row];
        cell.value = self.value[indexPath.row + _length];
    }
    
    [cell initSubViews];
    cell.userInteractionEnabled = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *value;

    if (indexPath.section == 0) {
        value = self.value[indexPath.row];
    }else{
        value = self.value[indexPath.row + _length];
    }
    
    CGSize size = CGSizeMake(170, 0);
    if (value == nil) {
        value = @"";
    }
    CGSize labelsize = [value boundingRectWithSize:size
                                           options:NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading
                                        attributes:@{
                                                     NSFontAttributeName:[UIFont fontWithName:nil size:18]
                                                     }
                                           context:nil
                        ].size;
    
    return labelsize.height + 12;
}
@end
