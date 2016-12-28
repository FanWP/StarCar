//
//  WUAlbumViewController.h
//  kztool
//
//  Created by 武探 on 16/6/23.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WUAlbum.h"

@class PHAssetCollection;

@interface WUAlbumViewController : UIViewController

@property(nonatomic,weak) id<WUAlbumDelegate> delegate;
@property(nonatomic,strong) PHAssetCollection *assetCollection;

///0或者小于0.不限
@property(nonatomic,assign) NSUInteger maxSelectCount;

@end
