//
//  ExcelModel.m
//  TianlangStar
//
//  Created by Beibei on 16/11/18.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ExcelModel.h"
#import <UIKit/UIKit.h>

@implementation ExcelModel

// 编码方法(归档的过程,类的每一个属性,都需要编码)
// 编码方法在归档的时候执行
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // 对name进行编码,并且加上标记值name
    [aCoder encodeObject:_url forKey:@"url"];
    
}
// 解码方法(反归档的过程,解码时对每一个属性,根据key值进行解码)
// 反归档是一个由data类型数据,重新生成复杂对象的过程,因此是一个初始化过程
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        
        // 解码,重新赋值
        _url = [aDecoder decodeObjectForKey:@"url"];
        
        
    }
    return self;
}


@end
