//
//  WUImageCollectionView.h
//  kztool
//
//  Created by 武探 on 16/6/24.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WUImageCollectionView : UIView

@property(nonatomic,weak) UIViewController *superController;

-(instancetype)initWithFrame:(CGRect)frame controller:(__weak UIViewController*)controller;
-(NSArray<UIImage*>*)getSelectedImages;
-(void)resizeView;

+(CGFloat)getHeightWithImageCount:(NSInteger)count viewWidth:(CGFloat)viewWidth;

@end
