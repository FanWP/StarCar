//
//  LeftAndRightModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeftAndRightModel : NSObject

/** 左边的lanble， */
@property (nonatomic,copy) NSString *leftLB;

/** 右边的lanble， */
@property (nonatomic,copy) NSString *rightLB;

/** 快速创建模型 */
+(instancetype)modelWithLeft:(NSString *)left Right:(NSString *)right;



@end
