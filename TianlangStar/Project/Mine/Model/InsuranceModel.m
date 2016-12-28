//
//  InsuranceModel.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/16.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "InsuranceModel.h"

@implementation InsuranceModel


+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID": @"id",
             @"describe": @"description"
             };
    
}

@end
