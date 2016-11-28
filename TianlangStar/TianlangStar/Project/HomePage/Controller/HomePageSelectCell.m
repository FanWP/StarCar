//
//  HomePageSelectCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "HomePageSelectCell.h"

@implementation HomePageSelectCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGFloat buttonWidth = KScreenWidth / 3;
        
        self.maintenanceButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.maintenanceButton.frame = CGRectMake(0, 0, buttonWidth, Klength44);
        [self.contentView addSubview:self.maintenanceButton];
        
        
        
        self.productButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.productButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, Klength44);
        [self.contentView addSubview:self.productButton];
        
        
        
        self.carInfoButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.carInfoButton.frame = CGRectMake(2 * buttonWidth, 0, buttonWidth, Klength44);
        [self.contentView addSubview:self.carInfoButton];
        
        
        
        [self.maintenanceButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.productButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.carInfoButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
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
