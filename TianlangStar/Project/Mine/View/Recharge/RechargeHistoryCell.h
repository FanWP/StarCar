//
//  RechargeHistoryCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/22.
//  Copyright © 2016年 yysj. All rights reserved.
//  充值记录的单元格

#import <UIKit/UIKit.h>


@class VirtualcenterModel;
@interface RechargeHistoryCell : UITableViewCell

/** 充值时间 */
@property (nonatomic,weak) UILabel *time;

/** 充值时间--时分秒 */
@property (nonatomic,weak) UILabel *lasettime;

/** 充值金额 */
@property (nonatomic,weak) UILabel *rechargLB;



/** 传入的cell模型数据 */
@property (nonatomic,strong) VirtualcenterModel *model;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
