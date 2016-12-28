//
//  UILabel+LabelHeightAndWidth.m
//  悠游四季_房地产
//
//  Created by Beibei on 16/8/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UILabel+LabelHeightAndWidth.h"

@implementation UILabel (LabelHeightAndWidth)

+ (CGFloat)getHeightByWidth:(CGFloat)width font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGFloat)getWidthWithFont:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

@end
