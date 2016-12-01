//
//  BuyProductDetails.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/30.
//  Copyright © 2016年 yysj. All rights reserved.
//  购买商品和积分兑换的详情

#import <UIKit/UIKit.h>


@class ProductModel;
@interface BuyProductDetails : UITableViewController

/** 传入的商品模型 */
@property (nonatomic,strong) ProductModel *model;

@end
