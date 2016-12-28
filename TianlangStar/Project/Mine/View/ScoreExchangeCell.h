//
//  ScoreExchangeCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/28.
//  Copyright © 2016年 yysj. All rights reserved.
//  积分兑换的cell

#import <UIKit/UIKit.h>

@class ProductModel;
@interface ScoreExchangeCell : UITableViewCell


/** 传入的积分模型 */
@property (nonatomic,strong) ProductModel *model;


+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
