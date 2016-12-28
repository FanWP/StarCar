//
//  ViewController.h
//  album
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HexColor(hexValue) [Common hexColor:hexValue]
#define ThemeColor HexColor(0x0093ff)
#define ThemeBackgroundColor HexColor(0xeeeeee) //HexColor(0xefeff4)
#define ScreenBounds [Common screenBounds]
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height
#define RSKeyWindow [UIApplication sharedApplication].keyWindow
#define HidenKeyboard [Common hiddenKeyboard]
#define NavigationBarHeight 64.0f
#define UIBarButtonItemFont [UIFont systemFontOfSize:16]
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define UIFontLargest [Common systemFontOfSize:18]
#define UIFontLarge [Common systemFontOfSize:16]
#define UIFontNormal [Common systemFontOfSize:14]
#define UIFontSmall [Common systemFontOfSize:12]
#define UIFontSmallest [Common systemFontOfSize:10]

extern NSString *const CommonRegexEmail;
extern NSString *const CommonRegexMoney;

@interface Common : NSObject

/**
 *  16进制RGB色
 *
 *  @param hexValue RGB值 16进制
 */
+ (UIColor*) hexColor:(NSInteger)hexValue;

/**
 *  隐藏键盘
 */
+ (void) hiddenKeyboard;

/**
 *  是否显示网络标示符
 */
+ (void) networkActivityIndicatorVisible:(BOOL)isShow;

/**
 *  屏幕尺寸
 */
+ (CGRect) screenBounds;

/**
 * 根据颜色生成图片
 */
+(UIImage*) imageWithFrame:(CGRect)frame color:(UIColor*)color;

/**
 * 通过storyboardID从Storyboard中获取ViewController
 */
+(__kindof UIViewController*)viewControllerWithStoryboardID:(NSString*)storyboardID;

+(UIFont*)systemFontOfSize:(CGFloat)size;

+(NSInteger)appVersion;
+(NSInteger)buildVersion;
+(NSString*)appName;
+(NSString*)identifierForVendor;

+(NSString*)UUID;

+(NSString*)getDateDefaultStyleWithDate:(NSDate*)date;

+(BOOL)evaluateWithString:(NSString*)value regex:(NSString*)regex;

@end
