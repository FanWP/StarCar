//
//  UserCommonView.m
//  TianlangStar
//
//  Created by Beibei on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "UserCommonView.h"
#import "AdminInfoTVC.h"
#import "GeneralUserInfoTVC.h"

@interface UserCommonView()

/** 导航控制器 */
@property (nonatomic,strong) UINavigationController *nav;

// 积分数量
@property (nonatomic,strong) UIButton *scoreCountButton;

// 星币数量
@property (nonatomic,strong) UIButton *moneyCountButton;

// 线
@property (nonatomic,strong) UIView *lineView;

@end


@implementation UserCommonView


-(UINavigationController *)nav
{
    if (!_nav)
    {
        UITabBarController *tableBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        _nav = (UINavigationController *)tableBar.selectedViewController;
        
    }
    return _nav;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, KScreenWidth, 140)];
        headView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headView];
        
        
        UIView *userView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 86)];
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editInfoAction)];
        [userView addGestureRecognizer:tap];
        [headView addSubview:userView];
        //图像
        CGFloat headerPicWidth = 64;
        CGFloat headerPicX = 16;
        CGFloat headerPicY = 11;
        self.headerPic = [[UIImageView alloc] initWithFrame:CGRectMake(headerPicX, headerPicY, headerPicWidth, headerPicWidth)];
        
        self.headerPic.layer.cornerRadius = 32;
        self.headerPic.layer.masksToBounds = YES;
        
        self.headerPic.userInteractionEnabled = YES;
        [userView addSubview:self.headerPic];
        
        
        //用户昵称
        CGFloat userNameLabelHeight = 30;
        CGFloat userNameLabelX = CGRectGetMaxX(self.headerPic.frame) + 16;
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameLabelX, 20, KScreenWidth * 0.4, userNameLabelHeight)];
        self.userNameLabel.centerY = self.self.headerPic.centerY;
        self.userNameLabel.textAlignment = NSTextAlignmentLeft;
        self.userNameLabel.font = Font16;
        [userView addSubview:self.userNameLabel];
        
        
        //老板。店长，或者普通用户
        self.gradeLabel = [[UILabel alloc] init];
        self.gradeLabel.x = KScreenWidth - 35 - 40;
        self.gradeLabel.width = 40;
        self.gradeLabel.height = 16;
        self.gradeLabel.centerY = self.headerPic.centerY;
        
        self.gradeLabel.layer.cornerRadius = 5;
        self.gradeLabel.clipsToBounds = YES;
        
        self.gradeLabel.textAlignment = NSTextAlignmentCenter;
        self.gradeLabel.backgroundColor = Tintcolor;
        self.gradeLabel.textColor = [UIColor whiteColor];
        [userView addSubview:self.gradeLabel];
        
        //箭头
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrows"]];
        imgView.x = KScreenWidth - 16 - imgView.width;
        imgView.centerY = self.headerPic.centerY;
        [userView addSubview:imgView];
        
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(12, 86, KScreenWidth - 24, 1)];
        self.lineView.backgroundColor = BGcolor;
        [headView addSubview:self.lineView];
        
        
        //星币
        self.moneyButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.moneyButton setTitle:@"1222" forState:(UIControlStateNormal)];
        [self.moneyButton addTarget:self action:@selector(moneyButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.moneyButton.titleLabel.font = Font13;
        self.moneyButton.frame = CGRectMake(108, CGRectGetMaxY(self.lineView.frame) + 1, 60, 25);
        
        [headView addSubview:self.moneyButton];
        
        
        self.moneyCountButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.moneyCountButton setTitle:@"星币" forState:UIControlStateNormal];
        [self.moneyCountButton addTarget:self action:@selector(moneyButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.moneyCountButton.titleLabel.font = Font13;
        self.moneyCountButton.frame = CGRectMake(108, CGRectGetMaxY(self.moneyButton.frame) + 1, 60, 25);
        [headView addSubview:self.moneyCountButton];
        
        
        self.scoreButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.scoreButton setTitle:@"2122" forState:(UIControlStateNormal)];
        [self.scoreButton addTarget:self action:@selector(scoreButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.scoreButton.titleLabel.font = Font13;
        self.scoreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.scoreButton.frame =  CGRectMake(KScreenWidth - 108 - self.moneyButton.width, self.moneyButton.y, self.moneyButton.width, self.moneyButton.height);
        [headView addSubview:self.scoreButton];
        
        
        
        
        self.scoreCountButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.scoreCountButton setTitle:@"积分" forState:(UIControlStateNormal)];
        [self.scoreCountButton addTarget:self action:@selector(scoreButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.scoreCountButton.titleLabel.font = Font13;
        self.scoreCountButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.scoreCountButton.frame = CGRectMake(self.scoreButton.x, self.moneyCountButton.y, self.moneyButton.width, self.moneyButton.height);
        [headView addSubview:self.scoreCountButton];
        
        
        
        
        
        [self.moneyButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.moneyCountButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.scoreButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.scoreCountButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        
        
        self.headerPic.image = [UIImage imageNamed:@"touxiang"];
        self.userNameLabel.text = @"用户名";
        self.gradeLabel.text = @"老板";
        self.gradeLabel.font = Font14;

    }
    
    return self;
}



- (void)moneyButtonAction
{
    YYLog(@"星币");
}



- (void)scoreButtonAction
{
    YYLog(@"积分");
}



-(void)editInfoAction
{
    
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    if (userInfo.userType == 1 || userInfo.userType == 0)//老板
    {
        AdminInfoTVC *vc = [[AdminInfoTVC alloc] initWithStyle:UITableViewStyleGrouped];
        [self.nav pushViewController:vc animated:YES];
        
    }else if (userInfo.userType == 2)//普通用户
    {
        GeneralUserInfoTVC *vc = [[GeneralUserInfoTVC alloc] initWithStyle:UITableViewStyleGrouped];
        [self.nav pushViewController:vc animated:YES];
    }
    
}




@end
