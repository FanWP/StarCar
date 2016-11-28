//
//  UIView+MyExtension.h
//  kztool
//
//  Created by 任帅 on 16/8/15.
//  Copyright © 2016年 任帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MyExtension)
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;

//在分类中声明@property，只会生成方法的声明，不会生成方法的实现和_成员变量
@end
