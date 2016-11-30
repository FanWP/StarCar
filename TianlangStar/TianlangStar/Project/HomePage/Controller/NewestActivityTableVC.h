//
//  NewestActivityTableVC.h
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewActivityModel;

@interface NewestActivityTableVC : UITableViewController

@property (nonatomic,strong) NewActivityModel *activityModel;

@property (nonatomic,strong) NSArray *activityArray;

@end
