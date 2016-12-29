//
//  DiscountHTTPHelper.h
//  TianlangStar
//
//  Created by Beibei on 16/12/29.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DiscountBlock)();

@interface DiscountHTTPHelper : NSObject

+ (DiscountHTTPHelper *)sharedManager;
- (void)fetchDiscountDataWithDiscountLabel:(UILabel *)discountLabel accountBalanceLabel:(UILabel *)accountBalanceLabel scoreLabel:(UILabel *)scoreLabel block:(DiscountBlock)block;

@end
