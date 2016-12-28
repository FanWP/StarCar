//
//  ForgetPwdVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#define kver4 (0.04 * KScreenHeight)

#import "ForgetPwdVC.h"

@interface ForgetPwdVC ()

/** 验证码是否可用 */
@property (nonatomic,assign) BOOL selectedBTN;

@property (nonatomic,strong) NSArray *fields;

@end

@implementation ForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"忘记密码";// 导航栏按钮
    
    self.view.backgroundColor = [UIColor whiteColor];// 忘记密码页面的背景色
}


/** 加载输入框数组 */
- (NSArray *)fields
{
    NSArray *views = self.view.subviews;
    NSMutableArray *fieldM = [NSMutableArray array];
    for (UIView *child in views)
    {
        if ([child isKindOfClass:[UITextField class]])
        {
            [fieldM addObject:child];
        }
        _fields = fieldM;
    }
    return _fields;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.25 animations:^
     {
         [self.view endEditing:YES];
     }];
}

/**
 监听键盘的变化事件
 */
- (void)setupKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
}



-(void)keyboardFrameChange:(NSNotification *)notificat
{
    //获取键盘变化的Y值
    //此时为键盘结束时的frame
    CGRect kbEndFrame = [notificat.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘结束时的Y值
    CGFloat kbEndY = kbEndFrame.origin.y;
    
    //获取当前Textfield的响应者
    UITextField *textf = nil;
    for (UITextField *textF in self.fields)
    {
        if (textF.isFirstResponder)
        {
            textf = textF;
        }
    }
    
    //获取textField的Y值
    CGFloat textY = CGRectGetMaxY(textf.frame);
    if (textY >kbEndY)
    {
        [UIView animateWithDuration:0.25 animations:^
         {
             self.view.transform = CGAffineTransformMakeTranslation(0, kbEndY - textY);
         }];
        
    }else{
        [UIView animateWithDuration:0.25 animations:^
         {
             self.view.transform = CGAffineTransformIdentity;
         }];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
        CGFloat captchaTFY = telY + telHeight + kver4;
        CGFloat captchaWidth = 0.55 * telWidth;
        self.captchaTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, captchaTFY, captchaWidth, telHeight)];
        [self.view addSubview:self.captchaTF];

        // 点击获取验证码
        CGFloat captchaButtonX = telX + captchaWidth + Klength10;
        CGFloat captchaButtonWidth = telWidth - captchaWidth - Klength10;
        self.captchaButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.captchaButton.frame = CGRectMake(captchaButtonX, captchaTFY, captchaButtonWidth, telHeight);
        [self.captchaButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [self.captchaButton addTarget:self action:@selector(captchaActionForgetpwd) forControlEvents:(UIControlEventTouchUpInside)];
        [self.captchaButton setTintColor:buttonTitleC];
        [self.view addSubview:self.captchaButton];



        // 输入密码
        CGFloat pwdTFY = captchaTFY + telHeight + kver4;
        self.pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, pwdTFY, telWidth, telHeight)];
        [self.view addSubview:self.pwdTF];



        // 确认输入的密码
        CGFloat okPwdTFY = pwdTFY + telHeight + kver4;
        self.okPwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, okPwdTFY, telWidth, telHeight)];
        [self.view addSubview:self.okPwdTF];



        // 确定提交按钮
        CGFloat handButtonWidth = telWidth;
        CGFloat handButtonX = (KScreenWidth / 2) - (handButtonWidth / 2);
        CGFloat handButtonY = okPwdTFY + telHeight + 0.14 * KScreenHeight;
        CGFloat handButtonHeight = 0.07 * KScreenHeight;
        self.handButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.handButton.frame = CGRectMake(handButtonX, handButtonY, handButtonWidth, handButtonHeight);
        [self.handButton setTitle:@"提  交" forState:
         (UIControlStateNormal)];
        [self.handButton setTintColor:buttonTitleC];
        [self.handButton addTarget:self action:@selector(handAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.handButton];



        /**
         *  设置字体大小
         */
        self.telphoneTF.font = Font16;
        self.captchaTF.font = Font16;
        self.captchaButton.titleLabel.font = Font16;
        self.pwdTF.font = Font16;
        self.okPwdTF.font = Font16;
        [self.handButton.titleLabel setFont:[UIFont systemFontOfSize:20]];



        /**
         *  设置背景颜色
         */
        self.telphoneTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
        self.captchaTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
        self.captchaButton.backgroundColor = [UIColor colorWithRed:37.0 / 255.0  green:215.0 / 255.0 blue:252.0 / 255.0 alpha:1.0];
        self.pwdTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
        self.okPwdTF.backgroundColor = [UIColor colorWithRed:221.0 / 255.0  green:227.0 / 255.0 blue:238.0 / 255.0 alpha:1.0];
        self.handButton.backgroundColor = [UIColor colorWithRed:37.0 / 255.0  green:215.0 / 255.0 blue:252.0 / 255.0 alpha:1.0];



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
        self.handButton.layer.cornerRadius = self.handButton.height / 2;



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
        self.pwdTF.placeholder = @"   请输入新密码";
        self.okPwdTF.placeholder = @"   请确认新密码";



        /**
         *  设置加密输入
         */
        self.pwdTF.secureTextEntry = YES;
        self.okPwdTF.secureTextEntry = YES;

    }

    return self;
}



