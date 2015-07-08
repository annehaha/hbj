//
//  sideTableViewController.m
//  hbj_app
//
//  Created by eidision on 14/11/29.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "sideTableViewController.h"

@interface sideTableViewController ()
{
    UIButton *accessoryButton;
}

@end

@implementation sideTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, 170, 503);
    self.tableView.frame = CGRectMake(0, 5, 170, 503);
    self.tableView.separatorStyle = NO;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:255/255.0 blue:230/255.0 alpha:0.4f];;//[UIColor colorWithWhite:0.9f alpha:0.8f];
    
    _listArray = @[@"监测点信息", @"统计信息", @"监测点照片", @"监测点视频", @"主要负责人"];
    _imageArray = @[@"side_message", @"side_count", @"side_pic", @"side_video", @"side_visor"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(12, 12, 12, 12)];
    [accessoryButton setBackgroundImage:[UIImage imageNamed:@"accessory"] forState:UIControlStateNormal];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 5) {
        cell.separatorInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
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
    // Return the number of rows in the section.
    return [_listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"sideviewcell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.textLabel.text = _listArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithRed:25/255.0 green:135/255.0 blue:45/255.0 alpha:1];
    [cell.textLabel setFont:[UIFont fontWithName:@"GeezaPro" size:15]];
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    if (indexPath.row == self.selectionNum) {
        cell.accessoryView = accessoryButton;
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.selectionNum) {
        return;
    }
    else
    {
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.selectionNum inSection:0];
        UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:lastIndexPath];
        lastCell.accessoryView = nil;
        self.selectionNum = indexPath.row;
        UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
        thisCell.accessoryView = accessoryButton;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseDone" object:nil];
}




@end
