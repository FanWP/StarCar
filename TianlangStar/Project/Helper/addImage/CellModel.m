//
//  ViewController.h
//  album
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

-(instancetype)init {
    self = [super init];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return self;
}

+(instancetype)cellModelWith:(NSString *)title sel:(NSString *)selectorString {
    CellModel *cell = [[CellModel alloc] init];
    cell.title = title;
    cell.selectorString = selectorString;
    return cell;
}

+(instancetype)cellModelWith:(NSString *)title subTitle:(NSString *)subTitle image:(NSString *)image sel:(NSString *)selectorString {
    CellModel *cell = [[CellModel alloc] init];
    cell.title = title;
    cell.subTitle = subTitle;
    cell.image = image;
    cell.selectorString = selectorString;
    return cell;
}

@end
