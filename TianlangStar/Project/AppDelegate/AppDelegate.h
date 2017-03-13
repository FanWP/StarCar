//
//  AppDelegate.h
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *appKey = @"f04f9755244ee2793be44c13";
static NSString *channel = @"App Store";
static BOOL isProduction = FALSE;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UILabel *_infoLabel;
    UILabel *_tokenLabel;
    UILabel *_udidLabel;
}

@property (strong, nonatomic) UIWindow *window;


@end

