//
//  CarModel.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/4.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel



+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
    return @{@"carDescription" : @"description"};

}

//-(NSString *)insurancetime
//{
//    NSString * timeStampString = _insurancetime;
//    NSTimeInterval _interval=[timeStampString doubleValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
//    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
//    [objDateformat setDateFormat:@"YYYY-MM-dd"];
//
//    return [objDateformat stringFromDate: date];
//
//}
//
//-(NSString *)commercialtime
//{
//    NSString * timeStampString = _commercialtime;
//    NSTimeInterval _interval=[timeStampString doubleValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
//    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
//    [objDateformat setDateFormat:@"YYYY-MM-dd"];
//  
//    return [objDateformat stringFromDate: date];
//}


-(NSString *)picture
{
    return [NSString stringWithFormat:@"%@%@",picURL,_picture];
}


@end
