//
//  userModel.m
//  房地产-新旅行
//
//  Created by xinlvxing on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//
#import "UserModel.h"
#import <MJExtension.h>

@implementation UserModel




+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID": @"id",
             @"describe": @"description"
             };
    
}

//-(NSString *)headimage
//{
//    return [NSString stringWithFormat:@"%@%@",picURL,_headimage];
//}


-(NSString *)lasttime
{
    NSString * timeStampString = _lasttime;
    NSTimeInterval _interval=[timeStampString doubleValue];
//        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [objDateformat stringFromDate: date];
}


-(NSString *)createtime
{
    NSString * timeStampString = _createtime;
    NSTimeInterval _interval=[timeStampString doubleValue];
    //        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [objDateformat stringFromDate: date];
}



















- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
@end
