//
//  ILSettingArrowItem.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ILSettingArrowItem.h"

@implementation ILSettingArrowItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    ILSettingArrowItem *item = [super itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    
    return item;
}


@end
