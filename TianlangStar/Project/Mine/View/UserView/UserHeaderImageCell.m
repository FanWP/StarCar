//
//  UserHeaderCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "UserHeaderImageCell.h"

@implementation UserHeaderImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        UILabel *leftLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 60, 40)];
        self.leftLable = leftLable;
        [self.contentView addSubview:leftLable];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth - 110, 10, 80, 80)];
        img.layer.cornerRadius = img.width / 2;
        img.layer.masksToBounds = YES;
        self.headerPic = img;
        
        [self.contentView addSubview:img];
    }
    return self;
}


@end
