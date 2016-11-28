//
//  CarModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/4.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

/** 后台返回为id */
@property (nonatomic,copy) NSString *ID;

/** 用户ID */
@property (nonatomic,copy) NSString *userid;
/** 后台返回为id */

@property (nonatomic,copy) NSString *carid;
/** 品牌 */
@property (nonatomic,copy) NSString *brand;
/** 型号 */
@property (nonatomic,copy) NSString *model;
/** 车型 */
@property (nonatomic,copy) NSString *cartype;
/** 车架号 */
@property (nonatomic,copy) NSString *frameid;
/** 发动机号*/
@property (nonatomic,copy) NSString *engineid;
/** 购买时间 */
@property (nonatomic,copy) NSString *buytime;
/** 图片 */
@property (nonatomic,copy) NSString *picture;

/** 保险信息 */
@property (nonatomic,copy) NSString *insuranceid;
/** 交强险日期 */
@property (nonatomic,copy) NSString *insurancetime;
/** 商业险到期提醒 */
@property (nonatomic,copy) NSString *commercialtime;


/** 车辆的ID */
@property (nonatomic,copy) NSString *cid;


@property (nonatomic,copy) NSString *price;

@property (nonatomic,copy) NSString *mileage;

@property (nonatomic,copy) NSString *number;

@property (nonatomic,copy) NSString *person;

@property (nonatomic,copy) NSString *property;

@property (nonatomic,copy) NSString *carDescription;

@end
