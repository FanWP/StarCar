//
//  LoginView.m
//  TianlangStar
//
//  Created by youyousiji on 16/10/31.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "LoginView.h"
#import "UserModel.h"
#import "ForgetPwdVC.h"
#import "RegistVC.h"

@interface LoginView ()

/** 导航控制器 */
@property (nonatomic,strong) UINavigationController *nav;

@property (nonatomic,weak) UIImageView *userNamePic;
@property (nonatomic,weak) UITextField *userNameTF;
@property (nonatomic,weak) UIImageView *pwdPic;
@property (nonatomic,weak) UITextField *pwdTF;
@property (nonatomic,weak) UIImageView *captchaPic;// 验证码
@property (nonatomic,weak) UITextField *captchaTF;
@property (nonatomic,weak) UIButton *captchaButton;
@property (nonatomic,weak) UIButton *registButton;
@property (nonatomic,weak) UIButton *foundPwdButton;
@property (nonatomic,weak) UIButton *okButton;


/** 用户登录的容器 */
@property (nonatomic,weak) UIView *userView;

/** 用户登录的密码容器 */
@property (nonatomic,weak) UIView *passWordView;

/** 用户登录的验证码 */
@property (nonatomic,weak) UIView *checkView;


/** 登录界面的背景的图片 */
@property (nonatomic,weak) UIImageView *bgImageView;

/** 注册 */
@property (nonatomic,weak) UIButton *regist;

/** 用户模型 */
@property (nonatomic,strong) UserModel *userM;


/** 记录Y值 */
@property (nonatomic,assign) CGFloat okY;
/** 提示框 */
@property (nonatomic,strong) AlertView *alertView;

@end

@implementation LoginView


-(UINavigationController *)nav
{
    if (!_nav)
    {
        UITabBarController *tableBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        _nav = (UINavigationController *)tableBar.selectedViewController;
        
    }
    return _nav;
}

