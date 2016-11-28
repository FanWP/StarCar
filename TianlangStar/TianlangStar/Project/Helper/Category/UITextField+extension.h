//
//  UITextField+extension.h
//  地产
//
//  Created by fwp on 16/6/27.
//  Copyright © 2016年 xinlvxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (extension)
/**
 *  添加提示框
 *  @param alert   控制器
 *  @param message 提示信息
 *  @param title   标题
 */
-(void)addAlert:(UIAlertController *)alert addMessage:(NSString *)message title:(NSString *)title UIAlertController:(UIViewController *)vc;
@end
