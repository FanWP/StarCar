//
//  AddImagesCollectionCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/21.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AddImagesCollectionCell.h"

@implementation AddImagesCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        CGFloat picWidth = 60;
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, picWidth, picWidth)];
        [self.contentView addSubview:self.pictureView];
        
        CGFloat deleteButtonX = picWidth - 20;
        CGFloat deleteButtonWidth = 20;
        self.deleteButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.deleteButton.frame = CGRectMake(deleteButtonX, 0, deleteButtonWidth, deleteButtonWidth);
        [self.pictureView addSubview:self.deleteButton];
        
        [self.deleteButton setTitle:@"删" forState:(UIControlStateNormal)];
        self.pictureView.backgroundColor = [UIColor cyanColor];
    }
    
    return self;
}

@end
