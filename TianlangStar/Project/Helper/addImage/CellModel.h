//
//  ViewController.h
//  album
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellModel : NSObject

@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *subTitle;
@property(nonatomic,retain) NSString *image;
@property(nonatomic,retain) NSString *selectorString;
@property(nonatomic,assign) UITableViewCellSelectionStyle selectionStyle;
@property(nonatomic,assign) UITableViewCellAccessoryType accessoryType;
@property(nonatomic,strong) __kindof UIView *accessoryView;

@property(nonatomic,strong) id userInfo;
@property(nonatomic,assign) BOOL isExpand;

+(instancetype)cellModelWith:(NSString*)title sel:(NSString*)selectorString;
+(instancetype)cellModelWith:(NSString*)title subTitle:(NSString*)subTitle image:(NSString*)image sel:(NSString*)selectorString;

@end
