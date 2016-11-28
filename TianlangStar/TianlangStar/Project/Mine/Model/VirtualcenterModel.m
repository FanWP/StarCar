//
//  VirtualcenterModel.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/8.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "VirtualcenterModel.h"

@implementation VirtualcenterModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{

    return @{
             @"ID" : @"id"
             };

}

-(NSString *)lastTime
{
    NSString * timeStampString = _lastTime;
    NSTimeInterval _interval=[timeStampString doubleValue];
    //        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [objDateformat stringFromDate: date];
}

@end
