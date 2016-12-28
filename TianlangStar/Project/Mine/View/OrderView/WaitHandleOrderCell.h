//
//  WaitHandleOrderCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//  待处理订单的cell

#import <UIKit/UIKit.h>

@class OrderModel;
@interface WaitHandleOrderCell : UITableViewCell

/** 出入的订单模型 */
@property (nonatomic,strong) OrderModel *orderModel;


@end
