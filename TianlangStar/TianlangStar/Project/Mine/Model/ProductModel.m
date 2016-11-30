//
//  ProductModel.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/7.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel




+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"ID" : @"id" };
}



-(CGFloat)introductionH
{
    if (!_introductionH)
    {
        CGSize maxSize = CGSizeMake(KScreenWidth - 32, MAXFLOAT);
        
        //计算文字的高度
        CGFloat TextH = [self.introduction boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font14} context:nil].size.height;

        _introductionH = TextH + 158;
    }
    return _introductionH;
}


@end
