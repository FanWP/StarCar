//
//  OrderModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject


/** 交易单号 */
@property (nonatomic,copy) NSString *saleid;

/** 消费时间 */
@property (nonatomic,copy) NSString *lasttime;

/** 用户的ID */
@property (nonatomic,copy) NSString *userid;

/** 订单列表的ID */
@property (nonatomic,copy) NSString *ID;

/** 购买的个数 */
@property (nonatomic,copy) NSString *count;

/** 购买日期 */
@property (nonatomic,copy) NSString *date;

/** 购买类型（1--商品  2-- 服务） */
@property (nonatomic,copy) NSString *buytype;

/* 0---未确认  1---已确认 */
@property (nonatomic,assign) NSInteger confirm;

/** 消费类型（1--虚拟币 2--积分）*/
@property (nonatomic,assign) NSInteger purchasetype;

/** 商品名称 */
@property (nonatomic,copy) NSString *productname;

/** 用户昵称 */
@property (nonatomic,copy) NSString *membername;

/** 用户名 */
@property (nonatomic,copy) NSString *username;

/** 商品价格 */
@property (nonatomic,copy) NSString *price;


/** 商品图片 */
@property (nonatomic,copy) NSString *picture;





@end
