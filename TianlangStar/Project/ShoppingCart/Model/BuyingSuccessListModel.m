//
//  BuyingSuccessListModel.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/6.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BuyingSuccessListModel.h"
#import "BuyingSuccessDetailmodel.h"

@implementation BuyingSuccessListModel


+(NSDictionary *)mj_objectClassInArray
{
    
    return @{
             @"orderList":[BuyingSuccessDetailmodel class]
             };
}

@end
