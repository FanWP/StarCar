//
//  HomePageSelectCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#define Kle 40

#import "HomePageSelectCell.h"
#import "TopPicBottomLabelButton.h"

@implementation HomePageSelectCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGFloat top = 10;
        
        CGFloat buttonWidth = 40;
        CGFloat buttonHeight = buttonWidth + Klength30;
        CGFloat buttonHor = (KScreenWidth - 2 * Kle - 3 * buttonWidth) / 2;
        self.maintenanceButton = [[TopPicBottomLabelButton alloc] initWithFrame:CGRectMake(Kle, top, buttonWidth, buttonHeight)];
        [self.maintenanceButton setImage:[UIImage imageNamed:@"maintain"] forState:(UIControlStateNormal)];
//        [self.maintenanceButton setImage:[UIImage imageNamed:@"maintain2"] forState:(UIControlStateSelected)];
        [self.maintenanceButton setImage:[UIImage imageNamed:@"maintain2"] forState:UIControlStateDisabled];
        self.maintenanceButton.enabled  = NO;
        [self.maintenanceButton setTitle:@"保养维护" forState:(UIControlStateNormal)];
        [self.maintenanceButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.maintenanceButton];
        
        
        
        CGFloat businessX = Kle + buttonWidth + buttonHor;
        self.productButton = [[TopPicBottomLabelButton alloc] initWithFrame:CGRectMake(businessX, top, buttonWidth, buttonHeight)];
        CGFloat imageWidth = buttonWidth - 20;
        self.productButton.imageView.frame = CGRectMake(10, 10, imageWidth, imageWidth);
        [self.productButton setImage:[UIImage imageNamed:@"commodity"] forState:(UIControlStateNormal)];
//        [self.productButton setImage:[UIImage imageNamed:@"commodity2"] forState:(UIControlStateSelected)];
                [self.productButton setImage:[UIImage imageNamed:@"commodity2"] forState:(UIControlStateDisabled)];
        [self.productButton setTitle:@"商品" forState:(UIControlStateNormal)];
        [self.productButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        [self.contentView addSubview:self.productButton];
        
        
        
        CGFloat locationX = businessX + buttonWidth + buttonHor;
        self.carInfoButton = [[TopPicBottomLabelButton alloc] initWithFrame:CGRectMake(locationX, top, buttonWidth, buttonHeight)];
        [self.carInfoButton setImage:[UIImage imageNamed:@"car"] forState:(UIControlStateNormal)];
//        [self.carInfoButton setImage:[UIImage imageNamed:@"car2"] forState:(UIControlStateSelected)];
                [self.carInfoButton setImage:[UIImage imageNamed:@"car2"] forState:(UIControlStateDisabled)];
        [self.carInfoButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.carInfoButton setTitle:@"二手车" forState:(UIControlStateNormal)];
        
        [self.contentView addSubview:self.carInfoButton];
        
        
        [self.maintenanceButton.titleLabel setFont:Font14];
        [self.productButton.titleLabel setFont:Font14];
        [self.carInfoButton.titleLabel setFont:Font14];

        
        
//        CGFloat buttonWidth = KScreenWidth / 3;
//        
//        self.maintenanceButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        self.maintenanceButton.frame = CGRectMake(0, 0, buttonWidth, Klength44);
//        [self.contentView addSubview:self.maintenanceButton];
//        
//        
//        
//        self.productButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        self.productButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, Klength44);
//        [self.contentView addSubview:self.productButton];
//        
//        
//        
//        self.carInfoButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        self.carInfoButton.frame = CGRectMake(2 * buttonWidth, 0, buttonWidth, Klength44);
//        [self.contentView addSubview:self.carInfoButton];
//        
//        
//        
//        [self.maintenanceButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//        [self.productButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//        [self.carInfoButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