// 事件:获取验证码点击事件
- (void)captchaActionForgetpwd
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
                               self.selectedBTN = NO;
                               [self.captchaButton setTitle:@"重发验证码" forState:UIControlStateNormal];
                               self.captchaButton.userInteractionEnabled = YES; });
        }else
        {
            int seconds = timeout % 30;
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



// 事件:提交按钮点击事件
- (void)handAction
{
    [self.view endEditing:YES];
    //    //核对输入参数
    
    
    //总体
    NSInteger count  = self.fields.count;
    for (int i =0; i < count ; i++)
    {
        UITextField * field= self.fields[i];
        if (field.text.length ==0 || field.text ==nil)
        {
            [[AlertView sharedAlertView] addAlertMessage:@"信息不全，请核对！" title:@"提示"];
            return;
        }}
    
    //电话号
    if ( ![self.telphoneTF.text isMobileNumber])
    {
        [[AlertView sharedAlertView] addAlertMessage:@"手机号输入有误，请核对!" title:@"提示"];
        return;
    }
    //密码
    if (! (self.pwdTF.text.length >5 && self.pwdTF.text.length <33) )
    {
        
        [[AlertView sharedAlertView] addAlertMessage:@"密码输入错误，请输入6-32位密码！" title:@"提示"];
        return;
    }
    
    //确认密码
    if (! [self.okPwdTF.text isEqualToString:self.pwdTF.text] )
    {
        
        [[AlertView sharedAlertView] addAlertMessage:@"密码输入不一致，请核对！" title:@"提示"];
        return;
    }
    
    //验证码
    if (!(self.captchaTF.text.length == 6))
    {
        [[AlertView sharedAlertView] addAlertMessage:@"验证码输入有误，请核对！" title:@"提示"];
        return;
    }
    
    /*
     忘记密码
     地    址:	http://192.168.10.114:8080/carservice/updateuserpasswdservlet
     需要参数:	
     String username 用户名 (必填)
     String password 密码 (必填)
     String repassword 确认密码 (必填)
     String checkcode 验证码
     请求方式	POST
     执行操作:	当前用户忘记密码时，通过这个接口进行更改密码。
     返回结果:	Int resultCode  1000表示成功
     Int resultCode  1000表示成功
     Int resultCode  1001表示数据库没有数据
     Int resultCode  1007用户没有登录
     Int resultCode  1021 用户不存在
     Int resultCode  1008 验证码错误
     Int resultCode  1015 验证码不批配
     Int resultCode  1020 修改操作没有成功
     Int resultCode  1005 接口异常
     */
    
    UserInfo *userIn = [UserInfo sharedUserInfo];
    
    NSString *password = [RSA encryptString:self.pwdTF.text publicKey:userIn.publicKey];
    
    //拼接注册参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"username"] = self.telphoneTF.text;
    params[@"value"] = password;
    params[@"checkcode"] = self.captchaTF.text;
    
    YYLog(@"params----%@",params);
    
    //设置遮盖
    [SVProgressHUD show];
    NSString *url = [NSString stringWithFormat:@"%@unlogin/updateuserpasswdservlet",URL];
    [[AFHTTPSessionManager manager] POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"找回密码解析成功========%@",responseObject);
         //1.移除遮盖
         [SVProgressHUD setMinimumDismissTimeInterval:3];
         
         NSNumber *resultCode = responseObject[@"resultCode"];
         int result = [resultCode intValue];
         
         [self checkFindPwdResult:result];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"找回密码解析失败----%@",error);
         // 显示失败信息
         [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
     }];
}



-(void)checkFindPwdResult:(int)result
{
    switch (result)
    {
        case 1000:
        {
            [SVProgressHUD showSuccessWithStatus:@"找回成功！"];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        case 1020:
        {
            [SVProgressHUD showErrorWithStatus:@"修改密码失败！"];
            break;
        }
        case 1021:
        {
            [SVProgressHUD showErrorWithStatus:@"用户名不存在！"];
            break;
        }
        case 1008:
        {
            [SVProgressHUD showErrorWithStatus:@"验证码错误！"];
            break;
        }
            
        default:
            break;
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
