//
//  WUPreviewViewController.h
//  kztool
//
//  Created by 武探 on 16/6/23.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAsset;
@class WUPreviewImageCell;

@protocol WUPreviewImageCellDelegate <NSObject>

@optional
-(void)previewImageCellDidSelected:(WUPreviewImageCell*)cell;

@end

@interface WUPreviewImageCell : UICollectionViewCell

@property(nonatomic,weak) id<WUPreviewImageCellDelegate> delegate;
@property(nonatomic,strong,readonly) UIImageView *imageView;

-(void)setImageZoom:(CGFloat)scale;
-(void)layout;

@end



@interface WUPreviewViewController : UIViewController

@property(nonatomic,strong) NSArray<PHAsset*> *dataArray;

@end
