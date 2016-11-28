//
//  ReplyFeedbackVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ReplyFeedbackVC.h"
#import "FeedbackView.h"
#import "FeedbackModel.h"

@interface ReplyFeedbackVC ()

/** 内容 */
@property (nonatomic,weak) UILabel *content;

/** 内容 */
@property (nonatomic,weak) UILabel *time;

@end

@implementation ReplyFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"已回复";
    self.view.backgroundColor = BGcolor;
    
    [self setupControls];
}

//初始化
-(void)setupControls
{
    FeedbackView *view = [[FeedbackView alloc] initWithFrame:CGRectMake(0, 80, KScreenWidth, self.feedbackModel.textH + 100) ];
    view.backgroundColor = [UIColor whiteColor];
    view.feedbackModel = self.feedbackModel;
    [self.view addSubview:view];
    
    //管理员回复的意见
    UIView *reView = [[UIView alloc] init];
    reView.x = 0;
    reView.y = CGRectGetMaxY(view.frame) + 19;
    reView.width = KScreenWidth;
    
    reView.height = 90;
    reView.backgroundColor = [UIColor whiteColor];
    
    
    //内容
    UILabel *content = [[UILabel alloc] init];
    self.content = content;
    content.textColor = lableTextcolor;
    content.font = Font12;
    [reView addSubview:content];
    
    //内容
    UILabel *time = [[UILabel alloc] init];
    self.time = time;
    time.textColor = lableTextcolor;
    time.font = Font12;
    [reView addSubview:time];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
