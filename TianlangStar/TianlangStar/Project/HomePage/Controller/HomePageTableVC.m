//
//  HomePageTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "HomePageTableVC.h"
#import "NewestActivityTableVC.h" // 最新活动头文件
#import "HomePageSelectCell.h" // 保养维护、商品、车辆信息的自定义cell
#import "ProductModel.h" // 商品模型
#import "ServiceModel.h"
#import "CarModel.h"
#import "ProductCell.h"
#import "ProductPublishTableVC.h"
#import "NewActivityCell.h"
#import "HomePageSegmentCell.h"
#import "NewActivityModel.h"
#import "TopPicBottomLabelButton.h"
#import "MaintenanceAndProductCell.h"
#import "SecondCarCell.h"

#import "ProductDetailTableVC.h"

@interface HomePageTableVC ()<SDCycleScrollViewDelegate>

// 搜索框
@property (nonatomic,strong) UISearchController *search;
// scrollView
@property (nonatomic,strong) SDCycleScrollView *scrollView;
// 轮播图
@property (nonatomic,strong) UIView *headerView;

// 最新活动的标题
@property (nonatomic,copy) NSString *activityTitle;

// 保养维护数组
@property (nonatomic,strong) NSMutableArray *serviceArray;
// 商品数组
@property (nonatomic,strong) NSMutableArray *productsArray;
// 二手车数组
@property (nonatomic,strong) NSMutableArray *secondCarArray;

@property (nonatomic,strong) NSArray *moreProductArray;

// 模型
@property (nonatomic,strong) ProductModel *productModel;
@property (nonatomic,strong) ServiceModel *serviceModel;
@property (nonatomic,strong) CarModel *carModel;


// 接收最新活动的数组
@property (nonatomic,strong) NSMutableArray *activityArray;

// 最新活动的模型
@property (nonatomic,strong) NewActivityModel *activityModel;

/** 图片数组的URL */
@property (nonatomic,strong) NSMutableArray *ImgList;

@property (nonatomic,assign) NSInteger pageNum;

@property (nonatomic,strong) HomePageSelectCell *homePageSelectCell;

@property (nonatomic,copy) NSString *telNumber;

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation HomePageTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchHomePageData];// 获取首页数据
    
    [self fetchProductInfoWithType:1];
    
    [self dropdownRefresh];
    
    [self pullOnLoading];
}




#pragma mark - 获取首页数据
- (void)fetchHomePageData
{
    NSString *url = [NSString stringWithFormat:@"%@unlogin/find/indexInfo",URL];
    
    
    [[AFHTTPSessionManager manager] POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"首页返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            NSDictionary *dic = responseObject[@"body"];
            
            // 轮播图数据
            NSArray *imageArray = dic[@"firstImages"];
            
            for (NSDictionary *dic in imageArray)
            {
                NSString *picture = [dic objectForKey:@"images"];
                
                NSArray *imagesArray = [picture componentsSeparatedByString:@","];
                
                for (NSInteger i = 0; i < imagesArray.count; i++)
                {
                    NSString *pic = imagesArray[i];
                    NSString *image = [NSString stringWithFormat:@"%@%@",picURL,pic];
                    [self.ImgList addObject:image];
                }
                
                [self creatHeaderView];
            }
            
            
            // 最新活动数据
            
            NSDictionary *dicc = [dic objectForKey:@"lastActivity"];
            self.activityTitle = dicc[@"title"];
            
            
            // 保养维护、商品、二手车数据
            //            NSArray *servicesListArray = dic[@"servicesList"];
            //
            //            _serviceArray = [ServiceModel mj_objectArrayWithKeyValuesArray:servicesListArray];
            
        }
        
        [self.tableView reloadData];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"首页返回错误: %@",error);
    }];
    

}



#pragma mark - 保养维护、商品、二手车数据
- (void)fetchProductInfoWithType:(NSInteger)type
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    self.pageNum = 1;
    
    parmas[@"pageNum"] = @(self.pageNum);
    parmas[@"pageSize"]  = @"10";
    NSString *productType = [NSString stringWithFormat:@"%ld",type];
    parmas[@"type"]  = productType;
    
    YYLog(@"获取所有商品列表参数--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@unlogin/find/saleinfo?",URL];
    
    
    [[AFHTTPSessionManager manager] POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"获取所有商品列表返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            self.pageNum++;
            
            if ([productType isEqualToString:@"1"])
            {
                _productsArray = [ServiceModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            }
            else if ([productType isEqualToString:@"2"])
            {
                _productsArray = [ProductModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            }
            else
            {
                _productsArray = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            }
        }
        
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"获取所有商品列表错误：%@",error);
        
    }];
}




// 下拉刷新
- (void)dropdownRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.productsArray removeAllObjects];
        
        if (self.homePageSelectCell.maintenanceButton.selected == YES)
        {
            [self fetchProductInfoWithType:1];
        }
        else if (self.homePageSelectCell.productButton.selected == YES)
        {
            [self fetchProductInfoWithType:2];
        }
        else
        {
            [self fetchProductInfoWithType:3];
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    }];
}




