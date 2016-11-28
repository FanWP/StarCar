//
//  CollectionModel.m
//  TianlangStar
//
//  Created by Beibei on 16/11/4.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CollectionModel.h"

@implementation CollectionModel



+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID": @"id"
             };
}



- (NSString *)createtime
{
    NSString *timeStampString = _createtime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    
    return [objDateformat stringFromDate: date];
}



-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}




@end













