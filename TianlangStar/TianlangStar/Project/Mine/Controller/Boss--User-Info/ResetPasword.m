//
//  ResetPasword.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/5.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ResetPasword.h"

@interface ResetPasword ()

/** 新密码的输入框 */
@property (nonatomic,weak) UITextField *pswText;

/** 确认密码的输入框 */
@property (nonatomic,weak) UITextField *repswText;

@end

@implementation ResetPasword

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"重置密码";
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self setUpControl];
}

-(void) setUpControl
{
    UILabel *newLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 70, 30)];
    newLB.text = @"新密码";
    [self.view addSubview:newLB];
    
    UILabel *rsesetLB = [[UILabel alloc] initWithFrame:CGRectMake(newLB.x, newLB.y + 50, 70, 30)];

    rsesetLB.text = @"确认密码";
    [self.view addSubview:rsesetLB];
    
    
    CGFloat X = newLB.x + newLB.width;
    
    UITextField *pswText = [[UITextField alloc] initWithFrame:CGRectMake(X +20, newLB.y, KScreenWidth - 40 - X, 30)];
    pswText.placeholder = @"请输入密码";
    self.pswText = pswText;
    pswText.font = Font16;
    pswText.borderStyle = TFborderStyle;
    [self.view addSubview:pswText];
    
    
    UITextField *repswText = [[UITextField alloc] initWithFrame:CGRectMake(X +20, rsesetLB.y, KScreenWidth - 40 - X, 30)];
    //    repswText.backgroundColor = [UIColor redColor];
    self.pswText = repswText;
    repswText.placeholder = @"请输入确认密码";
    repswText.font = Font16;
    repswText.borderStyle = TFborderStyle;
    [self.view addSubview:repswText];
    
    
    //增加右上角的保存
    self.navigationItem.rightBarButtonItem = [[ UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    
}




-(void)rightBarClick
{
    if (self.pswText.text == nil || self.pswText.text.length == 0)
    {
        [[AlertView sharedAlertView] addAlertMessage:@"请输入密码！" title:@"提示"];
        return;
    }
    
    if (self.repswText.text == nil || self.repswText.text.length == 0)
    {
        [[AlertView sharedAlertView] addAlertMessage:@"请输入确认密码！" title:@"提示"];
        return;
    }
    
    if (![self.pswText.text isEqualToString:self.repswText.text])
    {
        [[AlertView sharedAlertView] addAlertMessage:@"密码不一致，请核对！" title:@"提示"];
        return;
    }
    
   
    NSString *psw = [RSA encryptString:self.pswText.text publicKey:[UserInfo sharedUserInfo].publicKey];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"id"] = [UserInfo sharedUserInfo].userID;
    parmas[@"value"] = psw;
    
    
    NSString * url = [NSString stringWithFormat:@"%@resetvalueservlet",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"重置密码--json---%@",json);
        
    } failure:^(NSError *error)
    {
         YYLog(@"重置密码--error---%@",error);
        
    }];
    

}


@end
