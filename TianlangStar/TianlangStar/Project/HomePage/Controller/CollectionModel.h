//
//  CollectionModel.h
//  TianlangStar
//
//  Created by Beibei on 16/11/4.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject

/** 收藏id */
@property (nonatomic,copy) NSString *ID;
/** 收藏商品/服务id */
@property (nonatomic,copy) NSString *productid;
/** 创建时间 */
@property (nonatomic,copy) NSString *createtime;
/** 收藏类型(商品/服务) */
@property (nonatomic,assign) NSInteger type;
/** 用户id */
@property (nonatomic,assign) NSInteger userid;

/**
 *  客户提交意见内容
 */
@property (nonatomic,copy) NSString *content;

@end
