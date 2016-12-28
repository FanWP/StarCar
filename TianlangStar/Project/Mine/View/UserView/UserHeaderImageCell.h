//
//  UserHeaderCell.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserHeaderImageCell : UITableViewCell

/** 头像 */
@property (nonatomic,strong) UIImageView *headerPic;


/** 左边的lable */
@property (nonatomic,weak) UILabel *leftLable;

@end
