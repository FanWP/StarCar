//
//  ILSettingItem.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ILSettingItemOption)();

@interface ILSettingItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *subTitle;

// 保存一段功能，在恰当的时候调用
@property (nonatomic, copy) ILSettingItemOption option;


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

@end
