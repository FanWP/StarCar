//
//  WUAlbum.h
//  kztool
//
//  Created by 武探 on 16/6/23.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WUImageBrowseView.h"
#import "WUImageCollectionView.h"
#import "WUAlbumAsset.h"

#define WU_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@protocol WUAlbumDelegate <NSObject>

@required
-(void)albumFinishedSelected:(NSArray<WUAlbumAsset *> *)assets;

@end

@interface WUAlbum : NSObject

+(UIImage*)getImageInBundle:(NSString*)name;
+(void)showCamera:(UIViewController*)controller delegate:(__weak id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate;
+(void)showAlbum:(UIViewController*)controller delegate:(__weak id<WUAlbumDelegate>)delegate;
+(void)showPickerMenu:(UIViewController*)controller delegate:(__weak id<UINavigationControllerDelegate,UIImagePickerControllerDelegate,WUAlbumDelegate>)delegate;

/**
 *  保存照片到相机胶卷
 *
 *  @param image 图片
 *
 *  @return 资源
 */
+(WUAlbumAsset*)savePhotoWithImage:(UIImage*)image;

@end
