//
//  StorageManagementCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/27.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "StorageManagementCell.h"

@implementation StorageManagementCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGFloat top = 10;
        
        CGFloat height = 80;
        
        CGFloat selectButtonX = 15;
        CGFloat selectButtonWidth = Klength30;
        CGFloat selectButtonY = (height / 2) - (selectButtonWidth / 2);
        self.selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.selectButton.frame = CGRectMake(selectButtonX, selectButtonY, selectButtonWidth, selectButtonWidth);
        [self.selectButton setImage:[[UIImage imageNamed:@"unselected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        [self.selectButton setImage:[[UIImage imageNamed:@"selected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateSelected)];
        [self.contentView addSubview:self.selectButton];
        
        
        CGFloat labelHeight = 60;
        
        CGFloat nameLabelX = selectButtonX + selectButtonWidth + 30;
        
        CGFloat width = (KScreenWidth - nameLabelX - selectButtonX);
        
        CGFloat nameLabelWidth = 0.4 * width;
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, top, nameLabelWidth, labelHeight)];
        [self.contentView addSubview:self.nameLabel];
        
        
        
        CGFloat countLabelX = nameLabelX + nameLabelWidth;
        CGFloat countLabelWidth = 0.3 * width;
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(countLabelX, top, countLabelWidth, labelHeight)];
        self.countLabel.textAlignment = 1;
        [self.contentView addSubview:self.countLabel];
        
        
        
        CGFloat statusLabelX = countLabelX + countLabelWidth;
        CGFloat statusLabelWidth = 0.3 * width;
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(statusLabelX, top, statusLabelWidth, labelHeight)];
        self.statusLabel.textAlignment = 1;
        [self.contentView addSubview:self.statusLabel];
        
//        self.nameLabel.backgroundColor = [UIColor redColor];
//        self.countLabel.backgroundColor = [UIColor cyanColor];
//        self.statusLabel.backgroundColor = [UIColor orangeColor];
        
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