// 上拉加载
- (void)pullOnLoading
{
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        
        parmas[@"pageNum"] = @(self.pageNum);
        parmas[@"pageSize"]  = @"10";
        NSString *productType;
        if (self.homePageSelectCell.maintenanceButton.selected == YES)
        {
            productType = @"1";
        }
        else if (self.homePageSelectCell.productButton.selected == YES)
        {
            productType = @"2";
        }
        else
        {
            productType = @"3";
        }
        
        parmas[@"type"]  = productType;
        
        YYLog(@"获取所有商品列表参数--%@",parmas);
        
        NSString *url = [NSString stringWithFormat:@"%@unlogin/find/saleinfo?",URL];
        
        
        [[AFHTTPSessionManager manager] POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             YYLog(@"获取所有商品列表返回：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 self.pageNum++;
                 
                 if ([productType isEqualToString:@"1"])
                 {
                     _moreProductArray = [ServiceModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
                     
                     [_productsArray addObjectsFromArray:_moreProductArray];
                 }
                 else if ([productType isEqualToString:@"2"])
                 {
                     _moreProductArray = [ProductModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
                     
                     [_productsArray addObjectsFromArray:_moreProductArray];
                 }
                 else
                 {
                     _moreProductArray = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
                     
                     [_productsArray addObjectsFromArray:_moreProductArray];
                 }
             }
             
             [self.tableView reloadData];
             
             [self.tableView.mj_footer endRefreshing];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             YYLog(@"获取所有商品列表错误：%@",error);
             
         }];
    }];
}





#pragma mark - 分享app的点击事件
- (void)shareTLStarAction
{
    YYLog(@"分享app给朋友");
}



#pragma mark - 轮播图
- (void)creatHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.25 * KScreenHeight)];
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, 0.25 * KScreenHeight) imageNamesGroup:self.ImgList];
    _scrollView.delegate = self;
    _scrollView.placeholderImage = [UIImage imageNamed:@"touxiang"];
    _scrollView.autoScrollTimeInterval = 2.0;
    [_headerView addSubview:_scrollView];
    self.tableView.tableHeaderView = _headerView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 1;
    }
    else
    {
        return self.productsArray.count;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 40;
    }
    else if (indexPath.section == 1)
    {
        return 90;
    }
    else
    {
        return 120;
    }
}



#pragma mark - 返回最新活动的cell
- (UITableViewCell *)tableView:(UITableView *)tableView newestActivityCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    NewActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[NewActivityCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    cell.textLabel.text = self.activityTitle;
    cell.textLabel.textAlignment = 1;
    
    return cell;
}



