//
//  RechargeRecoredCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/28.
//  Copyright © 2016年 yysj. All rights reserved.
//  客户端用户充值记录的查询cell

#import <UIKit/UIKit.h>


@class VirtualcenterModel;
@interface RechargeRecoredCell : UITableViewCell


/** 左边的lable */
@property (nonatomic,weak) UILabel *leftlable;

/** 右边的lable */
@property (nonatomic,weak) UILabel *rightlable;

/** 模型 */
@property (nonatomic,strong)VirtualcenterModel *rechargedModel;


+(instancetype)cellWithTableview:(UITableView *)tableView;


@end
