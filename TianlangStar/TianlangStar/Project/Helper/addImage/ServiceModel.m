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
    NSInteger price =  [self.price integerValue];
    
    CGFloat  discount = [UserInfo sharedUserInfo].discount / 100;
    
    CGFloat total = (price * discount + 0.5);
    
    NSString *price1 = [NSString stringWithFormat:@"%.f",total];
    
    _realPrice = [price1 integerValue] * self.count;


}

@end
