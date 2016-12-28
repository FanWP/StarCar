//
//  WUImageBrowseView.h
//  kztool
//
//  Created by 武探 on 16/6/24.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WUImageBrowseView;

@protocol WUImageBrowseViewDelegate <NSObject>

@optional
-(CGRect)imageBrowseView:(WUImageBrowseView * _Nonnull)view willCloseAtIndex:(NSInteger)index;

@end

@interface WUImageBrowseView : UIView

@property(nonatomic,weak,nullable) id<WUImageBrowseViewDelegate> delegate;
@property(nonatomic,strong,nonnull) NSArray *images;
@property(nonatomic,assign) NSInteger currentPage;

-(void)show:(UIView * _Nonnull)view startFrame:(CGRect)startFrame foregroundImage:(UIImage * _Nonnull)image;
-(void)show:(UIView* _Nonnull)view;

@end
