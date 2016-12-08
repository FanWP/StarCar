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
    FeedbackView *view = [[FeedbackView alloc] initWithFrame:CGRectMake(0, 80, KScreenWidth, self.feedbackModel.textH + 90) ];
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
    content.x = 18;
    content.y = 6;
    content.width = KScreenWidth - 2 * content.x;
    content.text = self.feedbackModel.fbcontent;
    self.content = content;
    content.textColor = lableTextcolor;
    content.font = Font12;
    content.numberOfLines = 0;
    
    //计算内容的高度
    NSString *str = [NSString stringWithFormat:@"%@",self.feedbackModel.fbcontent];
    
    CGSize maxSize = CGSizeMake(KScreenWidth - 36, MAXFLOAT);
    
    //计算文字的高度
    CGFloat TextH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font14} context:nil].size.height;
    content.height = TextH;
    [reView addSubview:content];
    
    //时间
    UILabel *time = [[UILabel alloc] init];
    time.y = CGRectGetMaxY(content.frame) + 10;
    time.width = KScreenWidth - 2 * content.x;
    time.x = KScreenWidth - 37 - time.width;
    time.height = 15;
    time.textAlignment = NSTextAlignmentRight;
    time.font = Font12;
    time.tintColor = lableTextcolor;
    time.text = self.feedbackModel.lasttime;
//    time.backgroundColor = [UIColor redColor];

    self.time = time;
    time.textColor = lableTextcolor;
    time.font = Font12;
    [reView addSubview:time];
    [self.view addSubview:reView];

    //调整容器的高度
    reView.height = CGRectGetMaxY(time.frame) + 5;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
