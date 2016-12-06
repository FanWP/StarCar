//
//  ServiceModel.h
//  TianlangStar
//
//  Created by Beibei on 16/11/22.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceModel : NSObject

@property (nonatomic,copy) NSString *services;
@property (nonatomic,copy) NSString *servicetype;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *warranty;
@property (nonatomic,copy) NSString *manhours;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *scoreprice;
@property (nonatomic,copy) NSString *images;
@property (nonatomic,copy) NSString *ID;

/**服务的个数 */
@property (nonatomic,assign) NSInteger count;


/**服务的总价格 */
@property (nonatomic,assign) NSInteger realPrice;


@property (nonatomic,copy) NSString *productid;

/** 购买类型1---商品   2--- 服务 */
@property (nonatomic,assign) NSInteger buytype;




@end
