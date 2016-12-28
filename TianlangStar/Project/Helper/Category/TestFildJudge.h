//
//  TestFildJudge.h
//  房地产-新旅行
//
//  Created by Beibei on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestFildJudge : NSObject

/**
 *判断文本框是否为数字，字母下划线
 */
-(BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore:(NSString *)string;


/** 正则判断手机号码地址格式 */
- (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
