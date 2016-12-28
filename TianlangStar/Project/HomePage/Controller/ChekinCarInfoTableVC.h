//
//  ChekinCarInfoTableVC.h
//  TianlangStar
//
//  Created by Beibei on 16/11/16.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

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
} CheckinCarInfo;

@interface ChekinCarInfoTableVC : UITableViewController

@end
