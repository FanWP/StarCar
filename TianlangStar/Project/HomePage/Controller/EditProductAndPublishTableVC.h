//
//  EditProductAndPublishTableVC.h
//  TianlangStar
//
//  Created by Beibei on 16/11/27.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 商品入库 */
typedef enum : NSUInteger {
    productname = 0,
    productmodel,
    specifications,
    applycar,
    vendors,
    shelvestime,
    inventory,
    purchaseprice,
    price,
    scoreprice,
    introduction,
    remark
} ProductPublish;

@class StorageManagementModel;

@interface EditProductAndPublishTableVC : UITableViewController

@property (nonatomic,strong) StorageManagementModel *storageManagementModel;



@end
