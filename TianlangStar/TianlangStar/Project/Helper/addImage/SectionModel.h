//
//  ViewController.h
//  album
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellModel.h"

@interface SectionModel : NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSArray<CellModel*> *cells;
@property(nonatomic,strong) NSMutableArray *mutableCells;

@property(nonatomic,assign) BOOL isExpand;

+(instancetype)sectionModelWith:(NSString*)title cells:(NSArray<CellModel*>*)cells;

@end
