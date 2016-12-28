//
//  LabelTextFieldCell.h
//  TianlangStar
//
//  Created by Beibei on 16/11/15.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYUITextView;
@interface LabelTextFieldCell : UITableViewCell

@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UITextField *rightTF;

@property (nonatomic,strong) UILabel *rightLabel;

@property (nonatomic,strong) YYUITextView *rightTextView;

@end
