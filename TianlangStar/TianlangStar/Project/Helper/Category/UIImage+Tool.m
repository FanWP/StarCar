//
//  UIImage+Tool.m
//  029-图片裁剪
//
//  Created by fwp on 16/2/17.
//  Copyright © 2016年 fwp. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage(Tool)

+(instancetype)imageWithCaptureView:(UIView *)view{

    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //渲染控制器view图层到上下文
    //图层只能用渲染，不能用draw
    [view.layer renderInContext:ctx];
    
    //获取截屏图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    return newImage;

}
+(instancetype)imageWithName:(NSString *)name border:(CGFloat)border bordercolor:(UIColor *)color{
    
    //圆1环的宽度
    CGFloat borderW = border;
    
    //1.加载旧的图片
    UIImage *oldimage = [UIImage imageNamed:name];
    
    //新的图片尺寸】
    CGFloat imageW = oldimage.size.width + 2*borderW;
    CGFloat imageH = oldimage.size.height + 2*borderW;
    
    //设置新的图片的尺寸
    CGFloat circirW = imageW >imageH ? imageH :imageW;
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circirW, circirW), NO, 0.0);
    
    //画大图
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circirW, circirW)];
    
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    //设置颜色
    [color set ];
    
    //渲染
    CGContextFillPath(ctx);
    
    CGRect clipR = CGRectMake(borderW, borderW, oldimage.size.width, oldimage.size.height);
    
    //画园：正切与旧图片的圆
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
    
    //设置裁剪区域
    [clipPath addClip];
    
    //画图片
    [oldimage drawAtPoint:CGPointMake(borderW, borderW)];
    
    //获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndPDFContext();
    
    return newImage;
    
    
}



@end












