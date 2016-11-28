//
//  LabelTFLabelCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/18.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "LabelTFLabelCell.h"

@implementation LabelTFLabelCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGFloat hor = Klength10;
        
        CGFloat priceWidth = 50;
        
        CGFloat salePriceLabelX = Klength15;
        CGFloat salePriceLabelY = Klength5;
        CGFloat salePriceLabelWidth = 80;
        CGFloat salePriceLabelHeight = Klength30;
        self.salePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(salePriceLabelX, salePriceLabelY, salePriceLabelWidth, salePriceLabelHeight)];
        [self.contentView addSubview:self.salePriceLabel];
        
        
        
        CGFloat textFieldX = salePriceLabelX + salePriceLabelWidth + hor;
        CGFloat textFieldWidth = KScreenWidth - 2 * salePriceLabelX - salePriceLabelWidth - hor - priceWidth;
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldX, salePriceLabelY, textFieldWidth, salePriceLabelHeight)];
        self.textField.borderStyle = 3;
        self.textField.backgroundColor = [UIColor colorWithRed:239.0 / 255.0 green:239.0 / 255.0 blue:239.0 / 255.0 alpha:1.0];
        [self.contentView addSubview:self.textField];
        
        
        
        CGFloat priceLabelX = textFieldX + textFieldWidth;
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabelX, salePriceLabelY, priceWidth, salePriceLabelHeight)];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.priceLabel];
        
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
