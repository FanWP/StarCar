//
//  BossCFOCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/24.
//  Copyright © 2016年 yysj. All rights reserved.
//   财务统计的cell、

#import <UIKit/UIKit.h>


@class CFOModel;
@interface BossCFOCell : UITableViewCell


/** 快速创建cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 财务统计传入模型 */
@property (nonatomic,strong) CFOModel *cfoModel;



@end
