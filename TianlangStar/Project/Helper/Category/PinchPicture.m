//
//  PinchPicture.m
//  悠游四季_房地产
//
//  Created by Beibei on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//


#import "PinchPicture.h"

static CGRect oldFrame;
UIScrollView * scrollView;

@implementation PinchPicture

+ (void)showBigImageView:(UIImageView *)currentImageView
{
//    currentImageView.userInteractionEnabled = YES;
//    
//    UIImage *image = currentImageView.image;
//    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    
//    scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    scrollView.contentSize = CGSizeMake(1.5 * scrollView.width, 1.5 * scrollView.height);
//
//    scrollView.backgroundColor = [UIColor blackColor];
//    scrollView.alpha = 0;
//    scrollView.delegate = self;
//    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.zoomScale = 1;
//    scrollView.minimumZoomScale = 1;
//    scrollView.maximumZoomScale = 1.5;
//    
//    oldFrame = [currentImageView convertRect:currentImageView.bounds toView:window];
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldFrame];
//    imageView.center = CGPointMake(kWidth / 2, kHeight / 2);
//    imageView.userInteractionEnabled = YES;
//    
//    imageView.image = image;
//    imageView.tag = 0;
//    [scrollView addSubview:imageView];
//    [window addSubview:scrollView];
//    
//    [UIView animateWithDuration:0.4 animations:^{
//        
//        CGFloat y,width,height;
//        
//        if (kWidth >= 375) {
//            
//            y = (kHeight - image.size.height * kWidth / image.size.width) * 0.3 + 24;
//        }
//        else
//        {
//            y = (kHeight - image.size.height * kWidth / image.size.width) * 0.3;
//        }
//        
//        width = kWidth;
//        
//        height = image.size.height * kWidth / image.size.width;
//        
//        NSLog(@"之后的高：%.f",height);
//        
//        imageView.frame = CGRectMake(0, y, width, height);
//        
//        scrollView.alpha = 1;
//    }];
//    
//    /** 点击隐藏图片返回 */
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
//    [scrollView addGestureRecognizer:tap];
//    
//    
//    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImage:)];
//    [imageView addGestureRecognizer:pinch];
    
}



+ (void)hideImageView:(UITapGestureRecognizer *)tap
{
    UIView *backgroundView = tap.view;
    
    UIImageView *imageView = [tap.view viewWithTag:0];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        imageView.frame = oldFrame;
        
        backgroundView.alpha = 0;
        
        //        backgroundView.backgroundColor = [UIColor whiteColor];
        
    } completion:^(BOOL finished) {
        
        [backgroundView removeFromSuperview];
    }];
    
}


+ (void)pinchImage:(UIPinchGestureRecognizer *)pinch
{
//    UIImageView *imageview = (UIImageView *) pinch.view;
//    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
//    CGFloat width,height,y;
//    y = (kHeight - imageview.size.height * kWidth / imageview.size.width) * 0.3;
//    width = imageview.width;
//    height = imageview.height;
//    scrollView.contentSize = imageview.size;
//    imageview.frame = CGRectMake(0, y, width, height);
    
    //    imageview.size = CGSizeMake(width, he、ight);
    //    imageview.width = width;
    //    imageview.height = height;
    
//    pinch.scale = 1.0;
}



+ (void)pinchTapImage:(UIPinchGestureRecognizer *)pinchTap
{
//    pinchTap.view.transform = CGAffineTransformScale(pinchTap.view.transform, 1.5, 1.5);
//    pinchTap.scale = 1.0;
}


@end





















