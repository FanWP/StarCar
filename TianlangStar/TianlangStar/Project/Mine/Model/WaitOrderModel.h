//
//  WaitOrderModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//  待处理订单模型

#import <Foundation/Foundation.h>

@class OrderModel;
@interface WaitOrderModel : NSObject


/** 订单时间 */
@property (nonatomic,copy) NSString *date;

/** 订单的模型数组 */
@property (nonatomic,strong) NSArray *valueList;


@end
