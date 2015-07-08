//
//  imageScrollView.m
//  testScollViewDemo
//
//  Created by eidision on 14/11/19.
//  Copyright (c) 2014年 eidision. All rights reserved.
//

#import "imageScrollView.h"

@implementation imageScrollView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.maximumZoomScale = 2.5;
        self.minimumZoomScale = 1;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
        
        UITapGestureRecognizer*doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomInAndOut:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
    }
    
    return self;
}

-(void)zoomInAndOut:(UITapGestureRecognizer *)tapGesture
{
    if (self.zoomScale > 1) {
        [self setZoomScale:1 animated:YES];
    }else{
        CGPoint point = [tapGesture locationInView:self];
        [self zoomToRect:CGRectMake(point.x - 40, point.y - 40, 80, 80) animated:YES];
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
