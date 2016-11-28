//
//  LabelTextFieldCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/15.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "LabelTextFieldCell.h"

@implementation LabelTextFieldCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGFloat hor = Klength10;
        
        CGFloat leftLabelX = Klength15;
        CGFloat leftLabelY = Klength5;
        CGFloat leftLabelWidth = 80;
        CGFloat leftLabelHeight = Klength30;
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, leftLabelY, leftLabelWidth, leftLabelHeight)];
        self.leftLabel.font = Font16;
        [self.contentView addSubview:self.leftLabel];
        
        
        
        CGFloat rightTFX = leftLabelX + leftLabelWidth + hor;
        CGFloat rightTFWidth = KScreenWidth - 2 * leftLabelX - leftLabelWidth - hor;
        self.rightTF = [[UITextField alloc] initWithFrame:CGRectMake(rightTFX, leftLabelY, rightTFWidth, leftLabelHeight)];
        self.rightTF.font = Font14;
        self.rightTF.backgroundColor = [UIColor colorWithRed:239.0 / 255.0 green:239.0 / 255.0 blue:239.0 / 255.0 alpha:1.0];
        self.rightTF.borderStyle = UITextBorderStyleRoundedRect;
//        self.rightTF.layer.cornerRadius = BtncornerRadius;
        [self.contentView addSubview:self.rightTF];
        
        
        
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightTFX, leftLabelY, rightTFWidth, leftLabelHeight)];
        self.rightLabel.font = Font16;
        [self.contentView addSubview:self.rightLabel];
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
