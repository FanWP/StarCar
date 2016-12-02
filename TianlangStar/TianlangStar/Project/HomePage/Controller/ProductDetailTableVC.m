//
//  ProductDetailTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/12/2.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ProductDetailTableVC.h"

#import "ProductModel.h"
#import "ServiceModel.h"
#import "CarModel.h"
#import "UserInfo.h"

#import "CollectionModel.h"

@interface ProductDetailTableVC ()<SDCycleScrollViewDelegate>

// scrollView
@property (nonatomic,strong) SDCycleScrollView *scrollView;
// 轮播图
@property (nonatomic,strong) UIView *headerView;

@property (nonatomic,strong) NSMutableArray *imagesArray;

@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *collectionButton;
@property (nonatomic,strong) UIButton *addCartButton;
@property (nonatomic,strong) UIButton *buyButton;
@property (nonatomic,strong) UIButton *chatButton;

@property (nonatomic,copy) NSString *productId;


@property (nonatomic,strong) UserInfo *userInfo;
/** 收藏状态 */
@property (nonatomic,assign) BOOL isCollection;
/** 收藏model */
@property (nonatomic,strong) CollectionModel *collectionModel;
/** 保存数据模型 */
@property (nonatomic,strong) NSMutableArray *collectionArray;
/** 保存已收藏所有商品id */
@property (nonatomic,strong) NSMutableArray *collectionIdArray;

@end

@implementation ProductDetailTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatHeaderView];
    
    [self creatFootView];
    
    [self rightItem];
    
    if ([self.title isEqualToString:@"商品详情"])
    {
        self.productId = _productModel.ID;
    }
    else if ([self.title isEqualToString:@"保养维护详情"])
    {
        self.productId = _serviceModel.ID;
    }
    else
    {
        self.productId = _carModel.carid;
    }
}



- (void)rightItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareAction)];
}



- (void)shareAction
{
    
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self.bottomView removeFromSuperview];
}



#pragma mark - 轮播图
- (void)creatHeaderView
{
    NSString *images = _productModel.images;
    
    NSArray *array = [images componentsSeparatedByString:@","];
    
    for (NSInteger i = 0; i < array.count; i++)
    {
        NSString *pic = array[i];
        
        NSString *image = [NSString stringWithFormat:@"%@%@",picURL,pic];
        
        [_imagesArray addObject:image];
    }
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.25 * KScreenHeight)];
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, 0.25 * KScreenHeight) imageNamesGroup:self.imagesArray];
    _scrollView.delegate = self;
    _scrollView.placeholderImage = [UIImage imageNamed:@"touxiang"];
    _scrollView.autoScrollTimeInterval = 2.0;
    [_headerView addSubview:_scrollView];
    self.tableView.tableHeaderView = _headerView;
}




