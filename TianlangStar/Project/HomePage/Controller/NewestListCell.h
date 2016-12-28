//
//  NewestListCell.h
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewestListCell : UITableViewCell

// 活动图片
@property (nonatomic,strong) UIImageView *pictureView;
// 活动标题
@property (nonatomic,strong) UILabel *titleLabel;
// 活动时间
@property (nonatomic,strong) UILabel *timeLabel;

@end
