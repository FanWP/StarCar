//
//  CarInfoChangeVC.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//  车辆信息修改

#import <UIKit/UIKit.h>
#import "CarModel.h"

/** 车辆信息录入和添加 */
typedef enum : NSUInteger {
    carid = 0,
    brand,
    model,
    cartype,
    frameid,
    engineid,
    buytime,
    insuranceid,
    insurancetime,
    commercialtime
} CarInfo;


@interface CarInfoChangeVC : UITableViewController


/** 传入的Cars模型 */
@property (nonatomic,strong) CarModel *carInfo;

@end
