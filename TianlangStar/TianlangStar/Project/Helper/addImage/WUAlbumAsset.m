//
//  WUAlbumAsset.m
//  WUAlbum
//
//  Created by 武探 on 16/7/19.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import "WUAlbumAsset.h"

@implementation WUAlbumAsset

-(instancetype)initWithAsset:(PHAsset *)asset {
    self = [super init];
    if(self) {
        _asset = asset;
    }
    return self;
}

-(UIImage *)imageWithSize:(CGSize)size {
    PHImageManager *manager = [PHImageManager defaultManager];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    __block UIImage *image;
    [manager requestImageForAsset:self.asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        image = result;
    }];
    return image;
}

-(UIImage *)imageWithOriginal {
    NSData *data = [self dataWithOriginal];
    if(data) {
        return [UIImage imageWithData:data];
    }
    return nil;
}

-(NSData *)dataWithOriginal {
    PHImageManager *manager = [PHImageManager defaultManager];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    __block NSData *data;
    [manager requestImageDataForAsset:self.asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        data = imageData;
    }];
    
    return data;
}

-(NSData *)dataWithCompressionQuality:(CGFloat)compressionQuality {
    UIImage *image = [self imageWithOriginal];
    
    return UIImageJPEGRepresentation(image, compressionQuality);
}

-(NSData *)dataWithCompressionQualityDefault {
    
    UIImage *image = [self imageWithOriginal];
    CGFloat compressionQuality = 1;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    if(width > 3000 || height > 3000) {
        compressionQuality = 0.3;
    } else if(width > 1500 || height > 1500) {
        compressionQuality = 0.8;
    }
    return UIImageJPEGRepresentation(image, compressionQuality);
}

-(void)requestImageWithSize:(CGSize)size complete:(void (^)(UIImage *))complete {
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestImageForAsset:self.asset targetSize:size contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        complete(result);
    }];
}

+(NSData*)compressionWithImage:(UIImage*)image {
    
    CGFloat compressionQuality = 1;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    if(width > 3000 || height > 3000) {
        compressionQuality = 0.3;
    } else if(width > 1500 || height > 1500) {
        compressionQuality = 0.8;
    }
    return UIImageJPEGRepresentation(image, compressionQuality);
}

@end
