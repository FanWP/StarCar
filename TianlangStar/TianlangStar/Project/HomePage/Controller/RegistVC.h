//
//  RegistVC.h
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistVC : UIViewController


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
/** 确认注册按钮 */
@property (nonatomic,strong) UIButton *okButton;
/** 复选框 */
@property (nonatomic,strong) UIButton *selectButton;
/** 注册协议 */
@property (nonatomic,strong) UIButton *protocolButton;


@end








