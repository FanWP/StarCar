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
        
        
        NSString *str = [NSString stringWithFormat:@"简介：%@",self.introduction];
        
        //计算文字的高度
        CGFloat TextH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font14} context:nil].size.height;

        _introductionH = TextH + 158 + 24;
    }
    return _introductionH;
}


-(NSString *)remark
{
    NSString *introduction = nil;
    if (_remark == nil || _remark.length == 0)
    {
        introduction = @"无";
    }else
    {
        introduction = _introduction;
    }
    return introduction;
}


-(NSString *)introduction
{
    NSString *introduction = nil;
    if (_introduction == nil || _introduction.length == 0)
    {
        introduction = @"无";
    }else
    {
        introduction = _introduction;
    }
    return introduction;

}

-(NSInteger)realPrice
{
    NSInteger price =  [self.price integerValue];
    
    CGFloat  discount = [UserInfo sharedUserInfo].discount / 100;
    
    CGFloat total = (price * discount + 0.5);
    
    NSString *price1 = [NSString stringWithFormat:@"%.f",total];

    NSInteger total1 = [price1 integerValue] * self.count;

    return total1;
    
}


@end
