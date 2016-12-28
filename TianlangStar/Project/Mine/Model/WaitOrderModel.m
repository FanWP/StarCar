//
//  WaitOrderModel.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "WaitOrderModel.h"
#import "OrderModel.h"

@implementation WaitOrderModel

+(NSDictionary *)mj_objectClassInArray
{

    return @{
             @"valueList":[OrderModel class]
             };
}


@end
