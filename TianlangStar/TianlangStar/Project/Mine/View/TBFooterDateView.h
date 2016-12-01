//
//  TBFooterDateView.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//  单元格底部的时间

#import <UIKit/UIKit.h>

@interface TBFooterDateView : UIView

/** 传入的时间 */
@property (nonatomic,weak)UILabel *date;

+(instancetype)footer;

@end
