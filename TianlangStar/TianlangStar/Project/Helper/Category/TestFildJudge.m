//
//  TestFildJudge.m
//  房地产-新旅行
//
//  Created by Beibei on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TestFildJudge.h"

@implementation TestFildJudge

/** *判断文本框是否为数字，字母下划线 */
-(BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore:(NSString *)string{
    NSUInteger len=string.length;
    for(int i=0;i<len;i++)
    { unichar a=[string characterAtIndex:i];
        if(!((isalpha(a)) || (isalnum(a))||((a=='_')) || ((a >= 0x4e00 && a <= 0x9fa6))              ))
            return NO;
    }
    return YES;
}


// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}

@end
