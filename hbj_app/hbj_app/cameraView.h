//
//  cameraView.h
//  hbj_app
//
//  Created by eidision on 14/12/7.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cameraView : UIView

@property (nonatomic, strong) UIImageView *cameraView;
@property (nonatomic, strong) UIButton *lu;
@property (nonatomic, strong) UIButton *l;
@property (nonatomic, strong) UIButton *ld;
@property (nonatomic, strong) UIButton *ru;
@property (nonatomic, strong) UIButton *r;
@property (nonatomic, strong) UIButton *rd;
@property (nonatomic, strong) UIButton *cu;
@property (nonatomic, strong) UIButton *cd;
@property (nonatomic, strong) UIButton *c;

@property (nonatomic, strong) UIButton *firstUp;
@property (nonatomic, strong) UIButton *firstDown;
@property (nonatomic, strong) UIButton *secondUp;
@property (nonatomic, strong) UIButton *secondDown;

@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;

@end
