//
//  BuyingSuccessListModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/6.
//  Copyright © 2016年 yysj. All rights reserved.
//  购买商品成功的时候返回的列表

#import <Foundation/Foundation.h>
@class BuyProductDetails;
@interface BuyingSuccessListModel : NSObject

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
 }]
 */

/** 总价格 */
@property (nonatomic,copy) NSString *totalPrice;
/** 购买时间 */
@property (nonatomic,copy) NSString *buytime;
/** 折扣 */
@property (nonatomic,copy) NSString *discount;
/** 收款方 */
@property (nonatomic,copy) NSString *payee;
/** 余额 */
@property (nonatomic,copy) NSString *balance;
/** 详细信息 */
@property (nonatomic,strong) NSArray *orderList;

@end
/*
 
 2016-12-07 14:52:43.667 TianlangStar[4275:1918112] {
	buytime = 1481093567581,
	totalPrice = 231,
	discount = 0.7,
	resultCode = 1000,
	payee = 天狼星汽车服务有限公司,
	orderList = [
 {
	saleId = 148109356759759420,
	discountPrice = 99,
	price = 330,
	count = 1,
	discount = 0,
	currenttime = 1481093567581,
	productname = 机油iloveyou,
	realPrice = 231
 }
 ],
	balance = 109648
 }

 */
