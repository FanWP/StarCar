//
//  BuyingSuccessDetailmodel.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/6.
//  Copyright © 2016年 yysj. All rights reserved.
//  购物车列表详情

#import <Foundation/Foundation.h>

@interface BuyingSuccessDetailmodel : NSObject


/*
 {
	totalPrice = 154,
	resultCode = 1000,
	orderList = [
 {
	saleId = 148100580825156869,
	discountPrice = 38,
	price = 96,
	count = 2,
	discount = 0,
	currenttime = 1481005807913,
	proName = 玻璃水,
	payee = 天狼星汽车服务有限公司,
	realPrice = 154
 }
 */

/** 订单号 */
@property (nonatomic,copy) NSString *saleId;

/** 折扣价格 */
@property (nonatomic,copy) NSString *discountPrice;

/** 价格 */
@property (nonatomic,copy) NSString *price;
/** 数量 */
@property (nonatomic,copy) NSString *count;
/** 折扣 */
@property (nonatomic,copy) NSString *discount;


@property (nonatomic,copy) NSString *currenttime;
/** 时间 */
@property (nonatomic,copy) NSString *productname;
/** 收款方 */
@property (nonatomic,copy) NSString *payee;

/** 付款价格 */
@property (nonatomic,assign) NSInteger realPrice;



@end
