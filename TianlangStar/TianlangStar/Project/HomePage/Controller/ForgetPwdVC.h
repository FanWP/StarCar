//
//  ForgetPwdVC.h
//  TianlangStar
//
//  Created by Beibei on 16/10/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPwdVC : UIViewController

/** 输入手机号 */
@property (nonatomic,strong) UITextField *telphoneTF;
/** 输入验证码 */
@property (nonatomic,strong) UITextField *captchaTF;
/** 获取验证码 */
@property (nonatomic,strong) UIButton *captchaButton;
/** 输入密码 */
@property (nonatomic,strong) UITextField *pwdTF;
/** 输入确认过的密码 */
@property (nonatomic,strong) UITextField *okPwdTF;
/** 提交按钮 */
@property (nonatomic,strong) UIButton *handButton;


@end
