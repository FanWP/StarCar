//
//  BossStarRecordCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>


@class OrderModel;
@interface BossStarRecordCell : UITableViewCell

/** 快速创建cell */
+(instancetype)cellWithTableView:(UITableView *)tableView;

/** 出入的订单模型 */
@property (nonatomic,strong) OrderModel *orderModel;

@end
