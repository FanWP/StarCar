//
//  CollectionCell.h
//  TianlangStar
//
//  Created by Beibei on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UITableViewCell

@property (nonatomic,strong) UIButton *selectButton;// 复选框
@property (nonatomic,strong) UIImageView *productPic;// 收藏物图片
@property (nonatomic,strong) UILabel *productNameLabel;// 收藏物名称
@property (nonatomic,strong) UILabel *productPriceLabel;// 收藏物价格

@end
