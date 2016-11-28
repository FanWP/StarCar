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
    FeedbackView *view = [[FeedbackView alloc] initWithFrame:CGRectMake(0, 80, KScreenWidth, self.feedbackModel.textH + 100) ];
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
    YYLog(@"提交");
}




@end
