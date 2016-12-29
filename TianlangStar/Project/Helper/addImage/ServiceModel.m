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


- (NSString *)warranty
{
    NSString *shelvestimeString = _warranty;
    NSTimeInterval _interval = [shelvestimeString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objectDateformat = [[NSDateFormatter alloc] init];
    [objectDateformat setDateFormat:@"yyyy-MM-dd"];
    
    return [objectDateformat stringFromDate:date];
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
