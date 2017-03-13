//
//  MyCollectionTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "MyCollectionTableVC.h"
#import "CollectionCell.h"
#import "CollectionModel.h"

#import "ProductModel.h"
#import "ServiceModel.h"
#import "CarModel.h"

#import "CollectionProductDetailTableVC.h"

@interface MyCollectionTableVC ()


@property (nonatomic,strong) UISegmentedControl *segment;

@property (nonatomic,strong) NSMutableArray *productCollectionArray;  // 保存商品收藏物的数组
@property (nonatomic,strong) NSMutableArray *serviceCollectionArray;  // 服务
@property (nonatomic,strong) NSMutableArray *secondCarCollectionArray;// 二手车

//@property (nonatomic,strong) UIView *bottomView;// 底部view
//@property (nonatomic,strong) UIButton *addCartButton;// 加入购物车按钮
//@property (nonatomic,strong) UIButton *cancleCollectionButton;// 取消收藏按钮
//
//@property (nonatomic,strong) UIButton *cancleCollectionSecondCar;

//@property (nonatomic,assign) NSInteger selectCount;

@end

@implementation MyCollectionTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _productCollectionArray = [NSMutableArray array];
    _serviceCollectionArray = [NSMutableArray array];
    _secondCarCollectionArray = [NSMutableArray array];
    
    [self fetchAllCollectionDataWithType:1];
    
    self.tableView.rowHeight = 0.2 * KScreenWidth + 2 * Klength5;
    
    [self creatTitleView];


}



- (void)creatTitleView
{
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"商品",@"服务",@"车辆"]];
    self.segment.frame = CGRectMake(0, 0, 120, Klength30);
    
    self.segment.tintColor = [UIColor whiteColor];
    
    NSDictionary *normalDic = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *selectedDic = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.segment setTitleTextAttributes:normalDic forState:(UIControlStateNormal)];
    [self.segment setTitleTextAttributes:selectedDic forState:(UIControlStateSelected)];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:Font16 forKey:NSFontAttributeName];
    [self.segment setTitleTextAttributes:attributes forState:(UIControlStateNormal)];
    
    self.segment.selectedSegmentIndex = 0;
    
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:(UIControlEventValueChanged)];
    
    self.navigationItem.titleView = self.segment;
}



- (void)segmentChange:(UISegmentedControl *)segment
{
    switch (self.segment.selectedSegmentIndex)
    {
        case 0:
        {
            YYLog(@"商品");
            
//            [self.cancleCollectionSecondCar removeFromSuperview];
            
            [self fetchAllCollectionDataWithType:1];
        }
            break;
        case 1:
        {
            YYLog(@"服务");
            
//            [self.cancleCollectionSecondCar removeFromSuperview];
            
            [self fetchAllCollectionDataWithType:2];
        }
            break;
        case 2:
        {
            YYLog(@"二手车");
            
//            [self creatCancleCollectionSecondCarButton];
            
            [self fetchAllCollectionDataWithType:3];
        }
            break;
            
        default:
            break;
    }
}




#pragma mark - 获取收藏信息
- (void)fetchAllCollectionDataWithType:(NSInteger)type
{
    NSString *url = [NSString stringWithFormat:@"%@getallcollectionservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    NSString *collectionType = [NSString stringWithFormat:@"%ld",type];
    parameters[@"currentPage"] = @(0);
//    if ([self.title isEqualToString:@"保养维护详情"])
//    {
//        type = 2;
//    }
//    else if ([self.title isEqualToString:@"商品详情"])
//    {
//        type = 1;
//    }
//    else
//    {
//        type = 3;
//    }
    parameters[@"type"] = @(type);
    
    YYLog(@"sessionid===%@",sessionid);
    YYLog(@"获取指定用户的全部收藏物的parameters===%@",parameters);
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"获取指定用户的全部收藏物请求返回-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result == 1000)
        {
            if ([collectionType isEqualToString:@"1"])
            {
                self.productCollectionArray = [ProductModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            }
            if ([collectionType isEqualToString:@"2"])
            {
                self.serviceCollectionArray = [ServiceModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            }
            if ([collectionType isEqualToString:@"3"])
            {
                self.secondCarCollectionArray = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            }
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"获取指定用户的全部收藏物请求失败-%@",error);
        
    }];
}



#pragma mark - 视图即将出现时调用
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
//    [self creatCartAndCancleCollection];
    
}



#pragma mark - 视图将要消失时调用
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self.bottomView removeFromSuperview];
//
//    [self.cancleCollectionSecondCar removeFromSuperview];
    
}



#pragma mark - 创建加入购物车和取消收藏按钮
//- (void)creatCartAndCancleCollection
//{
//    CGFloat bottomViewY = KScreenHeight - Klength44;
//    if (!self.bottomView)
//    {
//        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomViewY, KScreenWidth, Klength44)];
//        [[UIApplication sharedApplication].keyWindow addSubview:self.bottomView];
//    }
//    
//    
//    CGFloat buttonWidth = KScreenWidth / 2;
//    self.addCartButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    self.addCartButton.frame = CGRectMake(0, 0, buttonWidth, Klength44);
//    [self.addCartButton setTitle:@"加入购物车" forState:(UIControlStateNormal)];
//    self.addCartButton.backgroundColor = [UIColor orangeColor];
//    [self.addCartButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//    [self.addCartButton addTarget:self action:@selector(addCartAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.bottomView addSubview:self.addCartButton];
//    
//    
//    
//    self.cancleCollectionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    self.cancleCollectionButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, Klength44);
//    [self.cancleCollectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
//    [self.cancleCollectionButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//    self.cancleCollectionButton.backgroundColor = [UIColor redColor];
//    [self.cancleCollectionButton addTarget:self action:@selector(cancleCollectionAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.bottomView addSubview:self.cancleCollectionButton];
//    
//}




