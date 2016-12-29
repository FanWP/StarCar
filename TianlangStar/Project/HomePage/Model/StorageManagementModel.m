//
//  StorageManagementModel.m
//  TianlangStar
//
//  Created by Beibei on 16/11/27.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "StorageManagementModel.h"

@implementation StorageManagementModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID": @"id",
             };
}

- (NSString *)shelvestime
{
    NSString *shelvestimeString = _shelvestime;
    NSTimeInterval _interval = [shelvestimeString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objectDateformat = [[NSDateFormatter alloc] init];
    [objectDateformat setDateFormat:@"yyyy-MM-dd"];
    
    return [objectDateformat stringFromDate:date];
}


@end
