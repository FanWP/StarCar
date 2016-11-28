//
//  VirtualcenterModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/8.
//  Copyright © 2016年 yysj. All rights reserved.
//  充值模型

#import <Foundation/Foundation.h>

@interface VirtualcenterModel : NSObject


/*
 rechargeTime = 0,
	id = 1,
	lastTime = 1478576650,
	balance = -376,
	userId = 13
 */

/** 充值时间 */
@property (nonatomic,copy) NSString *rechargeTime;

/** ID */
@property (nonatomic,copy) NSString *ID;

/** 上次充值时间 */
@property (nonatomic,copy) NSString *lastTime;

/** 余额 */
@property (nonatomic,assign) CGFloat balance;

/** 用户ID */
@property (nonatomic,copy) NSString *userid;

/** 用户昵称 */
@property (nonatomic,copy) NSString *membername;

/** 用户ID */
@property (nonatomic,copy) NSString *price;




@end
