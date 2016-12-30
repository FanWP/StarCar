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
        CGFloat pictureViewWidth = 0.4 * KScreenWidth;
        CGFloat pictureViewHeight = 97;
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(pictureViewX, pictureViewY, pictureViewWidth, pictureViewHeight)];
        self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
        self.pictureView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.pictureView];
        
        
        
        CGFloat titleLabelX = pictureViewX + pictureViewWidth + 12;
        CGFloat titleLabelY = 8;
        CGFloat titleLabelWidth = KScreenWidth - titleLabelX - pictureViewX;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, Klength30)];
        [self.contentView addSubview:self.titleLabel];
        
        
        
        CGFloat detailLabelY = titleLabelY + Klength30;
        CGFloat detailLabelHeight = 40;
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, detailLabelY, titleLabelWidth, detailLabelHeight)];
        self.detailLabel.numberOfLines = 0;
        [self.contentView addSubview:self.detailLabel];
        
        
        
        CGFloat priceLabelY = detailLabelY + detailLabelHeight;
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, priceLabelY, titleLabelWidth, Klength30)];
        self.priceLabel.font = Font15;
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];
        
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.detailLabel.font = [UIFont systemFontOfSize:12];
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
