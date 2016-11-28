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
#import "ProductCell.h"
#import "ProductPublishTableVC.h"


@interface HomePageTableVC ()<UISearchResultsUpdating,SDCycleScrollViewDelegate>

// 搜索框
@property (nonatomic,strong) UISearchController *search;
// scrollView
@property (nonatomic,strong) SDCycleScrollView *scrollView;
// 轮播图
@property (nonatomic,strong) UIView *headerView;
// 商品数组
@property (nonatomic,strong) NSMutableArray *productsArray;

@end

@implementation HomePageTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSearchController];// 添加搜索框
    
    [self shareItem];// 分享app
    
    [self creatHeaderView];// 轮播图
    
    [self fetchProductInfoWithType:3];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"商品发布" style:(UIBarButtonItemStylePlain) target:self action:@selector(productPublishAction)];
}



- (void)productPublishAction
{
    ProductPublishTableVC *productPublishTableVC = [[ProductPublishTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    
    [self.navigationController pushViewController:productPublishTableVC animated:YES];
}



- (NSMutableArray *)productsArray
{
    if (!_productsArray)
    {
        _productsArray = [NSMutableArray array];
    }
    
    return _productsArray;
}



- (void)fetchProductInfoWithType:(NSInteger)type
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"]  = @"1";
    NSString *productType = [NSString stringWithFormat:@"%ld",type];
    parmas[@"type"]  = productType;
    
    YYLog(@"获取所有商品列表parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@getcommodityinfoservlet",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"获取所有商品列表-%@",json);
         
         self.productsArray = [ProductModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         
         ProductModel *model = self.productsArray[0];
         
         YYLog(@"model---%ld",(long)model.scoreprice);
         
         [self.tableView reloadData];
         
     } failure:^(NSError *error) {
         
         YYLog(@"获取所有商品列表错误%@",error);
         
     }];
}



#pragma mark - 分享app的按钮
- (void)shareItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareTLStarAction)];
}



#pragma mark - 分享app的点击事件
- (void)shareTLStarAction
{
    YYLog(@"分享app给朋友");
}



#pragma mark - 搜索框
- (void)addSearchController
{
    self.search = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.search.searchResultsUpdater = self;
    self.search.dimsBackgroundDuringPresentation = false;
    [self.search.searchBar sizeToFit];
    self.search.searchBar.placeholder = @"搜索商品";
    self.navigationItem.titleView = self.search.searchBar;
    
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",self.search.searchBar.text];
}



#pragma mark - 轮播图
- (void)creatHeaderView
{
    UIImage *image1 = [UIImage imageNamed:@"lunbo1"];
    UIImage *image2 = [UIImage imageNamed:@"lunbo2"];
    UIImage *image3 = [UIImage imageNamed:@"lunbo3"];
    NSArray *imagesArray = @[image1,image2,image3];
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.25 * KScreenHeight)];
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, 0.25 * KScreenHeight) imageNamesGroup:imagesArray];
    _scrollView.delegate = self;
    _scrollView.placeholderImage = [UIImage imageNamed:@"lunbo2"];
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
        YYLog(@"车辆信息个数%ld",self.productsArray.count);
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
        return 44;
    }
    else
    {
        return 40;
    }
}



#pragma mark - 返回最新活动的cell
- (UITableViewCell *)tableView:(UITableView *)tableView newestActivityCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    cell.textLabel.text = @"最新活动";
    cell.textLabel.textAlignment = 1;
    
    return cell;
}



#pragma mark - 返回保养维护、商品、车辆信息的cell
- (HomePageSelectCell *)tableView:(UITableView *)tableView selectCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"cell1";
    
    HomePageSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    
    if (cell == nil)
    {
        
        cell = [[HomePageSelectCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
        
    }
    
    [cell.maintenanceButton setTitle:@"保养维护" forState:(UIControlStateNormal)];
    [cell.maintenanceButton addTarget:self action:@selector(maintenanceAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [cell.productButton setTitle:@"商品" forState:(UIControlStateNormal)];
    [cell.productButton addTarget:self action:@selector(productAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [cell.carInfoButton setTitle:@"车辆信息" forState:(UIControlStateNormal)];
    [cell.carInfoButton addTarget:self action:@selector(carInfoAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    return cell;

}



#pragma mark - 返回保养维护的cell
- (UITableViewCell *)tableView:(UITableView *)tableView maintenanceCellWithIndexPatch:(NSIndexPath *)indexPatch
{
    static NSString *identifier2 = @"cell2";
    
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    
    if (cell == nil)
    {
        
        cell = [[ProductCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier2];
        
    }

    
//    static NSString *identifier2 = @"cell2";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
//    
//    if (cell == nil)
//    {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier2];
//        
//    }
//    
//    cell.textLabel.text = @"保养维护的cell";
    
    return cell;
}
#pragma mark - 返回商品的cell
- (UITableViewCell *)tableView:(UITableView *)tableView productCellWithIndexPatch:(NSIndexPath *)indexPatch
{
    static NSString *identifier3 = @"cell3";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier3];
        
    }
    
    cell.textLabel.text = @"商品的cell";
    
    return cell;
}
#pragma mark - 返回车辆信息的cell
- (UITableViewCell *)tableView:(UITableView *)tableView carInfoCellWithIndexPatch:(NSIndexPath *)indexPatch
{
    static NSString *identifier4 = @"cell4";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier4];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier4];
        
    }
    
    cell.textLabel.text = @"车辆信息的cell";
    
    return cell;
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
        return [self tableView:tableView maintenanceCellWithIndexPatch:indexPath];
    }
}



#pragma mark - 保养维护的点击事件
- (void)maintenanceAction
{
    YYLog(@"保养维护的点击事件");
}



#pragma mark - 商品的点击事件
- (void)productAction
{
    YYLog(@"商品的点击事件");
}



#pragma mark - 车辆信息的点击事件
- (void)carInfoAction
{
    YYLog(@"车辆信息的点击事件");
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NewestActivityTableVC *newestActivityTableVC = [[NewestActivityTableVC alloc] initWithStyle:(UITableViewStylePlain)];
        [self.navigationController pushViewController:newestActivityTableVC animated:YES];
    }
}



@end






































