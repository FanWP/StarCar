//
//  BuyProductDetailsCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/30.
//  Copyright © 2016年 yysj. All rights reserved.
//  购买商品和积分兑换的详情单元格

#import <UIKit/UIKit.h>


@class ProductModel;
@interface BuyProductDetailsCell : UITableViewCell

/** 传如的商品模型 */
@property (nonatomic,strong) ProductModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
