//
//  HomePageSegmentCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/29.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "HomePageSegmentCell.h"

@implementation HomePageSegmentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.segment = [[UISegmentedControl alloc] initWithItems:@[@"保养维护",@"商品",@"车辆信息"]];
        self.segment.frame = CGRectMake(0, 0, KScreenWidth, 40);
        [self.contentView addSubview:self.segment];
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
