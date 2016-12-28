//
//  TBHeadersSucceedView.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/2.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "TBHeadersSucceedView.h"

@implementation TBHeadersSucceedView


-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, KScreenWidth, 44)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor redColor];
        lable.font = Font18;
        self.successfulLB = lable;
        lable.text = @"付款成功!";
        lable.backgroundColor = [UIColor whiteColor];
        [self addSubview:lable];
        
    }
    return self;
}


+(instancetype)SuccessfulTrade
{
    TBHeadersSucceedView *view = [[self alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 51)];

    return view;

}

@end
