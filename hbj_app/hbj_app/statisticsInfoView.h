//
//  statisticsInfoView.h
//  hbj_app
//
//  Created by eidision on 14/12/7.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface statisticsInfoView : UIView

@property (nonatomic, strong)UIButton *leftButton;
@property (nonatomic, strong)UIButton *rightButton;
//@property (nonatomic, strong)UIView   *upperView;
//@property (nonatomic, strong)UIView   *lowerView;
@property (nonatomic, strong)UILabel  *day;
@property (nonatomic, strong)UILabel  *night;
@property (nonatomic, strong)UILabel  *label;
@property long chosen;

@end
