//
//  StorageManagementModel.h
//  TianlangStar
//
//  Created by Beibei on 16/11/27.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageManagementModel : NSObject

@property (nonatomic,copy) NSString *productname;
@property (nonatomic,copy) NSString *inventory;
@property (nonatomic,copy) NSString *saleState;
@property (nonatomic,copy) NSString *purchaseprice;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *scoreprice;
@property (nonatomic,copy) NSString *introduction;
@property (nonatomic,copy) NSString *images;
@property (nonatomic,copy) NSString *shelves;
@property (nonatomic,copy) NSString *shelvestime;
@property (nonatomic,copy) NSString *vendors;
@property (nonatomic,copy) NSString *productmodel;
@property (nonatomic,copy) NSString *specifications;
@property (nonatomic,copy) NSString *applycar;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *ID;

@property (nonatomic,assign,getter=isSelected) BOOL selectedBtn;

@end
