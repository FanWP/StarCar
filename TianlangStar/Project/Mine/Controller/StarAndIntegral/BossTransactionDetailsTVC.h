//
//  BossTransactionDetailsTVC.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//  积分详情  或者是 星币交易详情

#import <UIKit/UIKit.h>


@class OrderModel;
@interface BossTransactionDetailsTVC : UITableViewController

/** 传入的详情模型 */
@property (nonatomic,strong) OrderModel *OrderModel;

@end
