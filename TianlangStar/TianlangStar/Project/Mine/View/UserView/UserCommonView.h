//
//  UserCommonView.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/29.
//  Copyright © 2016年 yysj. All rights reserved.
//  用户图像header


#import <UIKit/UIKit.h>

@interface UserCommonView : UIView

// 头像
@property (nonatomic,strong) UIImageView *headerPic;
// 用户名
@property (nonatomic,strong) UILabel *userNameLabel;
// 等级
@property (nonatomic,strong) UILabel *gradeLabel;
// 星币
@property (nonatomic,strong) UIButton *moneyButton;
// 积分
@property (nonatomic,strong) UIButton *scoreButton;


@end
