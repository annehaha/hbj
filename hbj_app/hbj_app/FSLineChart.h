//
//  FSLineChart.h
//  FSLineChart
//
//  Created by Zhaoxiaoyun on 16/11/2014.
//  Copyright (c) 2014 Arthur GUIBERT. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface FSLineChart : UIView

// Block definition for getting a label for a set index (use case: date, units,...)
typedef NSString *(^FSLabelForIndexGetter)(NSUInteger index);

// Same as above, but for the value (for adding a currency, or a unit symbol for example)
typedef NSString *(^FSLabelForValueGetter)(CGFloat value);

typedef NS_ENUM(NSInteger, ValueLabelPositionType) {
    ValueLabelLeft,
    ValueLabelRight
};

// Index label properties
@property (copy) FSLabelForIndexGetter labelForIndex;
@property (nonatomic, strong) UIFont* indexLabelFont;
@property (nonatomic) UIColor* indexLabelTextColor;
@property (nonatomic) UIColor* indexLabelBackgroundColor;

// Value label properties
@property (copy) FSLabelForValueGetter labelForValue;
@property (nonatomic, strong) UIFont* valueLabelFont;
@property (nonatomic) UIColor* valueLabelTextColor;
@property (nonatomic) UIColor* valueLabelBackgroundColor;
@property (nonatomic) ValueLabelPositionType valueLabelPosition;

// Number of visible step in the chart
@property (nonatomic, readwrite) int gridStep;
@property (nonatomic, readwrite) int verticalGridStep;
@property (nonatomic, readwrite) int horizontalGridStep;

// Margin of the chart
@property (nonatomic, readwrite) CGFloat margin;

@property (nonatomic, readonly) CGFloat axisWidth;
@property (nonatomic, readonly) CGFloat axisHeight;

// Decoration parameters, let you pick the color of the line as well as the color of the axis
@property (nonatomic, readwrite) UIColor* axisColor;
@property (nonatomic, readwrite) CGFloat axisLineWidth;

// Chart parameters
@property (nonatomic, readwrite) UIColor* color;
@property (nonatomic, readwrite) UIColor* fillColor;
@property (nonatomic, readwrite) CGFloat lineWidth;

// Grid parameters
@property (nonatomic, readwrite) BOOL drawInnerGrid;
@property (nonatomic, readwrite) UIColor* innerGridColor;
@property (nonatomic, readwrite) CGFloat innerGridLineWidth;

// Smoothing
@property (nonatomic, readwrite) BOOL bezierSmoothing;
@property (nonatomic, readwrite) CGFloat bezierSmoothingTension;

// Animations
@property (nonatomic, readwrite) CGFloat animationDuration;

// Set the actual data for the chart, and then render it to the view.
- (void)setChartData:(NSArray *)chartData;

@end
