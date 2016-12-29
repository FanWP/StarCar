//
//  DiscountHTTPHelper.m
//  TianlangStar
//
//  Created by Beibei on 16/12/29.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "DiscountHTTPHelper.h"


@implementation DiscountHTTPHelper

+ (DiscountHTTPHelper *)sharedManager
{
    static DiscountHTTPHelper *handle = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        handle = [[DiscountHTTPHelper alloc] init];
        
    });
    return handle;
}


- (void)fetchDiscountDataWithDiscountLabel:(UILabel *)discountLabel accountBalanceLabel:(UILabel *)accountBalanceLabel scoreLabel:(UILabel *)scoreLabel block:(DiscountBlock)block;
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/base/userInfo",URL];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"折扣信息账户余额返回：%@",responseObject);
         
         NSArray *dataArray = responseObject[@"body"];
         
         for (NSDictionary *dic in dataArray)
         {
             discountLabel.text = [dic objectForKey:@"discount"];
             accountBalanceLabel.text = [dic objectForKey:@"balance"];
             scoreLabel.text = [dic objectForKey:@"score"];
         }
         
         block();
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"折扣信息账户余额错误：%@",error);
     }];
}


@end
