//
//  AttachedCell.m
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//

#import "AttachedCell.h"
#import "UIButton+Create.h"

@implementation AttachedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //分割线
        _imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(60, 39, 320-60, 1)];
        [self.contentView addSubview:_imageLine];
        
        UIButton *b1 = [UIButton createButtonWithFrame:CGRectMake(60, 9, 80, 20) Title:@"查看地点" Target:self Selector:@selector(btnAction:)];
        
        b1.tag = 1001;
        
        UIButton *b2 = [UIButton createButtonWithFrame:CGRectMake(150, 9, 80, 20) Title:@"短息联系" Target:self Selector:@selector(btnAction:)];
        b2.tag = 2001;
        
        UIButton *b3 = [UIButton createButtonWithFrame:CGRectMake(240, 9, 80, 20) Title:@"电话联系" Target:self Selector:@selector(btnAction:)];
        b3.tag = 3001;
        
        [self.contentView addSubview:b1];
        [self.contentView addSubview:b2];
        [self.contentView addSubview:b3];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)btnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1001:
        {
            [self push];
            break;
        }
           
        case 2001:
        {
            NSLog(@"%@>>>>>>>>>>短息联系", self.index);
            [self makemessage];
            break;
        }
            
        case 3001:
        {
            NSLog(@"%@>>>>>>>>>>电话联系", self.index);
            [self makephone];
            break;
        }

        default:
            break;
    }
}

#pragma mark -enterintodetail
-(void) push
{
    /*SceneViewController *sceneViewController = [[SceneViewController alloc] init];
    sceneViewController.portalID = self.portalID;
    sceneViewController.portalname = self.portalName;
    //在父视图中才能修改back
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
    backbutton.title = @"特别关注";
    
    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController pushViewController:sceneViewController animated:YES];*/
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"attentionToDetail"
                                                        object:nil
                                                      userInfo:@{@"id":self.index
                                                                 }];
}

-(void) makephone
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"attentionphone"
                                                        object:nil
                                                      userInfo:@{@"id":self.index
                                                                 }];
}

-(void) makemessage
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"attentionmessage"
                                                        object:nil
                                                      userInfo:@{@"id":self.index
                                                                 }];
}
@end

