//
//  ILSettingGroup.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILSettingGroup : NSObject


@property (nonatomic, copy) NSString *header;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *footer;


@end