-(AlertView *)alertView
{
    if (!_alertView) {
        _alertView = [AlertView sharedAlertView];
    }
    return _alertView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.bgImageView = bgImageView;
        bgImageView.image = [UIImage imageNamed:@"loginBg"];
        self.bgImageView.userInteractionEnabled = YES;
        [self addSubview:bgImageView];
        self.backgroundColor = [UIColor redColor];
        
        
        //用户名的输入框
        UIView *userView = [[UIView alloc] init];
        userView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
        userView.y = KScreenHeight * 0.38;
        userView.x = KScreenWidth * 0.06;
        userView.width = KScreenWidth - 2 * userView.x;
        userView.height = KScreenHeight * 0.07;
        self.userView = userView;
        
        [self.bgImageView addSubview:userView];
        
        // 用户名
        
        CGFloat marginX = 10;
        UIImageView *userNamePic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
        userNamePic.x = marginX;
        userNamePic.centerY = userView.height * 0.5;
        self.userNamePic = userNamePic;
        [userView addSubview:self.userNamePic];
        
        // 输入用户名
        UITextField *userNameTF = [[UITextField alloc] init];
        userNameTF.width = userView.width - userNamePic.width - 2 * marginX;
        userNameTF.height = userView.height * 0.8;
        userNameTF.x = CGRectGetMaxX(userNamePic.frame) + marginX;
        userNameTF.centerY = userView.height * 0.6;
        userNameTF.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        self.userNameTF = userNameTF;
        self.userNameTF.borderStyle = TFborderStyle;
        self.userNameTF.keyboardType = UIKeyboardTypeNumberPad;
        self.userNameTF.placeholder = @"请输入手机号";
        self.userNameTF.textColor = [UIColor whiteColor];
        self.userNameTF.font = Font18;
        self.userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [userView addSubview:self.userNameTF];
        
        
        //密码框的输入容器
        UIView *passWordView = [[UIView alloc] init];
        passWordView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
        passWordView.y = CGRectGetMaxY(userView.frame) + KScreenHeight * 0.02;
        passWordView.x = userView.x;
        passWordView.width = userView.width;
        passWordView.height = userView.height;
        self.passWordView = passWordView;
        [self.bgImageView addSubview:passWordView];
        
        
        
        // 密码
        UIImageView * pwdPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
        pwdPic.x = marginX + 3;
        pwdPic.centerY = passWordView.height * 0.5;
        self.pwdPic = pwdPic;
        [passWordView addSubview:pwdPic];
        
        // 请输入密码
        UITextField *pwdTF = [[UITextField alloc] init];
        
        pwdTF.width = userNameTF.width;
        pwdTF.height = userNameTF.height;
        pwdTF.x = CGRectGetMaxX(pwdPic.frame) + marginX -2;
        pwdTF.centerY = userView.height * 0.6;
        pwdTF.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        self.pwdTF = pwdTF;
        self.pwdTF.borderStyle = TFborderStyle;
        self.pwdTF.placeholder = @"请输入密码";
        self.pwdTF.font = Font18;
        self.pwdTF.secureTextEntry= YES;
        self.pwdTF.textColor = [UIColor whiteColor];
        self.pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [passWordView addSubview:self.pwdTF];
        
        //        //设置密码框下面的白条
        //        UIView *cutView = [[UIView alloc] init];
        //        cutView.x = 0;
        //        cutView.y = passWordView.height + 1;
        //        cutView.width = passWordView.width;
        //        cutView.height = 3;
        //        cutView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        //        [passWordView addSubview:cutView];
        
        
        
        
        //验证码的输入容器
        UIView *checkView = [[UIView alloc] init];
        checkView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
//        checkView.backgroundColor = [UIColor redColor];
//        checkView.y = CGRectGetMaxY(passWordView.frame) + KScreenHeight * 0.02;
        checkView.y = userView.y - userView.height - 16;
        checkView.x = userView.x;
        checkView.width = userView.width;
        checkView.height = userView.height;
        self.checkView = checkView;
        [self.bgImageView addSubview:checkView];


        //验证码
        UIImageView * captchaPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yanzhengma"]];
        captchaPic.x = marginX + 3;
        captchaPic.centerY = checkView.height * 0.5;
        self.captchaPic = captchaPic;
        [checkView addSubview:captchaPic];
        
        
        
        UIButton *captchaButton = [[UIButton alloc] init];
        captchaButton.width = 100;
        captchaButton.height = 40;
        captchaButton.x = checkView.width - 100;
        captchaButton.centerY = captchaPic.centerY;
        [captchaButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [captchaButton addTarget:self action:@selector(captchaAction) forControlEvents:UIControlEventTouchUpInside];
        self.captchaButton = captchaButton;
        [checkView addSubview:captchaButton];
        
        // 请输入验证码
        UITextField *captchaTF = [[UITextField alloc] init];
        captchaTF.width = userNameTF.width - captchaButton.width;
        captchaTF.height = userNameTF.height;
        captchaTF.x = CGRectGetMaxX(pwdPic.frame) + marginX -2;
        captchaTF.y = captchaButton.y;
        captchaTF.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        self.captchaTF = captchaTF;
        self.captchaTF.borderStyle = TFborderStyle;
        self.captchaTF.placeholder = @"请输入验证码";
        self.captchaTF.font = Font18;
        self.captchaTF.secureTextEntry= YES;
        self.captchaTF.textColor = [UIColor whiteColor];
        self.captchaTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [checkView addSubview:self.captchaTF];
        
        

        

        //新用户的和忘记密码
        UIButton *registButton = [[UIButton alloc ] init];
        registButton.x = KScreenWidth * 0.07;
        registButton.y = CGRectGetMidY(passWordView.frame) + 55;
        registButton.width = 90;
        registButton.height = 40;
        [registButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.8] forState:UIControlStateNormal];
        registButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [registButton setTitle:@"新用户" forState:UIControlStateNormal];
        [registButton addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
        self.registButton = registButton;
        [self.bgImageView addSubview:registButton];
        
        //忘记密码
        UIButton *foundPwdButton = [[UIButton alloc ] init];
        foundPwdButton.y = registButton.y;
        foundPwdButton.width = 90;
        foundPwdButton.height = 40;
        foundPwdButton.x = KScreenWidth * 0.93 - foundPwdButton.width;
        [foundPwdButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.8] forState:UIControlStateNormal];
        [foundPwdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [foundPwdButton addTarget:self action:@selector(foundPwdAction) forControlEvents:UIControlEventTouchUpInside];
        self.foundPwdButton = registButton;
        [self.bgImageView addSubview:foundPwdButton];
        
        
        
        // 确认Button
        UIButton *okButton = [[UIButton alloc] init];
        okButton.width = KScreenWidth * 0.86;
        okButton.height = userView.height;
        okButton.y = KScreenHeight * 0.76 - okButton.height;
        okButton.centerX = KScreenWidth * 0.5;
        self.okButton  = okButton;
        [self.okButton setTitle:@" 登    录 " forState:(UIControlStateNormal)];
        [self.okButton addTarget:self action:@selector(okAction) forControlEvents:(UIControlEventTouchUpInside)];
        okButton.titleLabel.font = Font22;
        self.okButton.backgroundColor = XLXcolor(37, 215, 252);
        self.okButton.layer.cornerRadius = 25;
        //        [self.okButton setTintColor:buttonTitleC];
        
        [self.bgImageView addSubview:self.okButton];
        
        
    }
    return self;
}


