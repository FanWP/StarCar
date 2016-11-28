//
//  WUAlbum.m
//  kztool
//
//  Created by 武探 on 16/6/23.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import "WUAlbum.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "WUAlbumNavigationController.h"

@implementation WUAlbum

+(UIImage *)getImageInBundle:(NSString *)name {
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/WUImagePicker.bundle/%@",name]];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

+(void)showCamera:(UIViewController *)controller delegate:(__weak id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            [self openCamera:controller delegate:delegate];
        }];
    } else if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        [self showSettingAlert:@"您没有允许访问您的相机，是否前去设置" controller:controller];
    } else {
        [self openCamera:controller delegate:delegate];
    }
}

+(void)openCamera:(UIViewController*)controller delegate:(__weak id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = delegate;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    picker.allowsEditing = NO;
    [controller presentViewController:picker animated:YES completion:nil];
}

+(void)showAlbum:(UIViewController*)controller delegate:(__weak id<WUAlbumDelegate>)delegate {
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if(authStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized) {
                [self openAlbum:controller delegate:delegate];
            }
        }];
    } else if(authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
        [self showSettingAlert:@"您没有允许访问您的相册，是否前去设置" controller:controller];
    } else {
        [self openAlbum:controller delegate:delegate];
    }
}

+(void)openAlbum:(UIViewController*)controller delegate:(__weak id<WUAlbumDelegate>)delegate {
    WUAlbumNavigationController *nav = [[WUAlbumNavigationController alloc] initWithDelegate:delegate];
    [controller presentViewController:nav animated:YES completion:nil];
}

+(void)showSettingAlert:(NSString*)message controller:(UIViewController*)controller {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(void)showPickerMenu:(UIViewController*)controller delegate:(__weak id<UINavigationControllerDelegate,UIImagePickerControllerDelegate,WUAlbumDelegate>)delegate {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showAlbum:controller delegate:delegate];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#if TARGET_OS_SIMULATOR
        NSLog(@"不支持模拟器");
#elif TARGET_OS_IOS
        [self showCamera:controller delegate:delegate];
#endif
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:albumAction];
    [alertController addAction:cameraAction];
    [alertController addAction:cancelAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(WUAlbumAsset *)savePhotoWithImage:(UIImage *)image {
    
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if(authStatus != PHAuthorizationStatusAuthorized) {
        return nil;
    }
    
    __block NSString *assetID;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCreationRequest *creationRequest = [PHAssetCreationRequest creationRequestForAssetFromImage:image];
        assetID = creationRequest.placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    PHFetchResult<PHAsset*> *result = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
    if(result && result.count > 0) {
        WUAlbumAsset *asset = [[WUAlbumAsset alloc] initWithAsset:result.firstObject];
        return asset;
    }
    
    return nil;
}

@end
