//
//  UserOrderQueryCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//  普通用户的订单查询

#import <UIKit/UIKit.h>



@class OrderModel;
@interface UserOrderQueryCell : UITableViewCell

/** 快读创建cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 传入的商品模型信息 */
@property (nonatomic,strong) OrderModel *orderModel;





@end
