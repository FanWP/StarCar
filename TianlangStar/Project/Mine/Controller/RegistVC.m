//
//  RegistVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "RegistVC.h"

@interface RegistVC ()

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.pictureView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        self.pictureView.image = [UIImage imageNamed:@"Background"];
        self.pictureView.userInteractionEnabled = YES;
        [self.view addSubview:self.pictureView];
        
        
        
        // 手机号
        CGFloat telLableX = 0.1 * KScreenWidth;
        CGFloat telLableY = KScreenHeight * 0.05;
        CGFloat telLableWidth = 80;
        CGFloat telLableHeight = 30;
        self.telphoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, telLableY, telLableWidth, telLableHeight)];
        self.telphoneLabel.text = @"手机号";
        self.telphoneLabel.font = Font16;
        [self.view addSubview:self.telphoneLabel];
        // 输入手机号
//        CGFloat telX = telLableX + telLableWidth + Khor;
//        CGFloat telWidth = kWidth - telLableX - Kright - telLableWidth - Khor;
//        self.telphoneTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, telLableY, telWidth, telLableHeight)];
//        self.telphoneTF.font = textFieldPlaceholderFont;
//        self.telphoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        self.telphoneTF.borderStyle = TFborderStyle;
//        self.telphoneTF.keyboardType = UIKeyboardTypeNumberPad;
//        self.telphoneTF.placeholder = @"请输入手机号";
//        self.telphoneTF.keyboardType = UIKeyboardTypeNumberPad;
//        [self.view addSubview:self.telphoneTF];
//        
//        
//        
//        // 密码
//        CGFloat pwdLableY = telLableY +telLableHeight + KVer;
//        self.pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, pwdLableY, telLableWidth, telLableHeight)];
//        self.pwdLabel.text = @"密码";
//        self.pwdLabel.font = lableFont;
//        [self.view addSubview:self.pwdLabel];
//        // 输入密码
//        self.pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, pwdLableY, telWidth, telLableHeight)];
//        self.pwdTF.placeholder = @"请输入密码";
//        self.pwdTF.secureTextEntry = YES;
//        self.pwdTF.font = textFieldPlaceholderFont;
//        self.pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        self.pwdTF.borderStyle = TFborderStyle;
//        self.pwdTF.secureTextEntry = YES;
//        [self.view addSubview:self.pwdTF];
//        
//        
//        
//        // 确认密码
//        CGFloat okPwdLabelY = pwdLableY + telLableHeight + KVer;
//        self.okPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, okPwdLabelY, telLableWidth, telLableHeight)];
//        self.okPwdLabel.text = @"确认密码";
//        self.okPwdLabel.font = lableFont;
//        [self.view addSubview:self.okPwdLabel];
//        // 确认输入的密码
//        self.okPwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, okPwdLabelY, telWidth, telLableHeight)];
//        self.okPwdTF.placeholder = @"请确认密码";
//        self.okPwdTF.secureTextEntry = YES;
//        self.okPwdTF.font = textFieldPlaceholderFont;
//        self.okPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        self.okPwdTF.borderStyle = TFborderStyle;
//        self.okPwdTF.secureTextEntry = YES;
//        [self.view addSubview:self.okPwdTF];
//        
//        
//        
//        // 验证码
//        CGFloat captchaLabelY = okPwdLabelY + telLableHeight + KVer;
//        self.captchaLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, captchaLabelY, telLableWidth, telLableHeight)];
//        //        self.captchaLabel.hidden = YES;
//        self.captchaLabel.text = @"验证码";
//        self.captchaTF.keyboardType = UIKeyboardTypeNumberPad;
//        self.captchaLabel.font = lableFont;
//        [self.view addSubview:self.captchaLabel];
//        // 输入验证码
//        CGFloat captchaWidth = 0.55 * telWidth;
//        self.captchaTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, captchaLabelY, captchaWidth, telLableHeight)];
//        //        self.captchaTF.hidden = YES;
//        self.captchaTF.placeholder = @"请输入验证码";
//        self.captchaTF.keyboardType = UIKeyboardTypeNumberPad;
//        self.captchaTF.font = textFieldPlaceholderFont;
//        self.captchaTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        self.captchaTF.borderStyle = TFborderStyle;
//        [self.view addSubview:self.captchaTF];
//        // 点击获取验证码
//        CGFloat captchaButtonX = telX + captchaWidth;
//        CGFloat captchaButtonWidth = 0.45 * telWidth;
//        self.captchaButton = [[UIButton alloc] init];
//        self.captchaButton.frame = CGRectMake(captchaButtonX, captchaLabelY, captchaButtonWidth, telLableHeight);
//        [self.captchaButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
//        [self.captchaButton addTarget:self action:@selector(captchaAction) forControlEvents:(UIControlEventTouchUpInside)];
//        self.captchaButton.backgroundColor = buttonBG;
//        self.captchaButton.layer.cornerRadius = BtncornerRadius;
//        [self.captchaButton setTintColor:buttonTitleC];
//        self.captchaButton.titleLabel.font = lableFont;
//        [self.view addSubview:self.captchaButton];
//        
//        
//        // 推荐人
//        CGFloat referrerLabelY = captchaLabelY + telLableHeight + KVer;
//        self.referrerLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, referrerLabelY, telLableWidth, telLableHeight)];
//        self.referrerLabel.text = @"推荐人";
//        self.referrerLabel.font = lableFont;
//        [self.view addSubview:self.referrerLabel];
//        
//        // 输入推荐人号码
//        CGFloat referrerTFY = captchaLabelY + telLableHeight + KVer;
//        self.referrerTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, referrerTFY, telWidth, telLableHeight)];
//        self.referrerTF.placeholder = @"请输入推荐人电话号码";
//        self.referrerTF.keyboardType = UIKeyboardTypeNumberPad;
//        self.referrerTF.font = textFieldPlaceholderFont;
//        self.referrerTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        self.referrerTF.borderStyle = TFborderStyle;
//        [self.view addSubview:self.referrerTF];
//        
//        
//        
//        // 标识安全码
//        CGFloat safeLabelY = captchaLabelY + telLableHeight + KVer;
//        CGFloat safeLabelHeight = 40;
//        self.safeLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, safeLabelY, telLableWidth, safeLabelHeight)];
//        self.safeLabel.hidden = YES;
//        //        self.safeLabel.backgroundColor = [UIColor redColor];
//        self.safeLabel.text = @"用户类型   标识安全码";
//        self.safeLabel.numberOfLines = 0;
//        self.safeLabel.font = lableFont;
//        self.safeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        
//        [self.view addSubview:self.safeLabel];
//        // 输入安全码
//        //        CGFloat safeTFWidth = 1.3 * (telWidth / 2);
//        CGFloat safeTFY = safeLabelY + (safeLabelHeight - telLableHeight) / 2;
//        self.safeTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, safeTFY, telWidth, telLableHeight)];
//        self.safeTF.hidden = YES;
//        self.safeTF.placeholder = @"请输入安全码";
//        self.safeTF.font = textFieldPlaceholderFont;
//        self.safeTF.borderStyle = TFborderStyle;
//        [self.view addSubview:self.safeTF];
//        
//        // 安全码button
//        //        CGFloat safeButtonX = telX + safeTFWidth;;
//        //        CGFloat safeButtonWidth = telWidth - safeTFWidth;
//        //        self.safeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        //        self.safeButton.frame = CGRectMake(telX, safeLabelY, telWidth, telLableHeight);
//        //        YYLog(@";;; %.f",self.safeButton.frame.size.width);
//        //        self.safeButton.backgroundColor = [UIColor orangeColor];
//        //        [self.safeButton setTitle:@"安全码" forState:(UIControlStateNormal)];
//        //        [self.safeButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//        //        [self.safeButton addTarget:self action:@selector(chooseAction) forControlEvents:(UIControlEventTouchUpInside)];
//        //        [self.view addSubview:self.safeButton];
//        
//        
//        // 是否同意服务条款button
//        CGFloat serveButtonWidth = 20;
//        CGFloat serveButtonX = telX - 20 - 10;
//        CGFloat serveLabelX = serveButtonX + serveButtonWidth + 10;
//        CGFloat serveLabelWidth = kWidth - serveLabelX - Kright;
//        //        CGFloat serveLabelY = safeLabelY + telLableHeight + KVer + KTop;
//        CGFloat serveLabelY = captchaLabelY + telLableHeight + KVer;
//        self.serveButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        self.serveButton.frame = CGRectMake(serveButtonX, serveLabelY + 6, serveButtonWidth, serveButtonWidth);
//        [self.serveButton setImage:[UIImage imageNamed:@"quan"] forState:(UIControlStateNormal)];
//        [self.serveButton setImage:[UIImage imageNamed:@"yuan"] forState:(UIControlStateSelected)];
//        [self.serveButton addTarget:self action:@selector(selectServeAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        //        [self.view addSubview:self.serveButton];
//        
//        
//        
//        // 服务条款
//        //        self.serveLabel = [[UILabel alloc] initWithFrame:CGRectMake(serveLabelX, serveLabelY, serveLabelWidth, telLableHeight)];
//        //        self.serveLabel.textColor = [UIColor orangeColor];
//        //        self.serveLabel.text = @"同意新旅行服务条款";
//        //        self.serveLabel.numberOfLines = 0;
//        //        self.serveLabel.font = lableFont;
//        
//        
//        self.serveLabelButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        self.serveLabelButton.frame = CGRectMake(serveLabelX, serveLabelY + 1.5, serveLabelWidth, telLableHeight);
//        [self.serveLabelButton setTitle:@"我已阅读并同意注册协议" forState:(UIControlStateNormal)];
//        //        [self.serveLabelButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
//        self.serveLabelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        self.serveLabelButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//        
//        [self.serveLabelButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
//        [self.serveLabelButton addTarget:self action:@selector(serviceAction) forControlEvents:(UIControlEventTouchUpInside)];
//        //        [self.view addSubview:self.serveLabelButton];
//        
//        
//        // 发送短信通知
//        CGFloat labelHeight = 60;
//        CGFloat mesageY = serveLabelY + telLableHeight + KVer;
//        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, mesageY + 15, telLableWidth, labelHeight)];
//        self.messageLabel.hidden = YES;
//        self.messageLabel.text = @"同意新旅行向该手机发送促销短信,每周不超过两条！";
//        self.messageLabel.numberOfLines = 0;
//        self.messageLabel.font = lableFont;
//        [self.view addSubview:self.messageLabel];
//        
//        
//        // 是否同意发送短信button
//        self.messageButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        self.messageButton.frame = CGRectMake(telX + 20, mesageY + 20
//                                              , 30, 30);
//        self.messageButton.hidden = YES;
//        [self.messageButton setImage:[UIImage imageNamed:@"di"] forState:(UIControlStateNormal)];
//        [self.messageButton setImage:[UIImage imageNamed:@"select"] forState:(UIControlStateSelected)];
//        //        [self.messageButton addTarget:self action:@selector(selectAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        [self.view addSubview:self.messageButton];
//        
//        
//        // 确定
//        CGFloat okX = (kWidth / 2) - 40;
//        //        CGFloat okY = safeLabelY + labelHeight + 30;
//        CGFloat okY = self.serveLabelButton.y + telLableHeight + KVer;
//        CGFloat okWidth = kWidth *0.4;        CGFloat okHeight = 30;
//        self.okButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        self.okButton.frame = CGRectMake(okX, okY, okWidth, okHeight);
//        self.okButton.centerX = kWidth * 0.5;
//        [self.okButton setTitle:@"确定" forState:
//         (UIControlStateNormal)];
//        self.okButton.backgroundColor = buttonBG;
//        [self.okButton setTintColor:buttonTitleC];
//        self.okButton.layer.cornerRadius = BtncornerRadius;
//        [self.okButton addTarget:self action:@selector(okAction) forControlEvents:(UIControlEventTouchUpInside)];
//        [self.view addSubview:self.okButton];
        
    }
    
    return self;
}



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
