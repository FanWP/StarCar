//
//  ReplyFeedbackVC.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeedbackModel;
@interface ReplyFeedbackVC : UIViewController


/** 传入已回复的信息模型 */
@property (nonatomic,strong) FeedbackModel *feedbackModel;


@end
