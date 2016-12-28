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




+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetHeight:(CGFloat)targetHeight
{
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = (targetHeight / height) * width;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



+ (NSData *)compressImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length / 1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }
        else
        {
            lastData = dataKBytes;
        }
    }
    return data;
}



@end

