- (void)creatFootView
{
    CGFloat bottomViewY = KScreenHeight - Klength44;
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomViewY, KScreenWidth, Klength44)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bottomView];
    
    
    CGFloat buttonWidth = KScreenWidth / 3;
    
    
    self.collectionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.collectionButton.frame = CGRectMake(0, 0, buttonWidth, Klength44);
    [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
    
    
    
    self.addCartButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.addCartButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, Klength44);
    [self.addCartButton setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    
    
    
    self.buyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.buyButton.frame = CGRectMake(2 * buttonWidth, 0, buttonWidth, Klength44);
    [self.buyButton setTitle:@"立即购买" forState:(UIControlStateNormal)];

    
    self.chatButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.chatButton.frame = CGRectMake(KScreenWidth / 2, 0, KScreenWidth / 2, Klength44);
    [self.chatButton setTitle:@"咨询" forState:(UIControlStateNormal)];
    [self.chatButton addTarget:self action:@selector(chatAction) forControlEvents:(UIControlEventTouchUpInside)];

    
    if ([self.title isEqualToString:@"二手车详情"])
    {
        self.collectionButton.frame = CGRectMake(0, 0, KScreenWidth / 2, Klength44);
        [self.bottomView addSubview:self.collectionButton];
        
        [self.bottomView addSubview:self.chatButton];
    }
    else
    {
        [self.bottomView addSubview:self.collectionButton];
        [self.bottomView addSubview:self.addCartButton];
        [self.bottomView addSubview:self.buyButton];
    }
    
    
    
    self.collectionButton.backgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:26.0 / 255.0 blue:2.0 / 255.0 alpha:1];
    self.addCartButton.backgroundColor =[UIColor colorWithRed:255.0 / 255.0 green:148.0 / 255.0 blue:2.0 / 255.0 alpha:1];
    self.buyButton.backgroundColor = [UIColor colorWithRed:8.0 / 255.0 green:125.0 / 255.0 blue:255.0 / 255.0 alpha:1];
    self.chatButton.backgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:148.0 / 255.0 blue:2.0 / 255.0 alpha:1];
    
    
    [self.collectionButton addTarget:self action:@selector(collectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.addCartButton addTarget:self action:@selector(addCartAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buyButton addTarget:self action:@selector(buyAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.chatButton addTarget:self action:@selector(chatAction) forControlEvents:(UIControlEventTouchUpInside)];
}



- (void)collectionAction
{
    YYLog(@"收藏");
    
//    add/favorite?
    
    if (self.userInfo.isLogin)
    {
        NSString *url = [NSString stringWithFormat:@"%@getallcollectionservlet",URL];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
        parameters[@"sessionId"] = sessionid;
        
        [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSNumber *num = responseObject[@"resultCode"];
            NSInteger result = [num integerValue];
            
            NSArray *array = responseObject[@"body"];
            
            CollectionModel *collectionModel = [[CollectionModel alloc] init];
            
            if (result == 1000)
            {
                
                for (NSDictionary *dic in array)
                {
                    [collectionModel setValuesForKeysWithDictionary:dic];
                    [self.collectionArray addObject:collectionModel];
                    [self.collectionIdArray addObject:collectionModel.productid];
                }
                
                YYLog(@"self.collectionModel.productid:%@",collectionModel.productid);
                
                // 收藏过的数据里包含这个id则取消收藏  collectionModel.productid
                if ([self.collectionIdArray containsObject:collectionModel.productid])
                {
                    // 取消收藏
                    [self cancleCollectionActionWithType:1];
                    
                }
                // 否则添加收藏
                else
                {
                    // 添加收藏
                    [self addCollectionActionWithType:1];
                    
                }
                
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            YYLog(@"获取指定用户的全部收藏物请求失败-%@",error);
            
        }];
        
    }
    else
    {
        // 提示用户先登录
        [[AlertView sharedAlertView] loginAction];
    }
}



#pragma mark - 添加收藏
/**
 *  添加收藏
 */
- (void)addCollectionActionWithType:(NSInteger)type
{
    NSString *url = [NSString stringWithFormat:@"%@addtocollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"id"] = self.productId;
    parameters[@"type"] = @(type);// 1:物品 2:服务
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"添加收藏请求返回-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"收藏成功" title:@"提示"];
                
                [self.collectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
                
                self.isCollection = YES;
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAlertMessage:@"收藏失败" title:@"提示"];
            });
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"添加收藏请求失败-%@",error);
        
    }];
}



#pragma mark - 取消收藏
/**
 *  取消收藏
 */
- (void)cancleCollectionActionWithType:(NSInteger)type
{
    NSString *url = [NSString stringWithFormat:@"%@canclecollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"productid"] = self.productId;
    parameters[@"type"] = @(type);// 1:物品 2:服务
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"取消收藏请求返回-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result == 1000) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"取消收藏成功" title:@"提示"];
                
                [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
                
                self.isCollection = NO;
                
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



#pragma mark - 获取指定用户的全部收藏物
/**
 *  获取指定用户的全部收藏物的点击事件
 */
- (void)allCollectionAction
{
    NSString *url = [NSString stringWithFormat:@"%@getallcollectionservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    
    YYLog(@"sessionid===%@",sessionid);
    YYLog(@"获取指定用户的全部收藏物的parameters===%@",parameters);
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"获取指定用户的全部收藏物请求返回-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        NSArray *array = responseObject[@"body"];
        
        CollectionModel *collectionModel = [[CollectionModel alloc] init];
        
        if (result == 1000)
        {
            for (NSDictionary *dic in array) {
                
                [collectionModel setValuesForKeysWithDictionary:dic];
                [self.collectionIdArray addObject:collectionModel.productid];
            }
            
            // 收藏过的数据里包含这个id则显示取消收藏 self.collectionModel.ID
            if ([self.collectionIdArray containsObject:collectionModel.productid])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // 取消收藏
                    [self.collectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
                });
            }
            // 否则显示添加收藏
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // 添加收藏
                    [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
                    
                });
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"获取指定用户的全部收藏物请求失败-%@",error);
        
    }];
}




- (void)addCartAction
{
    YYLog(@"加入购物车");
    
//    add/shopping/car?
//    type  userid  productid  count
    
}



- (void)buyAction
{
    YYLog(@"立即购买");
}



