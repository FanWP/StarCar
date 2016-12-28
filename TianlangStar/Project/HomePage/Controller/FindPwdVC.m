//
//  FindPwdVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#define kver3 (0.03 * KScreenHeight)

#import "FindPwdVC.h"

@interface FindPwdVC ()

@end

@implementation FindPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.title = @"忘记密码";// 导航栏按钮

}


//
//// 初始化
//- (instancetype)init
//{
//    self = [super init];
//    
//    if (self)
//    {
//        
//        // 输入手机号
//        CGFloat telX = 0.04 * KScreenWidth;
//        CGFloat telY = 100;
//        CGFloat telWidth = KScreenWidth - 2 * telX;
//        CGFloat telHeight = 0.06 * KScreenHeight;
//        self.telphoneTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, telY, telWidth, telHeight)];
//        [self.view addSubview:self.telphoneTF];
//        
//        
//        
//        // 输入验证码
//        CGFloat captchaTFY = telY + telHeight + kver3;
//        CGFloat captchaWidth = 0.55 * telWidth;
//        self.captchaTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, captchaTFY, captchaWidth, telHeight)];
//        [self.view addSubview:self.captchaTF];
//        
//        // 点击获取验证码
//        CGFloat captchaButtonX = telX + captchaWidth + Klength10;
//        CGFloat captchaButtonWidth = telWidth - captchaWidth - Klength10;
//        self.captchaButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        self.captchaButton.frame = CGRectMake(captchaButtonX, captchaTFY, captchaButtonWidth, telHeight);
//        [self.captchaButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
//        [self.captchaButton addTarget:self action:@selector(captchaAction) forControlEvents:(UIControlEventTouchUpInside)];
//        [self.captchaButton setTintColor:buttonTitleC];
//        [self.view addSubview:self.captchaButton];
//        
//        
//        
//        // 输入密码
//        CGFloat pwdTFY = captchaTFY + telHeight + kver3;
//        self.pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, pwdTFY, telWidth, telHeight)];
//        [self.view addSubview:self.pwdTF];
//        
//        
//        
//        // 确认输入的密码
//        CGFloat okPwdTFY = pwdTFY + telHeight + kver3;
//        self.okPwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, okPwdTFY, telWidth, telHeight)];
//        [self.view addSubview:self.okPwdTF];
//        
//        
//        
//        // 确定提交按钮
//        CGFloat handButtonWidth = telWidth;
//        CGFloat handButtonX = (KScreenWidth / 2) - (handButtonWidth / 2);
//        CGFloat handButtonY = okPwdTFY + telHeight + 0.05 * KScreenHeight;
//        CGFloat handButtonHeight = 0.07 * KScreenHeight;
//        self.handButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        self.handButton.frame = CGRectMake(handButtonX, handButtonY, handButtonWidth, handButtonHeight);
//        [self.handButton setTitle:@"提  交" forState:
//         (UIControlStateNormal)];
//        [self.handButton setTintColor:buttonTitleC];
//        [self.handButton addTarget:self action:@selector(handAction) forControlEvents:(UIControlEventTouchUpInside)];
//        [self.view addSubview:self.handButton];
//        
//        
//        
//        /**
//         *  设置字体大小
//         */
//        self.telphoneTF.font = Font14;
//        self.captchaTF.font = Font14;
//        self.captchaButton.titleLabel.font = Font14;
//        self.pwdTF.font = Font14;
//        self.okPwdTF.font = Font14;
//        [self.handButton.titleLabel setFont:Font18];
//        
//        
//        
//        /**
//         *  设置背景颜色
//         */
//        self.telphoneTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
//        self.captchaTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
//        self.captchaButton.backgroundColor = [UIColor colorWithRed:37.0 / 255.0  green:215.0 / 255.0 blue:252.0 / 255.0 alpha:1.0];
//        self.pwdTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
//        self.okPwdTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
//        self.handButton.backgroundColor = [UIColor colorWithRed:37.0 / 255.0  green:215.0 / 255.0 blue:252.0 / 255.0 alpha:1.0];
//        
//        
//        
//        /**
//         *  设置输入框的编辑模式
//         */
//        self.telphoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        self.captchaTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        self.pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        self.okPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        
//        
//        
//        /**
//         *  设置输入框的样式
//         */
//        self.telphoneTF.borderStyle = UITextBorderStyleNone;
//        self.captchaTF.borderStyle = UITextBorderStyleNone;
//        self.pwdTF.borderStyle = UITextBorderStyleNone;
//        self.okPwdTF.borderStyle = UITextBorderStyleNone;
//        
//        
//        
//        /**
//         *  设置输入框的圆角
//         */
//        self.telphoneTF.layer.cornerRadius = BtncornerRadius;
//        self.telphoneTF.layer.masksToBounds = YES;
//        self.captchaTF.layer.cornerRadius = BtncornerRadius;
//        self.captchaTF.layer.masksToBounds = YES;
//        self.captchaButton.layer.cornerRadius = BtncornerRadius;
//        self.pwdTF.layer.cornerRadius = BtncornerRadius;
//        self.pwdTF.layer.masksToBounds = YES;
//        self.okPwdTF.layer.cornerRadius = BtncornerRadius;
//        self.okPwdTF.layer.masksToBounds = YES;
//        self.handButton.layer.cornerRadius = self.handButton.height / 2;
//        
//        
//        
//        /**
//         *  设置键盘模式
//         */
//        self.telphoneTF.keyboardType = UIKeyboardTypeNumberPad;
//        self.captchaTF.keyboardType = UIKeyboardTypeNumberPad;
//        
//        
//        
//        /**
//         *  设置占位符
//         */
//        self.telphoneTF.placeholder = @"   请输入手机号";
//        self.captchaTF.placeholder = @"   请输入验证码";
//        self.pwdTF.placeholder = @"   请输入新密码";
//        self.okPwdTF.placeholder = @"   请确认新密码";
//        
//        
//        
//        /**
//         *  设置加密输入
//         */
//        self.pwdTF.secureTextEntry = YES;
//        self.okPwdTF.secureTextEntry = YES;
//        
//    }
//    
//    return self;
//}
//
//
//
//// 事件:获取验证码点击事件
//- (void)captchaAction
//{
//}
//
//
//
//// 事件:提交按钮点击事件
//- (void)handAction
//{
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
