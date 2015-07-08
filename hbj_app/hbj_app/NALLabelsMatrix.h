//
//  NALLabelsMatrix.h
//
//  Created by Zhaoxiaoyun on 16/11/2014.
//  Copyright (c) 2014 neeks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NALLabelsMatrix : UIView {
    NSArray *columnsWidths;
    uint numRows;
    uint dy;
}

- (id)initWithFrame:(CGRect)frame andColumnsWidths:(NSArray*)columns;
- (void)addRecord:(NSArray*)record;
@end