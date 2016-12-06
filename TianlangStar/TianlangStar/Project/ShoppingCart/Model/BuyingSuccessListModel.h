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

/** 详细信息 */
@property (nonatomic,strong) NSArray *orderList;

@end
