//
//  MaintenanceAndProductCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/29.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "MaintenanceAndProductCell.h"

@implementation MaintenanceAndProductCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGFloat pictureViewX = 7;
        CGFloat pictureViewY = 10;
        CGFloat pictureViewWidth = 137;
        CGFloat pictureViewHeight = 97;
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(pictureViewX, pictureViewY, pictureViewWidth, pictureViewHeight)];
        [self.contentView addSubview:self.pictureView];
        
        
        
        CGFloat titleLabelX = pictureViewX + pictureViewWidth + 12;
        CGFloat titleLabelY = 8;
        CGFloat titleLabelWidth = KScreenWidth - titleLabelX - pictureViewX;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, Klength30)];
        [self.contentView addSubview:self.titleLabel];
        
        
        
        CGFloat detailLabelY = titleLabelY + 8;
        CGFloat detailLabelHeight = 50;
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, detailLabelY, titleLabelWidth, detailLabelHeight)];
        self.detailLabel.numberOfLines = 0;
        [self.contentView addSubview:self.detailLabel];
        
        
        
        CGFloat priceLabelY = detailLabelY + detailLabelHeight + 10;
        CGFloat priceLabelWidth = 0.6 * titleLabelWidth;
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, priceLabelY, priceLabelWidth, Klength30)];
        [self.contentView addSubview:self.priceLabel];
        
        
        
        CGFloat buyButtonX = titleLabelX + priceLabelWidth;
        CGFloat buyButtonY = detailLabelY + detailLabelHeight + 10;
        self.buyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.buyButton.frame = CGRectMake(buyButtonX, buyButtonY, 0.4 * titleLabelWidth, Klength30);
        self.buyButton.backgroundColor = [UIColor blueColor];
        self.buyButton.layer.cornerRadius = BtncornerRadius;
        [self.buyButton.titleLabel setFont:Font14];
        [self.buyButton setTitle:@"立即购买" forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.buyButton];
        
        
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.detailLabel.font = [UIFont systemFontOfSize:10];
        self.detailLabel.textColor = [UIColor colorWithRed:121.0 / 255.0 green:121.0 / 255.0 blue:121.0 / 255.0 alpha:1];
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
