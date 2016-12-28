//
//  ILSettingCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ILSettingItem;

@interface ILSettingCell : UITableViewCell

@property (nonatomic, strong) ILSettingItem *item;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
