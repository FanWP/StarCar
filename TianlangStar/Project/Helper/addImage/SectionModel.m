//
//  ViewController.h
//  album
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "SectionModel.h"

@implementation SectionModel

+(instancetype)sectionModelWith:(NSString *)title cells:(NSArray<CellModel *> *)cells {
    SectionModel *section = [[SectionModel alloc] init];
    section.title = title;
    section.cells = cells;
    return section;
}

@end
