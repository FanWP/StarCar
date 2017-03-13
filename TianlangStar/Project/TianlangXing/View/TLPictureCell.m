//
//  TLPictureCell.m
//  TianlangStar
//
//  Created by Beibei on 17/1/16.
//  Copyright © 2017年 yysj. All rights reserved.
//

#import "TLPictureCell.h"

@implementation TLPictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, (KScreenHeight - 64 - 44) / 3)];
        [self.contentView addSubview:_pictureView];
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
