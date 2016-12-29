//
//  BossRechargeStarOrScoreCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/28.
//  Copyright © 2016年 yysj. All rights reserved.
//  老板查询积分或者或者星币的历史记录的cell

#import <UIKit/UIKit.h>


@class VirtualcenterModel;
@interface BossRechargeScoreCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;


/** 标记是积分还是星币的充值记录 */
@property (nonatomic,assign) NSInteger rechargeType;

/** 传入模型数据 */
@property (nonatomic,strong) VirtualcenterModel *virtualcenterModel;

@end
