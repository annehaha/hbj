//
//  MyPieElement.m
//  MagicPie
//
//  Created by anne on 14/12/20.
//  Copyright (c) 2014 zhaoxiaoyun. All rights reserved.
//

#import "MyPieElement.h"

@implementation MyPieElement

- (id)copyWithZone:(NSZone *)zone
{
    MyPieElement *copyElem = [super copyWithZone:zone];
    copyElem.title = self.title;
    
    return copyElem;
}

@end
