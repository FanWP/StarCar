//
//  ViewController.h
//  album
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HouseImageHeaderView.h"
#import "Common.h"
#import "Masonry.h"
#import "UIView+MyExtension.h"

@interface HouseImageHeaderView()

@property(nonatomic,strong) CALayer *topLineLayer;
@property(nonatomic,strong) CALayer *bottomLineLayer;

@end

@implementation HouseImageHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

-(void)initialize {
    
    __weak typeof(self) weakSelf = self;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = UIFontSmall;
    _titleLabel.textColor = HexColor(0x666666);
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
    
    _topLineLayer = [[CALayer alloc] init];
    _topLineLayer.backgroundColor = HexColor(0xeeeeee).CGColor;
    [self.layer addSublayer:_topLineLayer];
    
    _bottomLineLayer = [[CALayer alloc] init];
    _bottomLineLayer.backgroundColor = HexColor(0xeeeeee).CGColor;
    [self.layer addSublayer:_bottomLineLayer];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _topLineLayer.frame = CGRectMake(0, 0, self.width, 1);
    _bottomLineLayer.frame = CGRectMake(0, self.height - 1, self.width, 1);
}

@end
