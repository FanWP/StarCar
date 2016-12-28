//
//  ActivityDetailVC.h
//  TianlangStar
//
//  Created by Beibei on 16/11/29.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ActivityDetailVC : UIViewController

@property (nonatomic,strong) WKWebView *wkWebView;

@property (nonatomic,copy) NSString *url;

@end
