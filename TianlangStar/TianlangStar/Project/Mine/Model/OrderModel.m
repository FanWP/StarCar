//
//  OrderModel.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel



+(NSDictionary *)mj_replacedKeyFromPropertyName
{


    return @{
             
             @"ID" : @"id"
             
             };

}


-(NSString *)lasttime
{

    NSTimeInterval _time = [_lasttime doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    return [formatter stringFromDate:date];
    
//    NSString * timeStampString = self;
//    //    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
//    NSTimeInterval _interval=[timeStampString doubleValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
//    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
//    [objDateformat setDateFormat:@"YYYY-MM-dd"];
//    return [objDateformat stringFromDate: date];


}


@end
