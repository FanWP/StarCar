//
//  ILSettingArrowItem.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ILSettingItem.h"

@interface ILSettingArrowItem : ILSettingItem

// 调整的控制器的类名
@property (nonatomic, assign) Class destVcClass;


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

@end
