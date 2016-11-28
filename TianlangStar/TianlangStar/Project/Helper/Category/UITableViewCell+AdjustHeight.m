//
//  UITableViewCell+AdjustHeight.m
//  悠游四季_房地产
//
//  Created by Beibei on 16/8/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UITableViewCell+AdjustHeight.h"

@implementation UITableViewCell (AdjustHeight)

+ (CGFloat)heightForString:(NSString *)string WithFontSize:(NSInteger)fontSize
{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGRect bounds= [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-21, 3000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    
    return bounds.size.height;
}

@end
