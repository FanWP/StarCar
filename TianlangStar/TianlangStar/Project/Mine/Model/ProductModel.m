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
        introduction = @"";
    }else
    {
        introduction = _remark;
    }
    return introduction;
}


-(NSString *)introduction
{
    NSString *introduction = nil;
    if (_introduction == nil || _introduction.length == 0)
    {
        introduction = @"";
    }else
    {
        introduction = _introduction;
    }
    return introduction;

}

-(NSInteger)realPrice
{
    
    NSInteger price =  [self.price doubleValue];
    
    CGFloat  discount = [UserInfo sharedUserInfo].discount / 100;
    
    NSInteger total = ceil(price * discount * self.count);
    
    return total;
}


@end
