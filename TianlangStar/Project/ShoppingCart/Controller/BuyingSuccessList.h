//
//  BuyingSuccessList.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/6.
//  Copyright © 2016年 yysj. All rights reserved.
//  商品购买成功后返回

#import <UIKit/UIKit.h>

@class BuyingSuccessListModel;
@interface BuyingSuccessList : UITableViewController

/** 服务器返回的数据 */
@property (nonatomic,strong) BuyingSuccessListModel *model;

@end
