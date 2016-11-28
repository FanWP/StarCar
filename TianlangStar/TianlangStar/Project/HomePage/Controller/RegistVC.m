//
//  RegistVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//
#define kver3 (0.03 * KScreenHeight)

#import "RegistVC.h"
#import "RegistProtocolVC.h"
#import "AlertView.h"


@interface RegistVC ()

/** 记录验证码 */
@property (nonatomic,assign) BOOL selectedBTN;

/** 公钥 */
@property (nonatomic,copy) NSString *publicKey;

@end

@implementation RegistVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"注册";// 导航栏标题
    
    self.view.backgroundColor = [UIColor whiteColor];// 这个页面的背景颜色
    
    self.selectedBTN = NO;// 初始状态
    
    [self leftItem];// 返回按钮
    
    [self getPubicKey];// 获取公钥
}



/** 返回 */
- (void)leftItem
{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow"] style:(UIBarButtonItemStylePlain) target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(backAction)];
}
/** 事件:点击返回的事件 */
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 *  获取公钥
 */
- (NSString *)getPubicKey
{
    NSString *url = [NSString stringWithFormat:@"%@unlogin/sendpubkeyservlet",URL];
    [[AFHTTPSessionManager manager] POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"获取公钥信息----%@",responseObject);
         
         //若一开始从未从服务器获取到公钥，则从本地获取公钥
         if (_publicKey == nil )
         {
             UserInfo *userIn = [UserInfo sharedUserInfo];
             self.publicKey = userIn.publicKey;
             YYLog(@"本地公钥%@",self.publicKey);
         }
         
         self.publicKey =responseObject[@"pubKey"];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         YYLog(@"获取公钥信息失败---%@",error);
     }];
    
    return self.publicKey;
}



