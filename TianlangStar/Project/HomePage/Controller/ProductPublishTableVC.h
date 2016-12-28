//
//  ProductPublishTableVC.h
//  TianlangStar
//
//  Created by Beibei on 16/11/18.
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

/** 服务入库 */
typedef enum : NSUInteger {
    services = 0,
    servicetype,
    content,
    warranty,
    manhours,
    servicePrice,
    serviceScoreprice
} ServicePublish;


@interface ProductPublishTableVC : UITableViewController



@end











































