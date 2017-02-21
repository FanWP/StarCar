//
//  SecondCarCell.m
//  TianlangStar
//
//  Created by Beibei on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "SecondCarCell.h"

@implementation SecondCarCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {

        CGFloat pictureViewX = 7;
        CGFloat pictureViewY = 10;
        CGFloat pictureViewWidth = 0.4 * KScreenWidth;
        CGFloat pictureViewHeight = 0.75 * pictureViewWidth;
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(pictureViewX, pictureViewY, pictureViewWidth, pictureViewHeight)];
        self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
        self.pictureView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.pictureView];
        
        
        
        CGFloat carNameLabelX = pictureViewX + pictureViewWidth + 12;
        CGFloat carNameLabelY = 10;
        CGFloat carNameLabelWidth = KScreenWidth - carNameLabelX - pictureViewX;
        self.carNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(carNameLabelX, carNameLabelY, carNameLabelWidth, Klength20)];
        [self.contentView addSubview:self.carNameLabel];

        
        
        CGFloat carTypeLabelY = carNameLabelY + Klength20;
        self.carTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(carNameLabelX, carTypeLabelY, carNameLabelWidth, Klength20)];
        [self.contentView addSubview:self.carTypeLabel];
        
        
        
        CGFloat mileageLabelY = carTypeLabelY + Klength20;
        self.mileageLabel = [[UILabel alloc] initWithFrame:CGRectMake(carNameLabelX, mileageLabelY, carNameLabelWidth, Klength20)];
        [self.contentView addSubview:self.mileageLabel];
        
        
        
        CGFloat buytimeLabelY = mileageLabelY + Klength20;
        self.buytimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(carNameLabelX, buytimeLabelY, carNameLabelWidth, Klength20)];
        [self.contentView addSubview:self.buytimeLabel];
        
        
        
        CGFloat priceLabelY = buytimeLabelY + Klength20;
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(carNameLabelX, priceLabelY, carNameLabelWidth, Klength20)];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];
        
        
        
        self.carNameLabel.font = Font12;
        self.carTypeLabel.font = Font12;
        self.mileageLabel.font = Font12;
        self.buytimeLabel.font = Font12;
        self.priceLabel.font = Font14;
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
