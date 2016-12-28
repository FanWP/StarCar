//
//  TBFooterDateView.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "TBFooterDateView.h"

@interface TBFooterDateView ()

@end

@implementation TBFooterDateView


-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        //分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(22, 0, KScreenWidth - 44, 1)];
        line.backgroundColor = BGcolor;
        [self addSubview:line];
        
        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, KScreenWidth, 24)];
        date.textAlignment = NSTextAlignmentCenter;
        date.backgroundColor = [UIColor whiteColor];
        date.font = Font12;
        date.textColor = lableTextcolor;
        self.date = date;
        [self addSubview:date];
    }
    return self;
}

+(instancetype)footer
{
    
    TBFooterDateView *view = [[TBFooterDateView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 25)];

    return view;
}




@end
