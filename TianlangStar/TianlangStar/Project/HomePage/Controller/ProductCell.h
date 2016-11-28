//
//  ProductCell.h
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell

// 图片
@property (nonatomic,strong) UIImageView *pictureView;
// 商品名称
@property (nonatomic,strong) UILabel *productNameLabel;
// 商品价格
@property (nonatomic,strong) UILabel *priceLabel;
// 立即购买
@property (nonatomic,strong) UIButton *purchaseButton;

@end
