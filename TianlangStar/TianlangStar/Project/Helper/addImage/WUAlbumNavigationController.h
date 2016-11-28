//
//  WUAlbumNavigationController.h
//  kztool
//
//  Created by 武探 on 16/6/24.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WUAlbum.h"

@interface WUAlbumNavigationController : UINavigationController

-(instancetype)initWithDelegate:(__weak id<WUAlbumDelegate>)delegate;

@end
