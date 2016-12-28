//
//  LeftAndRightModel.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "LeftAndRightModel.h"

@implementation LeftAndRightModel


+(instancetype)modelWithLeft:(NSString *)left Right:(NSString *)right
{

    LeftAndRightModel *model = [[self alloc] init];
    model.leftLB = left;
    model.rightLB = right;
    
    return model;

}

@end
