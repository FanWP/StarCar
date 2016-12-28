//
//  ServiceModel.m
//  TianlangStar
//
//  Created by Beibei on 16/11/22.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"ID" : @"id" };
}


-(void)setCount:(NSInteger)count
{
    _count = count;

    //计算价格
    NSInteger price =  [self.price doubleValue];
    
    CGFloat  discount = [UserInfo sharedUserInfo].discount / 100;

    _realPrice = ceil(price * discount * self.count);

}

@end
