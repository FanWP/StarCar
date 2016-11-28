//
//  CFOModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/24.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFOModel : NSObject

/** 星币 */
@property (nonatomic,copy) NSString *amount;

/** 时间 */
@property (nonatomic,copy) NSString *time;

/** 数量 */
@property (nonatomic,copy) NSString *count;

/** 用户名 */
@property (nonatomic,copy) NSString *userName;

/** 产品 */
@property (nonatomic,copy) NSString *product;


/** 总积分 */
@property (nonatomic,copy) NSString *itemCount;

/** 总交星币 */
@property (nonatomic,copy) NSString *totalPrice;



@end
