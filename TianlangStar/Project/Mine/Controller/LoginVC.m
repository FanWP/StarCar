//
//  LoginVC.m
//  房地产项目
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//


/********** 登录 **********/




#import "LoginVC.h"
#import "LoginView.h"

@interface LoginVC ()<LoginViewDelegate>

@end

@implementation LoginVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    
    LoginView *logView = [[LoginView alloc] initWithFrame:self.view.bounds];
    logView.delegate = self;
    [self.view addSubview:logView];
}

/**
 *  登录成功后调用的代理
 */
-(void)loginSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}





@end
