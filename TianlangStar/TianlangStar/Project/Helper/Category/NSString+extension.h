//
//  NSString+extension.h
//  地产
//
//  Created by xinlvxing on 16/6/27.
//  Copyright © 2016年 xinlvxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (extension)

/**
 *判断文本框是否为数字，字母下划线
 */
-(BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore;

/** 正则判断手机号码地址格式 */
- (BOOL)isMobileNumber;

/** 判断身份证号 */
-(BOOL)isIdentityCardNo;

/** 判断长度大于6位后再接着判断是否同时包含数字和字符 */
-(BOOL)isLegalInput;

/** 判断是否为纯粹的数字 整形*/
- (BOOL)isPureInt;

/** 判断字符串是否为浮点数 */
- (BOOL)isPureFloat;

/** 将时间戳转时间 */
-(NSString *)getTime;

/** 获取当前时间 */
-(NSString *)getCurrentTime;

/** 判断字符串是否为URL */
- (BOOL)isURL;


/**
 * 通过VIP数字直接返回等级字符串
 */
+ (NSString *)VIPis:(NSInteger )VIP;

@end
