//
//  AlertView.m
//  TianlangStar
//
//  Created by youyousiji on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AlertView.h"
#import "LoginVC.h"
#import "LoginView.h"

@interface AlertView ()

/** 当前界面的控制器 */
@property (nonatomic,strong) UIViewController *rootVC;

@property (nonatomic,strong) UIAlertController *alert;

@end

@implementation AlertView

singleton_implementation(AlertView);

#pragma mark====懒加载=====

-(UIViewController *)rootVC
{
    if (!_rootVC)
    {
        _rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return _rootVC;
}



/**
 *  跳转至登录界面
 */
- (void)jumpToLoginView
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    UITabBarController *tableBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tableBar.selectedViewController;
    [nav pushViewController:loginVC animated:YES];
}



/** 登录已过期提示先登录 */
- (void)loginAlertView
{

    self.alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录已过期，请重新登录！" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
       {
           [self jumpToLoginView];
       }];
    
    [self.alert addAction:cancleAction];
    [self.alert addAction:okAction];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:nil];
}



/**
 *  用户未登录提示用户登录
 */
- (void)loginAction
{
    self.alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
    {
        
        [self jumpToLoginView];
        
    }];
    
    [self.alert addAction:cancleAction];
    [self.alert addAction:okAction];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:nil];
}









-(void)addAlertMessage:(NSString *)message title:(NSString *)title
{
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [self.alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }]];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:^ {  }];
}



/**
 *  提示框延迟几秒消失
 *
 *  @param message 提示内容
 *  @param title   标题
 */
- (void)addAfterAlertMessage:(NSString *)message title:(NSString *)title
{
    
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}


/**
 *  取消和确定的两个提示框
 *
 *  @param message      提示的内容
 *  @param title        标题
 *  @param okAction     确定事件(事件在外部自定义)
 */
- (void)addAlertMessage:(NSString *)message title:(NSString *)title okAction:(UIAlertAction *)okAction
{
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [self.alert addAction:cancleAction];
    [self.alert addAction:okAction];
    [self.rootVC presentViewController:self.alert animated:YES completion:nil];
}



- (void)addAlertMessage:(NSString *)message title:(NSString *)title cancleAction:(UIAlertAction *)cancleAction okAction:(UIAlertAction *)okAction
{
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self.alert addAction:cancleAction];
    [self.alert addAction:okAction];
    [self.rootVC presentViewController:self.alert animated:YES completion:nil];
}



- (void)addAlertMessage:(NSString *)message title:(NSString *)title cancleAction:(UIAlertAction *)cancleAction photoLibraryAction:(UIAlertAction *)photoLibraryAction cameraAction:(UIAlertAction *)cameraAction
{
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    [self.alert addAction:photoLibraryAction];
    [self.alert addAction:cameraAction];
    [self.alert addAction:cancleAction];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:nil];
}


@end




























