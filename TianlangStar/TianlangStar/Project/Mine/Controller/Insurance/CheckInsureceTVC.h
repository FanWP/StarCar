//
//  CheckInsureceTVC.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/17.
//  Copyright © 2016年 yysj. All rights reserved.
//  附加险的详细及修改

#import <UIKit/UIKit.h>


@class InsuranceModel;

@interface CheckInsureceTVC : UITableViewController


/** 附加险种 */
@property (nonatomic,strong) InsuranceModel *insuranceModel;

@end