- (void)chatAction
{
    YYLog(@"咨询");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.title isEqualToString:@"商品详情"])
    {
        return 9;
    }
    else if ([self.title isEqualToString:@"保养维护详情"])
    {
        return 6;
    }
    else
    {
        return 9;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    if ([self.title isEqualToString:@"商品详情"])
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = _productModel.brand;
                break;
            case 1:
                cell.textLabel.text = [NSString stringWithFormat:@"%@星币",_productModel.price];
                break;
            case 2:
                cell.textLabel.text = [NSString stringWithFormat:@"类型：%@",_productModel.productmodel];
                break;
            case 3:
                cell.textLabel.text = [NSString stringWithFormat:@"规格：%@",_productModel.specifications];
                break;
            case 4:
                cell.textLabel.text = [NSString stringWithFormat:@"适用车型：%@",_productModel.applycar];
                break;
            case 5:
                cell.textLabel.text = [NSString stringWithFormat:@"供应商：%@",_productModel.vendors];
                break;
            case 6:
                cell.textLabel.text = [NSString stringWithFormat:@"简介：%@",_productModel.introduction];
                break;
            case 7:
                cell.textLabel.text = [NSString stringWithFormat:@"备注：%@",_productModel.remark];
                break;
                
            default:
                break;
        }
    }
    else if ([self.title isEqualToString:@"保养维护详情"])
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = _serviceModel.services;
                break;
            case 1:
                cell.textLabel.text = [NSString stringWithFormat:@"%@星币",_serviceModel.price];
                break;
            case 2:
                cell.textLabel.text = [NSString stringWithFormat:@"类型：%@",_serviceModel.servicetype];
                break;
            case 3:
                cell.textLabel.text = [NSString stringWithFormat:@"服务内容：%@",_serviceModel.content];
                break;
            case 4:
                cell.textLabel.text = [NSString stringWithFormat:@"保修期限：%@",_serviceModel.warranty];
                break;
            case 5:
                cell.textLabel.text = [NSString stringWithFormat:@"预计耗时：%@",_serviceModel.manhours];
                break;
        }
    }
    else
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = _carModel.brand;
                break;
            case 1:
                cell.textLabel.text = [NSString stringWithFormat:@"%@万",_carModel.price];
                break;
            case 2:
                cell.textLabel.text = [NSString stringWithFormat:@"型号：%@",_carModel.model];
                break;
            case 3:
                cell.textLabel.text = [NSString stringWithFormat:@"行驶里程：%@",_carModel.mileage];
                break;
            case 4:
                cell.textLabel.text = [NSString stringWithFormat:@"购买年份：%@",_carModel.buytime];
                break;
            case 5:
                cell.textLabel.text = [NSString stringWithFormat:@"原车主：%@",_carModel.person];
                break;
            case 6:
                cell.textLabel.text = [NSString stringWithFormat:@"车牌号：%@",_carModel.number];
                break;
            case 7:
                cell.textLabel.text = [NSString stringWithFormat:@"车架号：%@",_carModel.frameid];
                break;
            case 8:
                cell.textLabel.text = [NSString stringWithFormat:@"使用性质：%@",_carModel.property];
                break;
            case 9:
                cell.textLabel.text = [NSString stringWithFormat:@"车辆简介：%@",_carModel.carDescription];
                break;

            default:
                break;
        }
    }
    

    return cell;
}




- (NSMutableArray *)imagesArray
{
    if (!_imagesArray)
    {
        _imagesArray = [NSMutableArray array];
        
    }
    
    return _imagesArray;
}





- (ProductModel *)productModel
{
    if (!_productModel)
    {
        _productModel = [[ProductModel alloc] init];
    }
    
    return _productModel;
}




- (ServiceModel *)serviceModel
{
    if (!_serviceModel)
    {
        _serviceModel = [[ServiceModel alloc] init];
    }
    
    return _serviceModel;
}



- (CarModel *)carModel
{
    if (!_carModel)
    {
        _carModel = [[CarModel alloc] init];
    }
    
    return _carModel;
}




- (CollectionModel *)collectionModel
{
    if (!_collectionModel)
    {
        _collectionModel = [[CollectionModel alloc] init];
    }
    
    return _collectionModel;
}




- (NSMutableArray *)collectionArray
{
    if (!_collectionArray)
    {
        _collectionArray = [NSMutableArray array];
    }
    
    return _collectionArray;
}




- (NSMutableArray *)collectionIdArray
{
    if (!_collectionIdArray)
    {
        _collectionIdArray = [NSMutableArray array];
    }
    
    return _collectionIdArray;
}




@end



















