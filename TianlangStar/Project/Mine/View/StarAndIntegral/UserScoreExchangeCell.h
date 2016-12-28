//
//  UserScoreExchangeCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ProductModel;
@interface UserScoreExchangeCell : UITableViewCell


/** 出入的订单模型 */
@property (nonatomic,strong) ProductModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
