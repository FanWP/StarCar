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
        CGFloat headerPicWidth = 0.23 * KScreenWidth;
        CGFloat headerPicX = (KScreenWidth / 2) - (headerPicWidth / 2);
        CGFloat headerPicY = Klength20;
        CGFloat headerPicHeight = headerPicWidth;
        self.headerPic = [[UIImageView alloc] initWithFrame:CGRectMake(headerPicX, headerPicY, headerPicWidth, headerPicHeight)];
        self.headerPic.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editInfoAction)];
        [self.headerPic addGestureRecognizer:tap];
        [self addSubview:self.headerPic];
        
        
        
        CGFloat userNameLabelHeight = Klength30;
        CGFloat userNameLabelY = headerPicY + headerPicHeight + Klength10;
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, userNameLabelY, KScreenWidth, userNameLabelHeight)];
        self.userNameLabel.textAlignment = NSTextAlignmentCenter;
        self.userNameLabel.font = Font16;
        [self addSubview:self.userNameLabel];
        
        
        
        CGFloat gradeLabelX = headerPicX + 0.75 * headerPicWidth;
        CGFloat gradeLabelY = headerPicY + 0.75 * headerPicWidth;
        CGFloat gradeLabelWidth = 40;
        CGFloat gradeLabelHeight = 23;
        self.gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(gradeLabelX, gradeLabelY, gradeLabelWidth, gradeLabelHeight)];
        self.gradeLabel.textAlignment = NSTextAlignmentCenter;
        self.gradeLabel.backgroundColor = [UIColor blueColor];
        self.gradeLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.gradeLabel];
        
        
        
        self.moneyButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.moneyButton setTitle:@"星币" forState:(UIControlStateNormal)];
        [self.moneyButton addTarget:self action:@selector(moneyButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.moneyButton];
        
        
        self.moneyCountButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.moneyCountButton addTarget:self action:@selector(moneyButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.moneyCountButton];
        
        
        self.scoreButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.scoreButton setTitle:@"积分" forState:(UIControlStateNormal)];
        [self.scoreButton addTarget:self action:@selector(scoreButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.scoreButton];
        
        
        self.scoreCountButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.scoreCountButton addTarget:self action:@selector(scoreButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.scoreCountButton];

        
        
        CGFloat halfWidth = KScreenWidth / 2;
        CGFloat buttonWidth = 60;
        CGFloat buttonHeight = Klength30;
        CGFloat moneyButtonX = (halfWidth / 2) - (buttonWidth / 2);
        CGFloat scoreButtonX = halfWidth + (halfWidth / 2) - (buttonWidth / 2);
        
        
        
        if ([UserInfo sharedUserInfo].userType == 1)
        {
            CGFloat lineViewY = userNameLabelY + userNameLabelHeight + Klength5;
            self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineViewY, KScreenWidth, 0.5)];
            self.lineView.backgroundColor = [UIColor grayColor];
            [self addSubview:self.lineView];
            
            
            
            CGFloat todayTransactionLabelX = Klength15;
            CGFloat todayTransactionLabelY = userNameLabelY + userNameLabelHeight + Klength10;
            CGFloat todayTransactionLabelWidth = KScreenWidth - 2 * Klength15;
            CGFloat todayTransactionLabelHeight = Klength30;
            self.todayTransactionLabel = [[UILabel alloc] initWithFrame:CGRectMake(todayTransactionLabelX, todayTransactionLabelY, todayTransactionLabelWidth, todayTransactionLabelHeight)];
            self.todayTransactionLabel.text = @"今日交易";
            self.todayTransactionLabel.font = Font18;
            [self addSubview:self.todayTransactionLabel];
            
            
            
            CGFloat moneyButtonY = todayTransactionLabelY + todayTransactionLabelHeight + Klength5;
            self.moneyButton.frame = CGRectMake(moneyButtonX, moneyButtonY, buttonWidth, buttonHeight);
            
            CGFloat moneyCountButtonY = moneyButtonY + buttonHeight;
            self.moneyCountButton.frame = CGRectMake(moneyButtonX, moneyCountButtonY, buttonWidth, buttonHeight);
            
            self.scoreButton.frame = CGRectMake(scoreButtonX, moneyButtonY, buttonWidth, buttonHeight);
            
            self.scoreCountButton.frame = CGRectMake(scoreButtonX, moneyCountButtonY, buttonWidth, buttonHeight);
            
        }
        if ([UserInfo sharedUserInfo].userType == 2)
        {
            CGFloat moneyButtonY = userNameLabelY + userNameLabelHeight + Klength10;
            self.moneyButton.frame = CGRectMake(moneyButtonX, moneyButtonY, buttonWidth, buttonHeight);
            
            CGFloat moneyCountButtonY = moneyButtonY + buttonHeight;
            self.moneyCountButton.frame = CGRectMake(moneyButtonX, moneyCountButtonY, buttonWidth, buttonHeight);
            
            self.scoreButton.frame = CGRectMake(scoreButtonX, moneyButtonY, buttonWidth, buttonHeight);
            
            self.scoreCountButton.frame = CGRectMake(scoreButtonX, moneyCountButtonY, buttonWidth, buttonHeight);
        }
        
        
        
        [self.moneyButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.moneyCountButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.scoreButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.scoreCountButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        
        
        self.headerPic.image = [UIImage imageNamed:@"touxiang"];
        self.userNameLabel.text = @"用户名";
        self.gradeLabel.text = @"老板";
        self.gradeLabel.font = Font14;
        [self.moneyCountButton setTitle:@"7860" forState:(UIControlStateNormal)];
        [self.scoreCountButton setTitle:@"3786" forState:(UIControlStateNormal)];
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
