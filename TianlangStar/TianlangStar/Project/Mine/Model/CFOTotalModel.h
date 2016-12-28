//
//  CFOTotalModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/25.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFOTotalModel : NSObject

/** 总价格 */
@property (nonatomic,copy) NSString *totalPrice;

/** 总积分 */
@property (nonatomic,copy) NSString *totalScore;

/** 总个数 */
@property (nonatomic,copy) NSString *itemCount;


@end
