//
//  BuyingSuccessCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/6.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>



@class BuyingSuccessDetailmodel;
@interface BuyingSuccessCell : UITableViewCell

/** 购买成功的模型 */
@property (nonatomic,strong) BuyingSuccessDetailmodel *model;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
