//
//  WUAlbumAsset.h
//  WUAlbum
//
//  Created by 武探 on 16/7/19.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface WUAlbumAsset : NSObject

@property(nonatomic,strong,readonly) PHAsset *asset;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)new NS_UNAVAILABLE;

/**
 *  使用PHAsset创建实例
 *
 *  @param asset 图片系统资源
 */
-(instancetype)initWithAsset:(PHAsset*)asset;

/**
 *  根据尺寸获取图片
 */
-(UIImage*)imageWithSize:(CGSize)size;

/**
 *  获取原图(大图)
 */
-(UIImage*)imageWithOriginal;

/**
 *  获取原图data
 */
-(NSData*)dataWithOriginal;

/**
 *  根据压缩质量获取图片data
 *
 *  @param compressionQuality 压缩质量（0～1）
 */
-(NSData*)dataWithCompressionQuality:(CGFloat)compressionQuality;

/**
 *  获取默认的图片data
 */
-(NSData*)dataWithCompressionQualityDefault;

/**
 *  通过block从资源中请求图片
 */
-(void)requestImageWithSize:(CGSize)size complete:(void(^)(UIImage *image))complete;

+(NSData*)compressionWithImage:(UIImage*)image;

@end
