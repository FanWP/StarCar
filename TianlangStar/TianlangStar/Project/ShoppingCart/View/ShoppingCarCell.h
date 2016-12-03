//
//  ShoppingCarCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/3.
//  Copyright © 2016年 yysj. All rights reserved.
//  购物车单元格

#import <UIKit/UIKit.h>

@class ProductModel;
@interface ShoppingCarCell : UITableViewCell


/** 选中按钮的点击事件 */
@property (nonatomic,strong) UIButton *selectBtn;

/** 传入的商品模型 */
@property (nonatomic,strong) ProductModel *productModel;

+ (instancetype)cellWithtableView:(UITableView *)tableView;

@end
