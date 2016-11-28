//
//  InsuranceModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/16.
//  Copyright © 2016年 yysj. All rights reserved.
//   保险模型

#import <Foundation/Foundation.h>

@interface InsuranceModel : NSObject

/** 图像 */
@property (nonatomic,copy) NSString *images;


/** 保险类型 */
@property (nonatomic,copy) NSString *insurancename;


/** 投保单号 */
@property (nonatomic,copy) NSString *policyid;


/** 保险表的ID*/
@property (nonatomic,copy) NSString *ID;


/** 险种 */
@property (nonatomic,copy) NSString *insurancetype;


/** 保险公司 */
@property (nonatomic,copy) NSString *company;


/** 保险类型 1---交强险  2---商业险 */
@property (nonatomic,copy) NSString *type;


/** 保险的描述 */
@property (nonatomic,copy) NSString *discription;


/** 车辆的ID */
@property (nonatomic,copy) NSString *carid;



/** 保险费用 */
@property (nonatomic,copy) NSString *expenses;


/** 当年应缴费 */
@property (nonatomic,copy) NSString *payment;

/** 购买日期 */
@property (nonatomic,copy) NSString *buytime;


/** 续保日期 */
@property (nonatomic,copy) NSString *continuetime;



@end
