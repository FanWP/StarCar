//
//  UILabel+LabelHeightAndWidth.h
//  悠游四季_房地产
//
//  Created by Beibei on 16/8/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelHeightAndWidth)

+ (CGFloat)getHeightByWidth:(CGFloat)width font:(UIFont*)font;

+ (CGFloat)getWidthWithFont:(UIFont *)font;

@end
