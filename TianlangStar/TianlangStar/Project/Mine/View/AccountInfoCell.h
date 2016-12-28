//
//  AccountInfoCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//  会员信息管理列表单元格

#import <UIKit/UIKit.h>



@class UserModel;

@interface AccountInfoCell : UITableViewCell

/** 用户名 */
@property (nonatomic,weak) UILabel *name;
/** 用户等级 */
@property (nonatomic,weak) UILabel *viplevel;
/** 注册时间 */
@property (nonatomic,weak) UILabel *lasttime;
/** 时分秒 */
@property (nonatomic,weak) UILabel *time;


/** 传入的模型数据 */
@property (nonatomic,strong) UserModel *userModel;

//快速创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
