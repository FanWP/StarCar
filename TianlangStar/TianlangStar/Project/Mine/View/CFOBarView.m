//
//  CFOBarView.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/24.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CFOBarView.h"

@implementation CFOBarView

-(instancetype)initWithFrame:(CGRect)frame
{

    if ([super initWithFrame:frame])
    
    {

        CGFloat marginX = 20;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.97];
        
        //产品名称
        UILabel *produce = [[UILabel alloc] init];
        produce.x = marginX;
        produce.y = 0;
        produce.width = KScreenWidth * 0.5 - 60 - 15 - 5 - marginX;
        produce.height = 40;
        produce.numberOfLines = 0;
        produce.font = Font14;
        produce.textAlignment = NSTextAlignmentCenter;
        produce.text = @"名称";
        
        
        //        produce.backgroundColor = [UIColor redColor];
        [self addSubview:produce];
        
        //金额
        UILabel *star = [[UILabel alloc] init];
        star.x = KScreenWidth * 0.5 - 65;
        star.width = 60;
        star.height = 30;
        star.centerY = produce.centerY;
        star.numberOfLines = 0;
        star.font = Font14;
        star.text = @"金额";
        [self addSubview:star];
        
        
        //数量
        UILabel *count = [[UILabel alloc] init];
        count.width = 30;
        count.height = 30;
        count.centerY = produce.centerY;
        count.centerX = KScreenWidth * 0.52;
        count.numberOfLines = 0;
        count.font = Font14;
        count.textAlignment = NSTextAlignmentCenter;
        count.text = @"数量";
        
        //        count.backgroundColor = [UIColor redColor];
        [self addSubview:count];
        
        
        //时间
        UILabel *time = [[UILabel alloc] init];
        time.width = 80;
        time.height = 80;
        time.centerY = produce.centerY;
        time.x = CGRectGetMaxX(count.frame) + 3;
        time.numberOfLines = 0;
        time.font = Font14;
        time.text = @"时间";
        time.textAlignment = NSTextAlignmentCenter;
        
        //        time.backgroundColor = [UIColor orangeColor];
        [self addSubview:time];
        
        
        //用户
        UILabel *userName = [[UILabel alloc] init];
        userName.width = KScreenWidth - CGRectGetMaxX(time.frame) - 10;
        userName.height = 30;
        userName.centerY = produce.centerY;
        userName.x = CGRectGetMaxX(time.frame) + 5;
        userName.numberOfLines = 0;
        userName.font = Font14;
        userName.text = @"用户";
        userName.textAlignment = NSTextAlignmentCenter;
        
//        userName.backgroundColor = [UIColor grayColor];
        [self addSubview:userName];
        self.backgroundColor = BGcolor;
    }
    
    return self;

}

@end
