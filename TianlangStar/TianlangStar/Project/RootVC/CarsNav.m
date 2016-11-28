//
//  CarsNav.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CarsNav.h"

@interface CarsNav ()

@end

@implementation CarsNav



+(void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundColor:[UIColor blueColor]];
    [bar setBarTintColor:XLXcolor(25, 125, 290)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{    
    if (self.viewControllers.count > 0)
    {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
//        [button setTitle:@"返回" forState:UIControlStateNormal];
//                button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.size = CGSizeMake(70, 30);
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
//                button.backgroundColor = [UIColor grayColor];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    

    [super pushViewController:viewController animated:animated];
}


- (void)back
{
    [self popViewControllerAnimated:YES];
}





@end
