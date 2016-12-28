//
//  InputCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//  左边是；lable 右边是输入框

#import <UIKit/UIKit.h>

@interface InputCell : UITableViewCell

/** 输入框textField */
@property (nonatomic,weak) UITextField *textField;

/** 左边的文本框 */
@property (nonatomic,weak) UILabel *leftLB;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
