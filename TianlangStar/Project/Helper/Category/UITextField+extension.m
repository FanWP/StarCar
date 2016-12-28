//
//  UITextField+extension.m
//  地产
//
//  Created by fwp on 16/6/27.
//  Copyright © 2016年 xinlvxing. All rights reserved.
//

#import "UITextField+extension.h"

@implementation UITextField (extension)

/**
 *  添加提示框
 *  @param alert   控制器
 *  @param message 提示信息
 *  @param title   标题
 */
-(void)addAlert:(UIAlertController *)alert addMessage:(NSString *)message title:(NSString *)title UIAlertController:(UIViewController *)vc{
    
    alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [vc presentViewController:alert animated:YES completion:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}


@end
