//
//  HouseImageCell.h
//  kztool
//
//  Created by 武探 on 16/7/20.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HouseImageCell;

@protocol HouseImageCellDelegate <NSObject>

@required
-(void)houseImageCellWillDeleteCell:(HouseImageCell*)cell;

@end

@interface HouseImageCell : UICollectionViewCell

@property(nonatomic,strong,readonly) UIImageView *imageView;
@property(nonatomic,weak) id<HouseImageCellDelegate> delegate;

@property(nonatomic,assign) BOOL showDelete;

@end
