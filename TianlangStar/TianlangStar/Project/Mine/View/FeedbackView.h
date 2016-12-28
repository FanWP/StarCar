//
//  FeedbackView.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/22.
//  Copyright © 2016年 yysj. All rights reserved.
//  用户意见的View

#import <UIKit/UIKit.h>

@class FeedbackModel;
@interface FeedbackView : UIView



/** 返回信息的View */
@property (nonatomic,strong) FeedbackModel *feedbackModel;

@end
