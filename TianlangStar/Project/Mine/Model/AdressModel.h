//
//  AdressModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/8.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdressModel : NSObject

/** 地址 */
@property (nonatomic,copy) NSString *address;
/** 面积 */
@property (nonatomic,copy) NSString *area;
/** 收货人 */
@property (nonatomic,copy) NSString *person;
/** ID */
@property (nonatomic,copy) NSString *ID;
/** 当前用户ID */
@property (nonatomic,copy) NSString *userId;
/** 收货人电话 */
@property (nonatomic,copy) NSString *telephone;
/** 地址类型 */
@property (nonatomic,assign) NSInteger type;



@end
