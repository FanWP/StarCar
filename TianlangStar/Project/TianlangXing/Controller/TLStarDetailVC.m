//
//  TLStarVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TLStarDetailVC.h"

@interface TLStarDetailVC ()<WKNavigationDelegate>

@end

@implementation TLStarDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *repuest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [self.wkWebView loadRequest:repuest];
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