#pragma mark - 返回保养维护、商品、车辆信息的cell
- (HomePageSelectCell *)tableView:(UITableView *)tableView selectCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"cell1";
    
    self.homePageSelectCell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    
    if (self.homePageSelectCell == nil)
    {
        
        self.homePageSelectCell = [[HomePageSelectCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
        
    }
    
    
    
    [self.homePageSelectCell.maintenanceButton addTarget:self action:@selector(maintenanceAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.homePageSelectCell.productButton addTarget:self action:@selector(productAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self.homePageSelectCell.carInfoButton addTarget:self action:@selector(carInfoAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return self.homePageSelectCell;

}



#pragma mark - 返回保养维护的cell
- (UITableViewCell *)tableView:(UITableView *)tableView maintenanceCellWithIndexPatch:(NSIndexPath *)indexPatch
{
    static NSString *identifier2 = @"cell2";
    
    MaintenanceAndProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    
    if (cell == nil)
    {
        
        cell = [[MaintenanceAndProductCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier2];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.homePageSelectCell.maintenanceButton.selected == YES)
    {
        ServiceModel *serviceModel = _productsArray[indexPatch.row];
        NSString *pic = [NSString stringWithFormat:@"%@%@",picURL,serviceModel.images];
        NSURL *url = [NSURL URLWithString:pic];
        [cell.pictureView sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"touxiang"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
        cell.titleLabel.text = serviceModel.services;
        cell.detailLabel.text = serviceModel.content;
        cell.priceLabel.text = [NSString stringWithFormat:@"星币%@",serviceModel.price];
        cell.priceLabel.font = Font14;

    }
    else
    {
        ProductModel *productModel = _productsArray[indexPatch.row];
        NSString *pic = [NSString stringWithFormat:@"%@%@",picURL,productModel.images];
        NSURL *url = [NSURL URLWithString:pic];
        [cell.pictureView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
        cell.titleLabel.text = productModel.productname;
        cell.detailLabel.text = productModel.introduction;
        cell.priceLabel.text = [NSString stringWithFormat:@"星币%@",productModel.price];
        
    }
    
    return cell;
}



#pragma mark - 返回车辆信息的cell
- (UITableViewCell *)tableView:(UITableView *)tableView carInfoCellWithIndexPatch:(NSIndexPath *)indexPatch
{
    static NSString *identifier4 = @"cell4";
    
    SecondCarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier4];
    
    if (cell == nil)
    {
        
        cell = [[SecondCarCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier4];
        
    }
    
    _carModel = _productsArray[indexPatch.row];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,_carModel.picture]];
    [cell.pictureView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    cell.carNameLabel.text = _carModel.brand;
    cell.carTypeLabel.text = [NSString stringWithFormat:@"车型:%@",_carModel.cartype];
    cell.mileageLabel.text = [NSString stringWithFormat:@"行驶里程:%@",_carModel.mileage];
    cell.buytimeLabel.text = [NSString stringWithFormat:@"购买年份:%@",_carModel.buytime];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@万",_carModel.price];
    
    self.telNumber = _carModel.telphone;
    
    [cell.chatButton addTarget:self action:@selector(chatAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}



- (void)chatAction
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.telNumber]];
    
    if (!_webView)
    {
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:phoneURL]];

}



#pragma mark - 加载单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [self tableView:tableView newestActivityCellWithIndexPath:indexPath];
    }
    else if (indexPath.section == 1)
    {
        return [self tableView:tableView selectCellWithIndexPath:indexPath];
    }
    else
    {
        if (self.homePageSelectCell.carInfoButton.selected == YES)
        {
            return [self tableView:tableView carInfoCellWithIndexPatch:indexPath];
        }
        else
        {
            return [self tableView:tableView maintenanceCellWithIndexPatch:indexPath];
        }
    }
}



#pragma mark - 保养维护的点击事件
- (void)maintenanceAction:(TopPicBottomLabelButton *)button
{
    button.selected = !button.selected;
    
    [self fetchProductInfoWithType:1];
    
    self.homePageSelectCell.productButton.selected = NO;
    self.homePageSelectCell.carInfoButton.selected = NO;
    
    YYLog(@"保养维护的点击事件");
}



#pragma mark - 商品的点击事件
- (void)productAction:(TopPicBottomLabelButton *)button
{
    button.selected = !button.selected;
    
    [self fetchProductInfoWithType:2];
    
    self.homePageSelectCell.maintenanceButton.selected = NO;
    self.homePageSelectCell.carInfoButton.selected = NO;
    
    YYLog(@"商品的点击事件");
}



#pragma mark - 车辆信息的点击事件
- (void)carInfoAction:(TopPicBottomLabelButton *)button
{
    button.selected = !button.selected;
    
    [self fetchProductInfoWithType:3];
    
    self.homePageSelectCell.maintenanceButton.selected = NO;
    self.homePageSelectCell.productButton.selected = NO;
    
    YYLog(@"车辆信息的点击事件");
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NewestActivityTableVC *newestActivityTableVC = [[NewestActivityTableVC alloc] initWithStyle:(UITableViewStylePlain)];
        
        [self.navigationController pushViewController:newestActivityTableVC animated:YES];
    }
    else
    {
        ProductDetailTableVC *productDetailTableVC = [[ProductDetailTableVC alloc] initWithStyle:(UITableViewStylePlain)];
        
        if (self.homePageSelectCell.maintenanceButton.selected == YES)
        {
            productDetailTableVC.title = @"保养维护详情";
            
            productDetailTableVC.serviceModel = _productsArray[indexPath.row];
        }
        else if (self.homePageSelectCell.productButton.selected == YES)
        {
            productDetailTableVC.title = @"商品详情";
            
            productDetailTableVC.productModel = _productsArray[indexPath.row];
        }
        else
        {
            productDetailTableVC.title = @"二手车详情";
            
            productDetailTableVC.carModel = _productsArray[indexPath.row];
        }
        
        [self.navigationController pushViewController:productDetailTableVC animated:YES];
    }
}








- (NSMutableArray *)ImgList
{
    if (!_ImgList)
    {
        _ImgList = [NSMutableArray array];
    }
    
    return _ImgList;
}



- (NSMutableArray *)serviceArray
{
    if (!_serviceArray)
    {
        _serviceArray = [NSMutableArray array];
    }
    
    return _serviceArray;
}


- (NSMutableArray *)productsArray
{
    if (!_productsArray)
    {
        _productsArray = [NSMutableArray array];
    }
    
    return _productsArray;
}



- (NSArray *)moreProductArray
{
    if (!_moreProductArray)
    {
        _moreProductArray = [NSArray array];
    }
    
    return _moreProductArray;
}



- (NSMutableArray *)secondCarArray
{
    if (!_secondCarArray)
    {
        _secondCarArray = [NSMutableArray array];
    }
    
    return _secondCarArray;
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



- (NewActivityModel *)activityModel
{
    if (!_activityModel)
    {
        _activityModel = [[NewActivityModel alloc] init];
    }
    
    return _activityModel;
}






@end






































