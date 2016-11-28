//
//  CheckCarInfoTVC.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/17.
//  Copyright © 2016年 yysj. All rights reserved.
//  他的爱车

#import <UIKit/UIKit.h>
#import "BossAccountInfoMTVC.h"
@class CarModel;


@interface CheckCarInfoTVC : UITableViewController

/** 传入的车辆模型 */
@property (nonatomic,strong) CarModel *carModel;

/** 会员管理控制器 */
@property (nonatomic,strong) BossAccountInfoMTVC *accountMTVC;


@end