// 初始化
- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
        // 输入手机号
        CGFloat telX = 0.04 * KScreenWidth;
        CGFloat telY = 100;
        CGFloat telWidth = KScreenWidth - 2 * telX;
        CGFloat telHeight = 0.06 * KScreenHeight;
        self.telphoneTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, telY, telWidth, telHeight)];
        [self.view addSubview:self.telphoneTF];
        
        
        
        // 输入验证码
        CGFloat captchaTFY = telY + telHeight + kver3;
        CGFloat captchaWidth = 0.55 * telWidth;
        self.captchaTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, captchaTFY, captchaWidth, telHeight)];
        [self.view addSubview:self.captchaTF];
        
        // 点击获取验证码
        CGFloat captchaButtonX = telX + captchaWidth + Klength10;
        CGFloat captchaButtonWidth = telWidth - captchaWidth - Klength10;
        self.captchaButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.captchaButton.frame = CGRectMake(captchaButtonX, captchaTFY, captchaButtonWidth, telHeight);
        [self.captchaButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [self.captchaButton addTarget:self action:@selector(captchaAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.captchaButton setTintColor:buttonTitleC];
        [self.view addSubview:self.captchaButton];
        
        
        
        // 输入密码
        CGFloat pwdTFY = captchaTFY + telHeight + kver3;
        self.pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, pwdTFY, telWidth, telHeight)];
        [self.view addSubview:self.pwdTF];
        
        
        
        // 确认输入的密码
        CGFloat okPwdTFY = pwdTFY + telHeight + kver3;
        self.okPwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, okPwdTFY, telWidth, telHeight)];
        [self.view addSubview:self.okPwdTF];
        
        
        
        // 确定注册按钮
        CGFloat okWidth = telWidth;
        CGFloat okX = (KScreenWidth / 2) - (okWidth / 2);
        CGFloat okY = okPwdTFY + telHeight + 0.05 * KScreenHeight;
        CGFloat okHeight = 0.07 * KScreenHeight;
        self.okButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.okButton.frame = CGRectMake(okX, okY, okWidth, okHeight);
        [self.okButton setTitle:@"注  册" forState:
         (UIControlStateNormal)];
        [self.okButton setTintColor:buttonTitleC];
        [self.okButton addTarget:self action:@selector(okRegistAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.okButton];
        
        
        
        // 复选框
        CGFloat selectButtonY = okY + okHeight + 0.04 * KScreenHeight;
        CGFloat selectButtonWidth = 30;
        self.selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.selectButton.frame = CGRectMake(telX, selectButtonY, selectButtonWidth, selectButtonWidth);
        [self.selectButton setImage:[UIImage imageNamed:@"selected"] forState:(UIControlStateNormal)];
        [self.selectButton setImage:[UIImage imageNamed:@"select"] forState:(UIControlStateSelected)];
        [self.selectButton addTarget:self action:@selector(selectAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.selectButton];
        
        
        
        // 用户注册协议
        CGFloat protocolButtonX = telX + selectButtonWidth + 5;
        CGFloat protocolButtonWidth = telWidth - selectButtonWidth - 5;
        self.protocolButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.protocolButton.frame = CGRectMake(protocolButtonX, selectButtonY, protocolButtonWidth, 30);
        [self.protocolButton setTitle:@"我已阅读并同意《用户注册协议》" forState:(UIControlStateNormal)];
        [self.protocolButton setTitleColor:[UIColor colorWithRed:0.145 green:0.487 blue:1.000 alpha:1.000] forState:(UIControlStateNormal)];
        [self.protocolButton.titleLabel setFont:Font14];
        self.protocolButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.protocolButton addTarget:self action:@selector(protocolAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.protocolButton];
        
        
        
        /**
         *  设置字体大小
         */
        self.telphoneTF.font = Font16;
        self.captchaTF.font = Font16;
        self.captchaButton.titleLabel.font = Font16;
        self.pwdTF.font = Font16;
        self.okPwdTF.font = Font16;
        [self.okButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        
        
        
        /**
         *  设置背景颜色
         */
        self.telphoneTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
        self.captchaTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
        self.captchaButton.backgroundColor = [UIColor colorWithRed:37.0 / 255.0  green:215.0 / 255.0 blue:252.0 / 255.0 alpha:1.0];
        self.pwdTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
        self.okPwdTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
        self.okButton.backgroundColor = [UIColor colorWithRed:37.0 / 255.0  green:215.0 / 255.0 blue:252.0 / 255.0 alpha:1.0];
        
        
        
        /**
         *  设置输入框的编辑模式
         */
        self.telphoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.captchaTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.okPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        
        
        /**
         *  设置输入框的样式
         */
        self.telphoneTF.borderStyle = UITextBorderStyleNone;
        self.captchaTF.borderStyle = UITextBorderStyleNone;
        self.pwdTF.borderStyle = UITextBorderStyleNone;
        self.okPwdTF.borderStyle = UITextBorderStyleNone;
        
        
        
        /**
         *  设置输入框的圆角
         */
        self.telphoneTF.layer.cornerRadius = BtncornerRadius;
        self.telphoneTF.layer.masksToBounds = YES;
        self.captchaTF.layer.cornerRadius = BtncornerRadius;
        self.captchaTF.layer.masksToBounds = YES;
        self.captchaButton.layer.cornerRadius = BtncornerRadius;
        self.pwdTF.layer.cornerRadius = BtncornerRadius;
        self.pwdTF.layer.masksToBounds = YES;
        self.okPwdTF.layer.cornerRadius = BtncornerRadius;
        self.okPwdTF.layer.masksToBounds = YES;
        self.okButton.layer.cornerRadius = self.okButton.height / 2;
        
        
        
        /**
         *  设置键盘模式
         */
        self.telphoneTF.keyboardType = UIKeyboardTypeNumberPad;
        self.captchaTF.keyboardType = UIKeyboardTypeNumberPad;
        
        
        
        /**
         *  设置占位符
         */
        self.telphoneTF.placeholder = @"   请输入手机号";
        self.captchaTF.placeholder = @"   请输入验证码";
        self.pwdTF.placeholder = @"   请输入密码";
        self.okPwdTF.placeholder = @"   请确认密码";
        
        
        
        /**
         *  设置加密输入
         */
        self.pwdTF.secureTextEntry = YES;
        self.okPwdTF.secureTextEntry = YES;
    }
    
    return self;
}



// 事件:用户点击事件
- (void)protocolAction
{
    RegistProtocolVC *registProtocolVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RegistProVC"];
    [self.navigationController pushViewController:registProtocolVC animated:YES];
}



// 事件:复选框的点击事件
- (void)selectAction
{
    YYLog(@"复选框的点击事件");
    
    self.selectButton.selected = !self.selectButton.selected;
}



/** 事件:获取验证码的点击事件 */
- (void)captchaAction
{
    //判断手机号输入是否正确
    if (![self.telphoneTF.text isMobileNumber])
    {
        [[AlertView sharedAlertView] addAlertMessage:@"手机号输入有误，请核对！" title:@"提示"];
        return;
    }
    
    //判断验证码是否可用，第一次进入时调用
    if (!self.selectedBTN)
    {
        [HttpTool getNumbers:self.telphoneTF.text];
    }
    
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^
      {
      if(timeout<=0)
      { //倒计时结束，关闭
          dispatch_source_cancel(_timer);
          dispatch_async(dispatch_get_main_queue(), ^
     {
         //记录按钮的是否可以点击事件
         self.selectedBTN = NO;
         [self.captchaButton setTitle:@"重发验证码" forState:UIControlStateNormal];
         self.captchaButton.userInteractionEnabled = YES; });
      }else
      {
          int seconds = timeout % 60;
          self.selectedBTN = YES;
          
          NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
          dispatch_async(dispatch_get_main_queue(), ^
         {
             //设置界面的按钮显示 根据自己需求设置
             //        YYLog(@"____%@",strTime);
             self.selectedBTN = YES;
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



/** 事件:确定注册按钮的点击事件 */
- (void)okRegistAction
{
    if (self.selectButton.selected == NO)
    {
        /** 判断输入框是否为空 */
        if (self.telphoneTF.text == nil || self.telphoneTF.text.length ==0 ||
            self.pwdTF.text == nil || self.pwdTF.text.length ==0           ||
            self.okPwdTF.text == nil || self.okPwdTF.text.length ==0)
        {
            [[AlertView sharedAlertView] addAlertMessage:@"信息不全，请核对！" title:@"提示"];
            return;
        }
        
        //电话号
        if ( ![self.telphoneTF.text isMobileNumber])
        {
            [[AlertView sharedAlertView] addAlertMessage:@"手机号有误，请核对!" title:@"提示"];
            return;
        }
        else if (! (self.pwdTF.text.length >5 && self.pwdTF.text.length <18))
            //密码
        {
            [[AlertView sharedAlertView] addAlertMessage:@"密码错误，请输入6-18位密码！" title:@"提示"];
            return;
        }
        
        //确认密码
        else if (! [self.okPwdTF.text isEqualToString:self.pwdTF.text] )
        {
            [[AlertView sharedAlertView] addAlertMessage:@"密码不一致，请核对！" title:@"提示"];
            return;
        }
        
        //验证码
        if (!(self.captchaTF.text.length == 6))
        {
            [[AlertView sharedAlertView] addAlertMessage:@"验证码不能为空，请核对！" title:@"提示"];
            return;
        }
        
        if (![self.captchaTF.text isPureInt])
        {
            [[AlertView sharedAlertView] addAlertMessage:@"验证码不能为空，请核对！" title:@"提示"];
            return;
        }
        
        
        
        //rsa加密
        NSString *password = [RSA encryptString:self.pwdTF.text publicKey:self.publicKey];
        //拼接注册参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"username"] = self.telphoneTF.text;
        params[@"value"] = password;
        params[@"checkcode"] = self.captchaTF.text;
        
        /*
         Int resultCode  1006 表示参数中有null
         Int resultCode  1007表示没有登录
         Int resultCode  1010表示用户密码与用户确认密码不同
         Int resultCode  1011 表示年龄不符合条件
         Int resultCode  1013  表示用户名在数据库中已经存在
         Int resultCode  1015  表示用户验证码不匹配
         */
        
        //注册post请求
        //设置遮盖
        // 显示指示器
        [SVProgressHUD setMinimumDismissTimeInterval:3];
        [SVProgressHUD showWithStatus:@"正在注册"];
        NSString *url = [NSString stringWithFormat:@"%@unlogin/registeruserservlet",URL];
        [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
         {
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             //取消提示
             YYLog(@"请求成功----%@",responseObject);
             //1.获取返回值
             NSNumber *resultCode = responseObject[@"resultCode"];
             //转换
             NSInteger result = [resultCode integerValue];
             //判断并处理返回值
             //         [self checkResultCode:result];
             YYLog(@"result----%ld",(long)result);
             
             switch (result)
             {
                 case 1000://注册成功
                 {
                     //0.设置用户提示
                     [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                     //1.保存用户名和密码到沙河
                     UserInfo *userIn = [UserInfo sharedUserInfo];
                     userIn.username = self.telphoneTF.text;
                     userIn.passWord = self.pwdTF.text;
                     [userIn synchronizeToSandBox];
                     
                     [self.navigationController popViewControllerAnimated:YES];
                     break;
                 }
                 case 1006://参数中有空
                 {
                     YYLog(@"参数中有空");
                     //                 [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                     break;
                 }
                 case 1008://参数中有空
                 {
                     YYLog(@"参数中有空");
                     [SVProgressHUD showErrorWithStatus:@"验证码错误，请核对！"];
                     break;
                 }
                 case 1010://表示用户密码与用户确认密码不同
                 {
                     YYLog(@"用户密码与用户确认密码不同");
                     break;
                 }
                 case 1013://用户名在数据库中已经存在
                 {
                     YYLog(@"用户名在数据库中已经存在");
                     [SVProgressHUD showErrorWithStatus:@"此用户名已存在，请更换！"];
                     break;
                 }
                 case 1014://用户名在数据库中已经存在
                 {
                     YYLog(@"用户名在数据库中已经存在");
                     [SVProgressHUD showErrorWithStatus:@"此用户名已存在，请更换！"];
                     break;
                 }
                 case 1015://表示用户验证码不匹配
                 {
                     YYLog(@"表示用户验证码不匹配");
                     [SVProgressHUD showErrorWithStatus:@"验证码不匹配！"];
                     break;
                 }
                 default:
                     break;
             }
             [SVProgressHUD dismissWithDelay:3];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             YYLog(@"失败----%@",error);
             // 显示失败信息
             [SVProgressHUD showErrorWithStatus:@"服务器繁忙，请稍后再试!"];
             [SVProgressHUD dismiss];
         }];
    }
    else
    {
        [[AlertView sharedAlertView] addAlertMessage:@"请同意用户注册协议" title:@"提示"];
    }
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