/** 发送验证码点击按钮 */
-(void)captchaAction
{
    //判断手机号输入是否正确
    if (![self.userNameTF.text isMobileNumber])
    {
        [[AlertView sharedAlertView] addAlertMessage:@"手机号输入有误，请核对！" title:@"提示"];
        return;
    }

    // 判断验证码是否可用，第一次进入时调用
    if (self.captchaButton.enabled == NO) return;
    //获取验证码
//    [[AlertView sharedAlertView] getNumbers:self.userNameTF.text];

    __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0)
        { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^
                           {
       //记录按钮的是否可以点击事件
       self.captchaButton.enabled = YES;
       [self.captchaButton setTitle:@"重发验证码" forState:UIControlStateNormal];
       self.captchaButton.userInteractionEnabled = YES; });
        }else
        {
            int seconds = timeout % 30;
            self.captchaButton.enabled = NO;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^
                           {
       //设置界面的按钮显示 根据自己需求设置
//               YYLog(@"____%@",strTime);
       [UIView beginAnimations:nil context:nil];
       [UIView setAnimationDuration:1];
       [self.captchaButton setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
       [UIView commitAnimations];
       self.captchaButton.userInteractionEnabled = NO;
           });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}



//登录按钮的点击事件
- (void)okAction
{
    if (self.userNameTF.text == nil || self.userNameTF.text.length == 0) {
        [[AlertView sharedAlertView] addAlertMessage:@"用户名不能为空" title:@"提示"];
        return;
    }
    if (self.pwdTF.text == nil || self.pwdTF.text.length == 0) {
        [[AlertView sharedAlertView] addAlertMessage:@"密码" title:@"提示"];
        return;
    }

    //判断用户输入数据的合法性
    if ( ![self.userNameTF.text isMobileNumber])
    {
        [self.alertView addAlertMessage:@"用户名为手机号，请核对！" title:@"提示"];
        return;
    }
    
    if (! (self.pwdTF.text.length >5 && self.pwdTF.text.length <33) )
    {
        [self.alertView addAlertMessage:@"密码错误，请输入6-32位密码！" title:@"提示"];
        return;
    }
    
    //    if (![self.pwdTF.text isLegalInput])
    //    {
    
    //    [[AlertView sharedAlertView] addAlertMessage:@"密码为数字加字母组合" title:@"提示！"];
    //    }
    
    
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    
    
    //拼接参数
    //rsa加密
    NSString *password = [RSA encryptString:self.pwdTF.text publicKey:userInfo.publicKey];
    //手机序列号的获取
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = self.userNameTF.text;
    params[@"value"] = password;
    params[@"code"] = self.captchaTF.text;
//    params[@"terminal"] = uuid;
    params[@"terminal"] = @"421A6988-DA96-49FE-B99E-16820320F1BB";
    YYLog(@"登录--%@",params);
    
    //    YYLog(@"序列号%@",uuid);
    /*
     Int resultCode  1006 表示参数中有null
     Int resultCode  1007表示没有登录
     Int resultCode  1010表示用户密码与用户确认密码不同
     Int resultCode  1011 表示年龄不符合条件
     Int resultCode  1013  表示用户名在数据库中已经存在
     Int resultCode  1015  表示用户验证码不匹配
     Int resultCode  1003 密码错误
     1001数据库没有记录
     1014账户名重复
     
     
     
     地    址:	/unlogin/userlogin
     需要参数:	String username 用户名 (必填)
     String value 密码 (必填)
     String terminal 序列号（必填）
     String  code 验证码（有就填，没有不填）
     执行操作:	验证密码和用户名
     Tbl_session 插入一条数据
     Tbl_record 中插入一条数据
     返回结果:	1000表示成功
     */
    //设置这遮盖
    
    [SVProgressHUD showWithStatus:@"正在登录"];
    
    NSString *url = [NSString stringWithFormat:@"%@unlogin/userlogin",URL];
    YYLog(@"url---%@",url);
    
    [HttpTool post:url parmas:params success:^(id json)
     {
         //1.移除遮盖
         [SVProgressHUD dismiss];
         YYLog(@"登录返回--%@",json);
         NSNumber *resultCode = json[@"resultCode"];
         int result = [resultCode intValue];
         //2.判断并处理服务器的返回值
         //3记录sessionID,和用户模型数据
         if (result == 1000)//如果登陆成功才能取出sessionID，否则为空报错
         {
             //获取sessionId
             //取出字典中的用户类型——转模型
             self.userM = [UserModel mj_objectWithKeyValues:json[@"obj"][@"user"]];
             
             NSNumber *mun = json[@"obj"][@"sessionId"];
             NSString *sessionId = [NSString stringWithFormat:@"%@",mun];
             
             //0.设置用户提示
//             [SVProgressHUD showSuccessWithStatus:@"登录成功"];
             //1.保存用户名和密码到沙河
             
             //加密过的sessionID
             NSString *RSASessionID  = [RSA encryptString:sessionId publicKey:userInfo.publicKey];
             userInfo.username = self.userNameTF.text;
             userInfo.sessionId = sessionId;
             userInfo.passWord = self.pwdTF.text;
             userInfo.RSAsessionId = RSASessionID;
             userInfo.userID = self.userM.ID;
             userInfo.userType = self.userM.type;
             userInfo.headerpic = self.userM.headimage;
             userInfo.membername = self.userM.membername;
             userInfo.isLogin = YES;
             
             [userInfo synchronizeToSandBox];
             if ([self.delegate respondsToSelector:@selector(loginSuccess)])
             {
                 [self.delegate loginSuccess];
             }
             
             [self removeFromSuperview];
             
         }else if (result == 1013)//序列号发生改变
         {
             [[AlertView sharedAlertView]addAlertMessage:@"登录设备发生改变，请输入验证码验证！" title:@"提示"];
             self.regist.y = self.okY;
             self.foundPwdButton.y = self.okY;
             self.okButton.y = CGRectGetMaxY(self.regist.frame) + 20;
             
             YYLog(@"用户名在数据库中已经存在");
             return;
         }
         

     } failure:^(NSError *error)
     {
         YYLog(@"登录error----%@",error);
         
     }];
    
}

 
/**
 *  注册
 */
- (void)registAction
{
    RegistVC *vc = [[RegistVC alloc] init];
    [self.nav pushViewController:vc animated:YES];

}

/**
 *  忘记密码
 */
- (void)foundPwdAction
{
    ForgetPwdVC *vc = [[ForgetPwdVC alloc] init];
    [self.nav pushViewController:vc animated:YES];
}




@end
