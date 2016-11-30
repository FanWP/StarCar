//
//  TopPicBottomLabelButton.m
//  TianlangStar
//
//  Created by Beibei on 16/11/29.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "TopPicBottomLabelButton.h"

@implementation TopPicBottomLabelButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //        [self.titleLabel setTintColor:[UIColor blackColor]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = -10;
    self.titleLabel.y = self.imageView.y + self.imageView.height;
    self.titleLabel.width = self.width + 20;
    self.titleLabel.height = Klength30;
    self.titleLabel.textAlignment = 1;
    //    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
}


@end
