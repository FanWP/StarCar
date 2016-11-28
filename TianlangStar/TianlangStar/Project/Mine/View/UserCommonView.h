//
//  UserCommonView.h
//  TianlangStar
//
//  Created by Beibei on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCommonView : UIView

// 头像
@property (nonatomic,strong) UIImageView *headerPic;
// 用户名
@property (nonatomic,strong) UILabel *userNameLabel;
// 等级
@property (nonatomic,strong) UILabel *gradeLabel;
// 线
@property (nonatomic,strong) UIView *lineView;
// 今日交易
@property (nonatomic,strong) UILabel *todayTransactionLabel;
// 星币
@property (nonatomic,strong) UIButton *moneyButton;
// 星币数量
@property (nonatomic,strong) UIButton *moneyCountButton;
// 积分
@property (nonatomic,strong) UIButton *scoreButton;
// 积分数量
@property (nonatomic,strong) UIButton *scoreCountButton;

@end
