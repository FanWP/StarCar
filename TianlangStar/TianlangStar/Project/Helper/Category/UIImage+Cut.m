//
//  UIImage+Cut.m
//  房地产-新旅行
//
//  Created by Beibei on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+Cut.h"

@implementation UIImage (Cut)

+ (instancetype)imageWithName:(NSString *)name
{
    // 加载图片
    UIImage *image = [UIImage imageNamed:name];
    // 获取图片尺寸
    CGSize size = image.size;
    // 开启位图上下文
    UIGraphicsBeginImageContext(size);
    // 创建圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    // 设置为裁剪区域
    [path addClip];
    // 绘制图片
    [image drawAtPoint:CGPointZero];
    // 获取裁剪后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 返回裁剪后的图片
    return newImage;
}

@end
