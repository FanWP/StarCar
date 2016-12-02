//
//  ProductDetailTableVC.h
//  TianlangStar
//
//  Created by Beibei on 16/12/2.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductModel,ServiceModel,CarModel;
@interface ProductDetailTableVC : UITableViewController

@property (nonatomic,strong) ProductModel *productModel;
@property (nonatomic,strong) ServiceModel *serviceModel;
@property (nonatomic,strong) CarModel *carModel;

@end
