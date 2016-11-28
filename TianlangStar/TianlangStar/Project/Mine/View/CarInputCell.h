//
//  CarInputCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/4.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInputCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView;


/** 单元格左侧的描述 */
@property (nonatomic,strong) UITextField *textField;

@end
