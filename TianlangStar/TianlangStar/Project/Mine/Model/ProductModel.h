//
//  ProductModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/7.
//  Copyright © 2016年 yysj. All rights reserved.
//   商品和服务模型 -- 公用

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

/** 积分价格 */
@property (nonatomic,copy) NSString *scoreprice;

/** 商品的ID */
@property (nonatomic,copy) NSString *ID;

/** 商品的名称 */
@property (nonatomic,copy) NSString *productname;

/** 商品的类型 */
@property (nonatomic,copy) NSString *productmodel;

/** 商品的规格 */
@property (nonatomic,copy) NSString *specifications;

/** 商品的适用车型 */
@property (nonatomic,copy) NSString *applycar;

/** 商品的供应商 */
@property (nonatomic,copy) NSString *vendors;

/** 库存量 */
@property (nonatomic,copy) NSString *inventory;

/** 商品的进价 */
@property (nonatomic,copy) NSString *purchaseprice;

/** 商品的星币 */
//@property (nonatomic,copy) NSString *price;

/** 商品的积分 */
//@property (nonatomic,copy) NSString *scoreprice;

/** 商品的简介 */
@property (nonatomic,copy) NSString *introduction;

/** 商品的备注 */
@property (nonatomic,copy) NSString *remark;

/** 商品的图片地址 */
@property (nonatomic,copy) NSString *images;

/** 商品的价格 */
@property (nonatomic,copy) NSString *price;

/** 服务 */
@property (nonatomic,copy) NSString *services;

/**  */
/** 车牌号 */
@property (nonatomic,copy) NSString *carid;

/** 车的品牌 */
@property (nonatomic,copy) NSString *brand;

/** 车的类型 */
@property (nonatomic,copy) NSString *cartype;

/** 车的型号 */
@property (nonatomic,copy) NSString *model;

/** 购买年份 */
@property (nonatomic,copy) NSString *buytime;

/** 保险id */
@property (nonatomic,assign) NSInteger insuranceid;


@end





