//
//  AlertView.h
//  TianlangStar
//
//  Created by youyousiji on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertView : NSObject
singleton_interface(AlertView);

///** 快速创建一个提示 */
//+(instancetype)alert;

/** 登录已过期提示先登录 */
- (void)loginAlertView;



/**
 *  用户未登录提示用户登录
 */
- (void)loginAction;




/**
 *  @param message 提示信息
 *  @param title   标题
 */
- (void)addAlertMessage:(NSString *)message title:(NSString *)title;




/**
 *  提示框延迟几秒消失
 *
 *  @param message 提示内容
 *  @param title   标题
 */
- (void)addAfterAlertMessage:(NSString *)message title:(NSString *)title;

- (void)addAlertMessage:(NSString *)message title:(NSString *)title okAction:(UIAlertAction *)okAction;


- (void)addAlertMessage:(NSString *)message title:(NSString *)title cancleAction:(UIAlertAction *)cancleAction okAction:(UIAlertAction *)okAction;


- (void)addAlertMessage:(NSString *)message title:(NSString *)title cancleAction:(UIAlertAction *)cancleAction photoLibraryAction:(UIAlertAction *)photoLibraryAction cameraAction:(UIAlertAction *)cameraAction;


















-(BOOL)checkTextFieldHasNil :(UIViewController *)vc;


@end
