//
//  ReFeedbackVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/22.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ReFeedbackVC.h"
#import "FeedbackView.h"
#import "FeedbackModel.h"
#import "YYUITextView.h"

@interface ReFeedbackVC ()<UITextViewDelegate>

/** 用户回复的输入框 */
@property (nonatomic,strong) YYUITextView *textView;

@end

@implementation ReFeedbackVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"未回复";
    self.view.backgroundColor = BGcolor;
    
    [self setupControls];
}

//设置子控件
-(void)setupControls
{
    FeedbackView *view = [[FeedbackView alloc] initWithFrame:CGRectMake(0, 80, KScreenWidth, self.feedbackModel.textH + 90) ];
    view.backgroundColor = [UIColor whiteColor];
    view.feedbackModel = self.feedbackModel;
    [self.view addSubview:view];
    
    
    
    YYUITextView *textView = [[YYUITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(view.frame) + 20, KScreenWidth - 40, 113)];
    textView.font = Font12;
    [self.view addSubview:textView];
    self.textView = textView;
    textView.placeholder = @"输入回复内容";
    textView.placeholderColor = lableTextcolor;

    
    //设置提交按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.width = 99;
    btn.height = 44;
    btn.x = KScreenWidth - 37 - 99;
    btn.y = CGRectGetMaxY(textView.frame) + 16;
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = Font15;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = Tintcolor;
    [self.view addSubview:btn];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


//提交按钮的点击事件
-(void)commitBtnClick
{
    
    if (self.textView.text.length == 0 || self.textView.text == nil)
    {
        [[AlertView sharedAlertView] addAlertMessage:@"请输入回复内容" title:@"提示！"];
        return;
    }
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];

    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"content"] = self.textView.text;
    parmas[@"suggestid"] = self.feedbackModel.ID;
    
    NSString *url = [NSString stringWithFormat:@"%@feedback/suggestion",URL];
    
    YYLog(@"管理员意见回复parmas--:%@url--:%@",parmas,url);
    
    [SVProgressHUD showWithStatus:@"数据提交中..."];
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         [SVProgressHUD dismiss];
         NSNumber *num = json[@"resultCode"];
         
         if ([num integerValue] == 1000)
         {
             self.textView.text = nil;
             [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
         }
         YYLog(@"json--%@",json);
         
     } failure:^(NSError *error) {
         YYLog(@"error--%@",error);
         [SVProgressHUD dismiss];
     }];
    
    
    YYLog(@"提交");
}




@end
