//
//  NSString+extension.m
//  地产
//
//  Created by xinlvxing on 16/6/27.
//  Copyright © 2016年 xinlvxing. All rights reserved.
//

#import "NSString+extension.h"

@implementation NSString (extension)



/** *判断文本框是否为数字，字母下划线 */
-(BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore{
    NSUInteger len=self.length;
    for(int i=0;i<len;i++)
    { unichar a=[self characterAtIndex:i];
        if(!((isalpha(a)) || (isalnum(a))||((a=='_')) || ((a >= 0x4e00 && a <= 0x9fa6))              ))
            return NO;
    }
    return YES;
}


// 正则判断手机号码地址格式
- (BOOL)isMobileNumber {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:self];
}

/**
 *  判断身份证号
 */
-(BOOL)isIdentityCardNo
{

    BOOL flag;
    if (self.length <= 0)
    {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:self];
    
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(self.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }
}



/** 判断密码是否是合法 */
-(BOOL)isLegalInput
{
    BOOL result = false;
    if ([self length] >= 6)
    {
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^.*[A-Z]+.*[a-z]+.*$|^.*[a-z]+.*[A-Z]+.*$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:self];
    }
    return result;
}


- (BOOL)isPureInt{
    
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

/**
 *将时间戳转时间
 */
-(NSString *)getTime
{
    NSString * timeStampString = self;
//    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd"];
    return [objDateformat stringFromDate: date];
    
}


-(NSString *)getCurrentTime
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
//        [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    return dateString;
}

/**
 *  判断字符串是否为浮点数
 */
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


/**
 *  判断字符串是否为URL
 */
- (BOOL)isURL
{
    //URL
    BOOL result = false;
//    NSString *regex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSString *regex = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    result = [pred evaluateWithObject:self];
    return result;
}

/**
 * 通过VIP等级直接返回等级
 */
+ (NSString *)VIPis:(NSInteger )VIP
{
    NSString *leval = @"LV.1";
    switch (VIP) {
        case 1:
            leval = @"LV.1";
            break;
        case 2:
            leval = @"LV.2";
            break;
        case 3:
            leval = @"LV.3";
            break;
        case 4:
            leval = @"LV.4";
            break;
        case 5:
            leval = @"LV.5";
            break;
        case 6:
            leval = @"LV.6";
            break;
        case 7:
            leval = @"LV.7";
            break;
        case 8:
            leval = @"LV.8";
            break;
        case 9:
            leval = @"LV.9";
            break;
            
        default:
            break;
    }
    
    return leval;

}






@end
