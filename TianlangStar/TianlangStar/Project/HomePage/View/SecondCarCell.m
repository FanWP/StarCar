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
        CGFloat pictureViewWidth = 137;
        CGFloat pictureViewHeight = 97;
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(pictureViewX, pictureViewY, pictureViewWidth, pictureViewHeight)];
        [self.contentView addSubview:self.pictureView];
        
        
        
        CGFloat carNameLabelX = pictureViewX + pictureViewWidth + 12;
        CGFloat carNameLabelY = 8;
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
        
        
        
        
        CGFloat priceLabelY = buytimeLabelY + Klength20 + 5;
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(carNameLabelX, priceLabelY, 0.6 * carNameLabelWidth, Klength20)];
        [self.contentView addSubview:self.priceLabel];

        
        
        
        CGFloat chatButtonX = (carNameLabelX + 0.6 * carNameLabelWidth);
        self.chatButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.chatButton.frame = CGRectMake(chatButtonX, buytimeLabelY + Klength20, 0.4 * carNameLabelWidth, Klength30);
        self.chatButton.backgroundColor = [UIColor blueColor];
        [self.chatButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.chatButton.titleLabel setFont:Font14];
        self.chatButton.layer.cornerRadius = BtncornerRadius;
        [self.chatButton setTitle:@"立即咨询" forState:(UIControlStateNormal)];
//        [self.contentView addSubview:self.chatButton];
        
        
        
        
        self.carNameLabel.font = Font12;
        self.carTypeLabel.font = Font12;
        self.mileageLabel.font = Font12;
        self.buytimeLabel.font = Font12;
        self.priceLabel.font = Font13;
        
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
