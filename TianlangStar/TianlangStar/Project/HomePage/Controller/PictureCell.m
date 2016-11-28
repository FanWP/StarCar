//
//  PictureCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/15.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(Klength10, Klength5, KScreenWidth - 2 * Klength10, 0.3 * KScreenHeight)];
        [self.contentView addSubview:self.pictureView];
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
