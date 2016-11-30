//
//  ActivityDetailVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/29.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ActivityDetailVC.h"

@interface ActivityDetailVC ()<WKNavigationDelegate>

@end

@implementation ActivityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    NSURLRequest *repuest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    NSURLRequest *repuest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com/p/165e92e128ec"]];
    
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
