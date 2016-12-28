//
//  RegistVC.h
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistVC : UIViewController

/** 注册页面背景图 */
@property (nonatomic,strong) UIImageView *pictureView;
/** 手机号 */
@property (nonatomic,strong) UILabel *telphoneLabel;
/** 输入手机号 */
@property (nonatomic,strong) UITextField *telphoneTF;
/** 密码 */
@property (nonatomic,strong) UILabel *pwdLabel;
/** 输入密码 */
@property (nonatomic,strong) UITextField *pwdTF;
/** 确认密码 */
@property (nonatomic,strong) UILabel *okPwdLabel;
/** 输入确认密码 */
@property (nonatomic,strong) UITextField *okPwdTF;
/** 验证码 */
@property (nonatomic,strong) UILabel *captchaLabel;
/** 输入验证码 */
@property (nonatomic,strong) UITextField *captchaTF;
/** 获取验证码 */
@property (nonatomic,strong) UIButton *captchaButton;
/** 推荐人 */
@property (nonatomic,strong) UILabel *referrerLabel;
/** 输入推荐人手机号 */
@property (nonatomic,strong) UITextField *referrerTF;
/** 确定注册按钮 */
@property (nonatomic,strong) UIButton *okButton;


@end













