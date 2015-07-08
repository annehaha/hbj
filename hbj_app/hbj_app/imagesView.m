//
//  imagesView.m
//  hbj_app
//
//  Created by eidision on 14/11/29.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "imagesView.h"
#import "imageScrollView.h"

@implementation imagesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[[UIScreen mainScreen] applicationFrame]];

    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 54, 100, 30)];
        self.titleLable.text = @"拍摄时间:";
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.titleLable.textColor = [UIColor colorWithRed:60/255.0 green:180/255.0 blue:80/255.0 alpha:1];
        self.titleLable.font = [UIFont boldSystemFontOfSize:15];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 54, 190, 30)];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.textColor = [UIColor colorWithRed:60/255.0 green:180/255.0 blue:80/255.0 alpha:1];
        self.timeLabel.font = [UIFont boldSystemFontOfSize:15];
        
        self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 94, 300, 400)];
        self.waitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 94, 300, 400)];
        self.waitImageView.image = [UIImage imageNamed:@"image_wait"];
        
        self.scrollview.pagingEnabled = YES;
        self.scrollview.backgroundColor = [UIColor clearColor];
        
        self.scrollview.delegate = self;
        self.scrollview.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollview];
        [self addSubview:self.titleLable];
        [self addSubview:self.timeLabel];
        [self addSubview:self.waitImageView];
    }
    return self;
}

-(void)resizeScrollView
{
    self.scrollview.contentSize = CGSizeMake(300 * self.count, 0);
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 510, 320, 20)];
    pageControl.numberOfPages = self.count;
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:27/255.0 green:175/255.0 blue:42/255.0 alpha:1];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:180/255.0 green:241/255.0 blue:174/255.0 alpha:1];
    pageControl.tag = 3211;
    [self addSubview:pageControl];
}

-(void)assignforView: (NSMutableArray *)imageArray
{
    self.timeArray = [[NSMutableArray array] init];
    
    float _x = 0;
    for (int index = 1; index <= self.count; index ++) {
        imageScrollView *imagescollView = [[imageScrollView alloc] initWithFrame:CGRectMake(0 + _x, 0, 300, 400)];
        //temp
        //imagescollView.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageArray[index - 1][1]]]];
        [imagescollView.imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[index - 1][1]] placeholderImage:[UIImage imageNamed:@"image_wait"]];
        [self.timeArray addObject:imageArray[index - 1][0]];
        NSLog(@"%d, finish", index);
        imagescollView.tag = index + 9;
        [self.scrollview addSubview:imagescollView];
        _x += 300;
    }
    
    [self.waitImageView removeFromSuperview];
    self.timeLabel.text = self.timeArray[0];
}

#pragma -mark delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}

int pre = 10;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int current = (int)scrollView.contentOffset.x / 300 + 10;
    imageScrollView *preView = (imageScrollView *)[scrollView viewWithTag:pre];

    if (pre != current && preView.zoomScale != 1) {
        preView.zoomScale = 1;
    }
    pre = current;
    
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        
    }else{
        UIPageControl *pagecontrol = (UIPageControl *)[self viewWithTag:3211];
        pagecontrol.currentPage = current - 10;
        self.timeLabel.text = self.timeArray[current - 10];
    }
}


@end
