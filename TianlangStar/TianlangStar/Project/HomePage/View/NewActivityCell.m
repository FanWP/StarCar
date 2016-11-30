//
//  NewActivityCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/29.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "NewActivityCell.h"

@implementation NewActivityCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
        self.pictureView.image = [UIImage imageNamed:@"activityHomePage"];
        [self.contentView addSubview:self.pictureView];
        
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, KScreenWidth - 30 - 30, 32)];
        self.titleLabel.font = Font12;
        [self.contentView addSubview:self.titleLabel];
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
