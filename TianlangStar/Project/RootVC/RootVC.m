//
//  RootVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootVC.h"
#import "HomePageTableVC.h"
#import "TLStarVC.h"
#import "ShoppingCartVC.h"
#import "MineVC.h"
#import "CarsNav.h"

@interface RootVC ()<UITabBarDelegate>

@end

@implementation RootVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTabBarController];// 给TabBarController添加4个子控制器
    
    [self setupAPPKEY];
}



#pragma mark - 给TabBarController添加4个子控制器

- (void)setTabBarController
{
    // 首页
    HomePageTableVC *homeVC = [[HomePageTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    CarsNav *homeNC = [[CarsNav alloc] initWithRootViewController:homeVC];
    [homeNC.tabBarItem setImage:[UIImage imageNamed:@"home"]];
    [homeNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"home2"]];
    [homeNC.tabBarItem setTitle:@"首页"];
    homeVC.title = @"首页";
    
    

    // 天狼星
    TLStarVC *tlStarVC = [[TLStarVC alloc] init];
    CarsNav *tlStarNC = [[CarsNav alloc] initWithRootViewController:tlStarVC];
    [tlStarNC.tabBarItem setImage:[UIImage imageNamed:@"company"]];
    [tlStarNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"company2"]];
    [tlStarNC.tabBarItem setTitle:@"天狼星"];
    tlStarVC.title = @"天狼星";
    
    
    
    // 购物车
    ShoppingCartVC *shoppingCartVC = [[ShoppingCartVC alloc] init];
    CarsNav *shoppingCartNC = [[CarsNav alloc] initWithRootViewController:shoppingCartVC];
    [shoppingCartNC.tabBarItem setImage:[UIImage imageNamed:@"shopping"]];
    [shoppingCartNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"shopping2"]];
    [shoppingCartNC.tabBarItem setTitle:@"购物车"];
    shoppingCartVC.title = @"购物车";
    
    
    
    // 我的
    MineVC *mineVC = [[MineVC alloc] init];
    CarsNav *mineNC = [[CarsNav alloc] initWithRootViewController:mineVC];
    [mineNC.tabBarItem setImage:[UIImage imageNamed:@"me"]];
    [mineNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"me2"]];
    [mineNC.tabBarItem setTitle:@"我的"];
    mineVC.title = @"我的";
    
    
    
    self.viewControllers = @[homeNC,tlStarNC,shoppingCartNC,mineNC];
//    self.tabBar.tintColor = [UIColor colorWithRed:0.993 green:0.673 blue:0.156 alpha:1.000];
    
//    homeVC.view.backgroundColor = [UIColor orangeColor];
    tlStarVC.view.backgroundColor = [UIColor orangeColor];
//    shoppingCartVC.view.backgroundColor = [UIColor orangeColor];
//    mineVC.view.backgroundColor = [UIColor orangeColor];
}




- (void)setupAPPKEY
{
#pragma mark - 第三方
    [UMSocialData setAppKey:@"584f99c25312ddbd6a0011b4"];
//
//    // 集成QQ开关
    [UMSocialQQHandler setQQWithAppId:@"1105808395" appKey:@"PEm1E3PdSWLOIOyX" url:@"http://www.umeng.com/social"];
//
//    // 集成新浪微博开关
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3916973439" secret:@"3445cd13de3de9201fd8cc9aca419574" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//
//    // 集成微信开关
    [UMSocialWechatHandler setWXAppId:@"wx14d4924c758a456b" appSecret:@"13c89352ac91d0cc27929facac0f1c2c" url:@"http://www.umeng.com/social"];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
