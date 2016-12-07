//
//  TLStarVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TLStarVC.h"

#import "TestInterfaceVC.h"

@interface TLStarVC ()<WKNavigationDelegate>

@end

@implementation TLStarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // 测试接口按钮
//    UIButton *testButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    testButton.frame = CGRectMake(50, 100, 100, 44);
//    [testButton setTitle:@"测试接口" forState:(UIControlStateNormal)];
//    [testButton addTarget:self action:@selector(testAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:testButton];
    
    
//    find/company/info
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *repuest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [self.wkWebView loadRequest:repuest];
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    
    NSString *uRL = [NSString stringWithFormat:@"%@find/company/info",URL];
    
    [[AFHTTPSessionManager manager] POST:uRL parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"==================================%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        
    }];

    
}



//#pragma mark - 测试接口点击事件
//- (void)testAction
//{
//    TestInterfaceVC *testInterfaceVC = [[TestInterfaceVC alloc] init];
//    [self.navigationController pushViewController:testInterfaceVC animated:YES];
//}



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
