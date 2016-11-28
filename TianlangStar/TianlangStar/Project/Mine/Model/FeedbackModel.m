//
//  FeedbackModel.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "FeedbackModel.h"

@implementation FeedbackModel



+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"ID" : @"id" };
}


-(NSString *)lasttime
{
    NSTimeInterval _interval = [_lasttime doubleValue] / 1000;
    NSDate *data = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    return [formatter stringFromDate:data];
}


-(CGFloat)textH
{
    if (!_textH)
    {
        CGSize maxsize = CGSizeMake(KScreenWidth - 36, MAXFLOAT);
        
        //计算文字高度
        CGFloat textH = [self.content boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font12} context:nil].size.height;
        _textH = textH;
    }

    return _textH;
}

-(NSString *)content
{

    //设置首行空格
    return [NSString stringWithFormat:@"      %@",_content];
}






@end
