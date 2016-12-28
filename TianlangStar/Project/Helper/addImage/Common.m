//
//  ViewController.h
//  album
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "Common.h"

NSString *const ROOT_STORYBOARD_NAME = @"Main";

//(?<=@)((?:[A-Za-z0-9]+(?:[\\-|\\.][A-Za-z0-9]+)*)+\\.[A-Za-z]{2,6})$
NSString *const CommonRegexEmail = @"^\\w+[-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
NSString *const CommonRegexMoney = @"^(?!0+(?:\\.0+)?$)(?:[1-9]\\d*|0)(?:\\.\\d{1,2})?$";


@implementation Common

+ (UIColor*) hexColor:(NSInteger)hexValue {
    
    CGFloat red = (CGFloat)((hexValue & 0xFF0000) >> 16) / 255.0;
    CGFloat green = (CGFloat)((hexValue & 0xFF00) >> 8) /255.0;
    CGFloat blue = (CGFloat)(hexValue & 0xFF) / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    return color;
}

+ (void) hiddenKeyboard {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

+ (void) networkActivityIndicatorVisible:(BOOL)isShow {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:isShow];
}

+(CGRect)screenBounds {
    return [[UIScreen mainScreen] bounds];
}

+(UIImage*) imageWithFrame:(CGRect)frame color:(UIColor*)color {
    if(CGRectEqualToRect(frame, CGRectZero)) {
        frame = CGRectMake(0, 0, 1, 1);
    }
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(__kindof UIViewController*)viewControllerWithStoryboardID:(NSString*)storyboardID {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:ROOT_STORYBOARD_NAME bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:storyboardID];
    return vc;
}

+(UIFont*)systemFontOfSize:(CGFloat)size {
    return [UIFont systemFontOfSize:size];
}

+(NSString*)infoWithKey:(NSString*)key {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary[key];
}

+(NSInteger)appVersion {
    NSString *info = [self infoWithKey:@"CFBundleShortVersionString"];
    
    return [self formatVersion:info];
}

+(NSInteger)buildVersion {
    NSString *info = [self infoWithKey:@"CFBundleVersion"];
    
    return [self formatVersion:info];
}

+(NSInteger)formatVersion:(NSString*)version {
    NSArray *array = [version componentsSeparatedByString:@"."];
    if(!array || array.count == 0) {
        return 0;
    }
    NSMutableString *versionString = [NSMutableString string];
    for (NSString *item in array) {
        NSInteger length = item.length;
        if(length == 1) {
            [versionString appendFormat:@"00%@",item];
        } else if(length == 2) {
            [versionString appendFormat:@"0%@",item];
        } else {
            [versionString appendString:item];
        }
    }
    
    return [versionString integerValue];
}

+(NSString*)appName {
    NSString *info = [self infoWithKey:@"CFBundleDisplayName"];
    return info;
}

+(NSString*)identifierForVendor {
    NSString *id = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return id;
}

+(NSString*)UUID {
    return [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+(NSString*)getDateDefaultStyleWithDate:(NSDate*)date {
    NSArray<NSString*> *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    NSString *dateString = [NSString stringWithFormat:@"%ld年%ld月%ld日",(long)[components year],(long)[components month],(long)[components day]];
    
    NSInteger week = [components weekday];
    NSString *weekString = weekArray[week - 1];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    return [NSString stringWithFormat:@"%@  %@ %ld:%ld",dateString,weekString,hour,minute];
}

+(BOOL)evaluateWithString:(NSString*)value regex:(NSString*)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:value];
}

@end
