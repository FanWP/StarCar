//
//  NewestListCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "NewestListCell.h"

@implementation NewestListCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGFloat hor = Klength10;
        
        CGFloat pictureViewX = Klength15;
        CGFloat pictureViewY = Klength5;
        CGFloat pictureViewWidth = 0.3 * KScreenWidth;
        CGFloat pictureViewHeight = 0.8 * pictureViewWidth;
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(pictureViewX, pictureViewY, pictureViewWidth, pictureViewHeight)];
        [self.contentView addSubview:self.pictureView];
        
        
        
        CGFloat titleLabelX = pictureViewX + pictureViewWidth + hor;
        CGFloat titleLabelY = (pictureViewHeight + 2 * pictureViewY) / 2 - Klength30 / 2 - Klength20 / 2;
        CGFloat titleLabelWidth = KScreenWidth - 2 * pictureViewX - pictureViewWidth - hor;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, Klength30)];
        self.titleLabel.font = Font16;
        [self.contentView addSubview:self.titleLabel];
        
        
        
        CGFloat timeLabelHeight = Klength20;
        CGFloat timeLabelY = pictureViewY + pictureViewHeight - timeLabelHeight;
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, timeLabelY, titleLabelWidth, timeLabelHeight)];
        [self.contentView addSubview:self.timeLabel];
        
        
        
        self.pictureView.image = [UIImage imageNamed:@"lunbo1"];
        self.titleLabel.text = @"双12，爱车日";
        self.timeLabel.text = @"2016-12-12 12:12";
        
        self.timeLabel.font = Font12;
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
