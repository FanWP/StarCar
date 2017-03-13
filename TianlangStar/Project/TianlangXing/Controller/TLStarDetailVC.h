//
//  TLStarVC.h
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

@interface TLStarDetailVC : UIViewController


@property (nonatomic,strong) WKWebView *wkWebView;

@property (nonatomic,copy) NSString *url;



@end
