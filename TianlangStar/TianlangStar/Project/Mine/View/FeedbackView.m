//
//  FeedbackView.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/22.
//  Copyright © 2016年 yysj. All rights reserved.
//
#import "FeedbackModel.h"
#import "FeedbackView.h"

@interface FeedbackView ()

/** user用户 */
@property (nonatomic,weak) UILabel *user;

/** user用户 */
@property (nonatomic,weak) UILabel *username;

/** 内容 */
@property (nonatomic,weak) UILabel *content;

/** 时间 */
@property (nonatomic,weak) UILabel *time;

@end




@implementation FeedbackView




-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        //用户名
        UILabel *user = [[UILabel alloc] init];
        user.x = 18;
        user.y = 10;
        user.width = 150;
        user.height = 30;
//        user.backgroundColor = [UIColor redColor];
        user.textColor = lableTextcolor;
        self.user = user;
        user.font = Font14;
        [self addSubview:user];
        
        //手机号
        UILabel *username = [[UILabel alloc] init];
        username.x = KScreenWidth * 0.5 + 10;
        username.y = user.y;
        username.width = 150;
        username.height = 30;
//        username.backgroundColor = [UIColor redColor];
        username.textColor = lableTextcolor;
        username.font = Font14;
        self.username = username;
        [self addSubview:username];
        
        
        //内容
        UILabel *content = [[UILabel alloc] init];
        content.x = user.x;
        content.y = CGRectGetMaxY(user.frame) + 15;
        content.width = self.width;
        content.height = 30;
        content.numberOfLines = 0;
        content.font = Font12;
        content.textColor = lableTextcolor;
        self.content = content;
        
        //        content.backgroundColor = [UIColor redColor];
        [self addSubview:content];
        
        
        //时间
        UILabel *time = [[UILabel alloc] init];
        time.x = user.x;
        time.y = CGRectGetMaxY(user.frame) + 15;
        time.width = 180;
        time.height = 30;
        time.font = Font11;
        self.time = time;
        time.textColor = lableTextcolor;
        
        //        time.backgroundColor = [UIColor orangeColor];
        [self addSubview:time];

    }
    return self;
}




-(void)setFeedbackModel:(FeedbackModel *)feedbackModel
{
    _feedbackModel = feedbackModel;
    self.user.text = feedbackModel.membername;
    self.username.text = feedbackModel.username;
    self.content.text = feedbackModel.content;
    self.time.text = feedbackModel.lasttime;
    self.content.height = feedbackModel.textH;
}

-(void)layoutSubviews
{
    [super layoutSubviews];


    self.content.width = self.width - 36;

    self.time.y = CGRectGetMaxY(self.content.frame) + 5;
    
    self.time.x = self.width - self.time.width;
    
    self.width = KScreenWidth;
    

}

@end