//- (void)creatCancleCollectionSecondCarButton
//{
//    self.cancleCollectionSecondCar = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.cancleCollectionSecondCar.frame = CGRectMake(0, KScreenHeight - Klength44, KScreenWidth, Klength44);
//    self.cancleCollectionSecondCar.backgroundColor = [UIColor redColor];
//    [self.cancleCollectionSecondCar setTitle:@"取消收藏" forState:(UIControlStateNormal)];
//    [self.cancleCollectionSecondCar addTarget:self action:@selector(cancleCollectionSecondCarAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.cancleCollectionSecondCar];
//    
//}



- (void)cancleCollectionSecondCarAction
{
    [self cancleCollectionWithType:3];
}



#pragma mark - 加入购物车的点击事件
- (void)addCartAction
{
    [self addToCartDataWithType:1];// 调取加入购物车的接口
    
    YYLog(@"加入购物车");
}



- (void)addToCartDataWithType:(NSInteger)type
{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"productid"] = @(2);
    parameters[@"type"] = @(1);// 1:商品 2:服务
    parameters[@"count"] = @(type);
    
    YYLog(@"加入购物车参数：%@",parameters);
    
    NSString *url = [NSString stringWithFormat:@"%@add/shopping/car?",URL];
    
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"加入购物车返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"加入购物车错误：%@",error);
        
    }];
}



#pragma mark - 取消收藏的点击事件
- (void)cancleCollectionAction
{
    YYLog(@"取消收藏");
    
    if (self.segment.selectedSegmentIndex == 0)
    {
        [self cancleCollectionWithType:1];
    }
    else
    {
        [self cancleCollectionWithType:2];
    }
}



- (void)cancleCollectionWithType:(NSInteger)type
{
    NSString *url = [NSString stringWithFormat:@"%@canclecollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"productid"] = @"1";
    parameters[@"type"] = @(type);// 1:物品 2:服务
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"取消收藏请求返回-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result == 1000) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"取消收藏成功" title:@"提示"];
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"取消收藏失败" title:@"提示"];
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"取消收藏请求失败-%@",error);
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - Table view data source
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segment.selectedSegmentIndex == 0)
    {
        return _productCollectionArray.count;
    }
    else if (self.segment.selectedSegmentIndex == 1)
    {
        return _serviceCollectionArray.count;
    }
    else
    {
        return _secondCarCollectionArray.count;
    }
}



#pragma mark - 加载单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[CollectionCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }

    switch (self.segment.selectedSegmentIndex)
    {
        case 0:
        {
            ProductModel *productModel = _productCollectionArray[indexPath.row];
            
            NSArray *imagesArray = [productModel.images componentsSeparatedByString:@","];
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,imagesArray.firstObject]];
            [cell.productPic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
            cell.productNameLabel.text = productModel.productname;
            cell.productPriceLabel.text = [NSString stringWithFormat:@"%@星币",productModel.scoreprice];

        }
            break;
        case 1:
        {
            ServiceModel *serviceModel = _serviceCollectionArray[indexPath.row];
            
            NSArray *imagesArray = [serviceModel.images componentsSeparatedByString:@","];
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,imagesArray.firstObject]];
            [cell.productPic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
            cell.productNameLabel.text = serviceModel.services;
            cell.productPriceLabel.text = [NSString stringWithFormat:@"%@星币",serviceModel.scoreprice];

        }
            break;
        case 2:
        {
            CarModel *carModel = _secondCarCollectionArray[indexPath.row];
            
            NSArray *imagesArray;
            imagesArray = [carModel.images componentsSeparatedByString:@","];
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,imagesArray.firstObject]];
            [cell.productPic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
            cell.productNameLabel.text = carModel.brand;
            cell.productPriceLabel.text = [NSString stringWithFormat:@"%@星币",carModel.price];
            
        }
            break;
            
        default:
            break;
    }
    
//    [cell.selectButton addTarget:self action:@selector(selectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionProductDetailTableVC *collectionProductDetailTableVC = [[CollectionProductDetailTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    
    switch (self.segment.selectedSegmentIndex)
    {
        case 0:
        {
            collectionProductDetailTableVC.title = @"商品详情";
            collectionProductDetailTableVC.productModel = _productCollectionArray[indexPath.row];
        }
            break;
        case 1:
        {
            collectionProductDetailTableVC.title = @"保养维护详情";
            collectionProductDetailTableVC.serviceModel = _serviceCollectionArray[indexPath.row];
        }
            break;
        case 2:
        {
            collectionProductDetailTableVC.title = @"二手车详情";
            collectionProductDetailTableVC.carModel = _serviceCollectionArray[indexPath.row];
        }
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:collectionProductDetailTableVC animated:YES];
}





//- (void)selectAction:(UIButton *)button
//{
//    button.selected = !button.selected;
//    
//    CollectionModel *collectionModel = _collectionArray[button.tag];
//    collectionModel.selectedBtn = button.selected;
//    
////    self.selectCount = 0;
//    
//    for (collectionModel in _collectionArray)
//    {
//        if (collectionModel.selectedBtn && self.selectCount < _collectionArray.count)
//        {
//            self.selectCount++;
//        }
//    }
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        [self.tableView reloadData];
//        
//    });
//}





@end

























