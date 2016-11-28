//
//  UIImage+Tool.h
//  029-图片裁剪
//
//  Created by fwp on 16/2/17.
//  Copyright © 2016年 fwp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Tool)

/** 图片裁剪（生成一个带圆环的图片）name是图片的名称 border是圆环的宽度 color是圆环的颜色 */
+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border bordercolor:(UIColor *)color;


//图片截图  view指的是需要截屏的视图
+ (instancetype)imageWithCaptureView:(UIView *)view;

@end
