//
//  CollectionCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGFloat productPicWidth = 0.2 * KScreenWidth;
        
        
        CGFloat selectButtonX = Klength15;
        CGFloat selectButtonWidth = 30;
        CGFloat selectButtonY = (2 * Klength5 + productPicWidth) / 2 - (selectButtonWidth / 2);
        self.selectButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.selectButton.frame = CGRectMake(Klength10, selectButtonY, selectButtonWidth, selectButtonWidth);
        
        
        
        CGFloat productPicX = selectButtonX + selectButtonWidth + Klength10;
        self.productPic = [[UIImageView alloc] initWithFrame:CGRectMake(productPicX, Klength5, productPicWidth, productPicWidth)];
        
        
        
        CGFloat width = KScreenWidth - 2 * Klength15 - selectButtonWidth - Klength10 - productPicWidth - Klength10;
        CGFloat productNameLabelX = productPicX + productPicWidth + Klength10;
        CGFloat productNameLabelY = (2 * Klength5 + productPicWidth) / 2 - (Klength30 / 2);
        CGFloat productNameLabelWidth = width / 2;
        self.productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(productNameLabelX, productNameLabelY, productNameLabelWidth, Klength30)];
        
        
        
        
        CGFloat productPriceLabelX = productNameLabelX + productNameLabelWidth;
        self.productPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPriceLabelX, productNameLabelY, productNameLabelWidth, Klength30)];
        
        
        
        [self.selectButton setImage:[UIImage imageNamed:@"select"] forState:(UIControlStateNormal)];
        [self.selectButton setImage:[UIImage imageNamed:@"selected"] forState:(UIControlStateSelected)];
        
        
        
        self.productPic.image = [UIImage imageNamed:@"touxiang"];
        self.productNameLabel.text = @"达耐尔机油";
        self.productPriceLabel.text = @"68星币";
        
        
        self.productNameLabel.textAlignment = NSTextAlignmentCenter;
        self.productPriceLabel.textAlignment = NSTextAlignmentCenter;
        
        
        [self.contentView addSubview:self.selectButton];
        [self.contentView addSubview:self.productPic];
        [self.contentView addSubview:self.productNameLabel];
        [self.contentView addSubview:self.productPriceLabel];
        
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
