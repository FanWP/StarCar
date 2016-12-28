//
//  ILSettingItem.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ILSettingItem.h"

@implementation ILSettingItem


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    ILSettingItem *item = [[self alloc] init];
    
    item.icon = icon;
    item.title = title;
    
    return item;
}

@end
