//
//  HouseImageCell.m
//  kztool
//
//  Created by 武探 on 16/7/20.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import "HouseImageCell.h"
#import "Common.h"
#import "Masonry.h"


@interface HouseImageCell()

@property(nonatomic,strong) UIImageView *deleteImageView;

@end

@implementation HouseImageCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

-(void)initialize {
    
    __weak typeof(self) weakSelf = self;
    
    _imageView = [[UIImageView alloc] init];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderColor = HexColor(0xeeeeee).CGColor;
    _imageView.layer.borderWidth = 1;
    _imageView.layer.cornerRadius = 5;
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    CGFloat deleteImageViewWidth = 30.0f;
    _deleteImageView = [[UIImageView alloc] init];
    _deleteImageView.contentMode = UIViewContentModeCenter;
    _deleteImageView.image = [UIImage imageNamed:@"delete"];
    _deleteImageView.layer.masksToBounds = YES;
    _deleteImageView.userInteractionEnabled = YES;
    _deleteImageView.layer.cornerRadius = deleteImageViewWidth / 2;
    _deleteImageView.hidden = YES;
    [self.contentView addSubview:_deleteImageView];
    [_deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(deleteImageViewWidth);
        make.width.mas_equalTo(deleteImageViewWidth);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteImageViewTap:)];
    tap.numberOfTapsRequired = 1;
    [_deleteImageView addGestureRecognizer:tap];
    
}

-(void)deleteImageViewTap:(UIGestureRecognizer*)sender {
    if(_delegate) {
        [_delegate houseImageCellWillDeleteCell:self];
    }
}

-(void)setShowDelete:(BOOL)showDelete {
    _showDelete = showDelete;
    _deleteImageView.hidden = !_showDelete;
}

@end
