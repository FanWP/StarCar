//
//  ReFeedbackVC.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/22.
//  Copyright © 2016年 yysj. All rights reserved.
//  未回复

#import <UIKit/UIKit.h>
@class FeedbackModel;

@interface ReFeedbackVC : UIViewController

/** 传入未回复的信息模型 */
@property (nonatomic,strong) FeedbackModel *feedbackModel;

@end
