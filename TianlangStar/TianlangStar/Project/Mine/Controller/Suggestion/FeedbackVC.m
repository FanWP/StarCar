//
//  FeedbackVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "FeedbackVC.h"
#import "YYUITextView.h"

@interface FeedbackVC ()<UITextViewDelegate>
@property (weak, nonatomic) YYUITextView *textView;



@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = BGcolor;
    
    CGFloat textViewW = KScreenWidth - 34;
    YYUITextView *textView = [[YYUITextView alloc] initWithFrame:CGRectMake(17, 14 + 64, textViewW, 122)];
    textView.font = Font17;
    textView.layer.cornerRadius = 5;
    textView.clipsToBounds = YES;
    [self.view addSubview:textView];

    textView.delegate = self;
    self.textView = textView;
    textView.placeholder = @"请输入意见反馈...";
    textView.placeholderColor = lableTextcolor;
//    textView.backgroundColor = [UIColor grayColor];

    UIButton *button = [[UIButton alloc] init];
    button.width = 100;
    button.height = 40;
    button.x = KScreenWidth - button.width - 20;
    button.y = CGRectGetMaxY(textView.frame) + 20;
    button.titleLabel.font = Font15;
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = Tintcolor;
    
    [self.view addSubview:button];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commitBtnClick:(UIButton *)sender
{
    //退出键盘，判断输入框
    [self.view endEditing:YES];
    if (self.textView.text == nil || self.textView.text.length == 0)
    {
        [[AlertView sharedAlertView] addAlertMessage:@"请输入反馈意见" title:@"提示"];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@send/suggestion",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    UserInfo *userInfo = [UserInfo sharedUserInfo];
    parameters[@"sessionId"] = userInfo.RSAsessionId;
    parameters[@"userid"] = userInfo.userID;
    parameters[@"content"] = self.textView.text;
    
    
    [HttpTool post:url parmas:parameters success:^(id json) {
        YYLog(@"客户提交意见返回：%@",json);
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        self.textView.text = nil;
    } failure:^(NSError *error) {
        YYLog(@"客户提交意见返回错误：%@",error);
    }];
    
    
}







@end
