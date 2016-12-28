//
//  ProductCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGFloat pictureViewX = Klength10;
        CGFloat pictureViewY = Klength5;
        CGFloat pictureViewWidth = 0.4 * KScreenWidth;
        CGFloat pictureViewHeight = 0.7 * pictureViewWidth;
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(pictureViewX, pictureViewY, pictureViewWidth, pictureViewHeight)];
        [self.contentView addSubview:self.pictureView];
        
        
        
        CGFloat productNameLabelX = pictureViewX + pictureViewWidth + Klength10;
        CGFloat productNameLabelY = (pictureViewHeight + 2 * pictureViewY) / 2 - Klength30 / 2 - Klength30;
        CGFloat productNameLabelWidth = KScreenWidth - 2 * pictureViewX - Klength10;
        CGFloat productNameLabelHeight = Klength30;
        self.productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(productNameLabelX, productNameLabelY, productNameLabelWidth, productNameLabelHeight)];
        [self.contentView addSubview:self.productNameLabel];
        
        
        
        CGFloat priceLabelY = productNameLabelY + productNameLabelHeight;
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productNameLabelX, priceLabelY, productNameLabelWidth, productNameLabelHeight)];
        [self.contentView addSubview:self.priceLabel];
        
        
        
        CGFloat purchaseButtonY = priceLabelY + productNameLabelHeight;
        self.purchaseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.purchaseButton.frame = CGRectMake(productNameLabelX, purchaseButtonY, productNameLabelWidth, productNameLabelHeight);
        [self.purchaseButton setTitle:@"立即购买" forState:(UIControlStateNormal)];
        [self.purchaseButton addTarget:self action:@selector(purchaseAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:self.purchaseButton];
    }
    
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
