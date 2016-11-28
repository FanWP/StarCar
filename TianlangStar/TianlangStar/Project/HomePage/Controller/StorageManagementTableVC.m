//
//  StorageManagementTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "StorageManagementTableVC.h"

#import "StorageManagementCell.h"

#import "StorageManagementModel.h"

#import "EditProductAndPublishTableVC.h"


@interface StorageManagementTableVC ()

@property (nonatomic,strong) UISegmentedControl *segment;

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIButton *allSelectedImageButton;
@property (nonatomic,strong) UILabel *allSelectedLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UILabel *statusLabel;

@property (nonatomic,strong) UIButton *putawayAndSoldoutButton;

@property (nonatomic,assign) NSInteger pageNum;

@property (nonatomic,strong) NSMutableArray *storageArray;

@property (nonatomic,strong) NSMutableArray *moreStorageArray;

@end

@implementation StorageManagementTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    
    [self creatTitleView];// 导航栏的选择title
    
    [self creatHeaderView];
    
    [self pullOnLoading];
    
    [self dropdownRefresh];
    
    [self fetchPutawayAndSoldoutDataWithType:1];
    
}


- (NSMutableArray *)storageArray
{
    if (!_storageArray)
    {
        _storageArray = [NSMutableArray array];
    }
    
    return _storageArray;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self creatPutawayAndSoldoutButton];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.putawayAndSoldoutButton removeFromSuperview];
}



- (void)creatTitleView
{
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"上架",@"下架"]];
    self.segment.frame = CGRectMake(0, 10, 120, 30);
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:(UIControlEventValueChanged)];
    self.segment.apportionsSegmentWidthsByContent = YES;
    
    self.segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.segment;
}



- (void)segmentChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex)
    {
        case 0:
            YYLog(@"上架");
            break;
        case 1:
            YYLog(@"下架");
            break;
            
        default:
            break;
    }
}



- (void)fetchPutawayAndSoldoutDataWithType:(NSInteger)type
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    self.pageNum = 1;
    
    parmas[@"pageNum"]  = @(self.pageNum);
    parmas[@"pageSize"] = @"10";
    parmas[@"type"]  = @"1";

    YYLog(@"仓库管理参数parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@find/products/list?",URL];
    
    [[AFHTTPSessionManager manager] GET:url parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        
        YYLog(@"仓库管理返回%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            self.pageNum++;
            self.storageArray = [StorageManagementModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"仓库管理错误%@",error);
    }];

}


// 下拉刷新
- (void)dropdownRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.storageArray removeAllObjects];
        
        [self fetchPutawayAndSoldoutDataWithType:1];

        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    }];
    
}



// 上拉加载
- (void)pullOnLoading
{
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        
        self.pageNum = 1;
        
        parmas[@"pageNum"]  = @(self.pageNum);
        parmas[@"pageSize"] = @"10";
        parmas[@"type"]  = @"1";
        
        YYLog(@"仓库管理参数parmas--%@",parmas);
        
        NSString *url = [NSString stringWithFormat:@"%@find/products/list?",URL];
        
        [[AFHTTPSessionManager manager] GET:url parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             YYLog(@"仓库管理返回%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 self.pageNum++;
                 self.moreStorageArray = [StorageManagementModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
                 [self.storageArray addObjectsFromArray:self.moreStorageArray];
                 
                 [self.tableView reloadData];
                 
                 [self.tableView.mj_footer endRefreshing];
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             YYLog(@"仓库管理错误%@",error);
         }];

    }];
    
}



- (void)creatHeaderView
{
    CGFloat height = 50;
    
    CGFloat top = 10;
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, height)];
    self.headerView.backgroundColor = BGcolor;
    
    CGFloat allSelectedImageButtonX = 15;
    CGFloat allSelectedImageButtonWidth = 20;
    CGFloat allSelectedImageButtonY = (height / 2) - (allSelectedImageButtonWidth / 2);
    self.allSelectedImageButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.allSelectedImageButton.frame = CGRectMake(allSelectedImageButtonX, allSelectedImageButtonY, allSelectedImageButtonWidth, allSelectedImageButtonWidth);
    [self.allSelectedImageButton setImage:[UIImage imageNamed:@"unselected"] forState:(UIControlStateNormal)];
    [self.allSelectedImageButton setImage:[UIImage imageNamed:@"selected"] forState:(UIControlStateSelected)];
    [self.allSelectedImageButton addTarget:self action:@selector(allSelectedImageAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headerView addSubview:self.allSelectedImageButton];
    
    
    
    
    CGFloat allSelectedLabelX = allSelectedImageButtonX + allSelectedImageButtonWidth;
    CGFloat allSelectedLabelWidth = 40;
    self.allSelectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(allSelectedLabelX, top, allSelectedLabelWidth, Klength30)];
    self.allSelectedLabel.text = @"全选";
    [self.headerView addSubview:self.allSelectedLabel];
    
    
    CGFloat nameLabelX = allSelectedLabelX + allSelectedLabelWidth + 50;
    
    CGFloat width = (KScreenWidth - nameLabelX - allSelectedImageButtonX);
    
    CGFloat nameLabelWidth = 0.4 * width;
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, top, nameLabelWidth, Klength30)];
    self.nameLabel.text = @"名称";
    [self.headerView addSubview:self.nameLabel];
    
    
    
    CGFloat countLabelX = nameLabelX + nameLabelWidth;
    CGFloat countLabelWidth = 0.3 * width;
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(countLabelX, top, countLabelWidth, Klength30)];
    self.countLabel.text = @"库存";
    [self.headerView addSubview:self.countLabel];
    
    
    
    CGFloat statusLabelX = countLabelX + countLabelWidth;
    CGFloat statusLabelWidth = 0.3 * width;
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(statusLabelX, top, statusLabelWidth, Klength30)];
    self.statusLabel.text = @"状态";
    [self.headerView addSubview:self.statusLabel];
    
//    self.nameLabel.backgroundColor = [UIColor redColor];
//    self.countLabel.backgroundColor = [UIColor cyanColor];
//    self.statusLabel.backgroundColor = [UIColor orangeColor];
    
    self.tableView.tableHeaderView = self.headerView;
}



- (void)allSelectedImageAction:(UIButton *)button
{
    
}



- (void)creatPutawayAndSoldoutButton
{
    CGFloat putawayAndSoldoutButtonY = KScreenHeight - 44;
    
    self.putawayAndSoldoutButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.putawayAndSoldoutButton.frame = CGRectMake(0, putawayAndSoldoutButtonY, KScreenWidth, 44);
    self.putawayAndSoldoutButton.backgroundColor = [UIColor blueColor];
    [self.putawayAndSoldoutButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.putawayAndSoldoutButton addTarget:self action:@selector(putawayAndSoldoutAction) forControlEvents:(UIControlEventTouchUpInside)];
   
    
    switch (self.segment.selectedSegmentIndex)
    {
        case 0:
            [self.putawayAndSoldoutButton setTitle:@"上架" forState:(UIControlStateNormal)];
            break;
        case 1:
            [self.putawayAndSoldoutButton setTitle:@"下架" forState:(UIControlStateNormal)];
            break;
            
        default:
            break;
    }
    
     [[UIApplication sharedApplication].keyWindow addSubview:self.putawayAndSoldoutButton];
    
}


- (void)putawayAndSoldoutAction
{
    switch (self.segment.selectedSegmentIndex)
    {
        case 0:
            [self fetchPutawayAndSoldoutWithType:1];
            break;
        case 1:
            [self fetchPutawayAndSoldoutWithType:2];
            break;
            
        default:
            break;
    }
}



- (void)fetchPutawayAndSoldoutWithType:(NSInteger)type
{
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"productIds"]  = @"1";
    NSString *shelves = [NSString stringWithFormat:@"%ld",type];
    parmas[@"shelves"] = shelves;
    
    YYLog(@"上架下架参数parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@update/products/shelves?",URL];
    
    [[AFHTTPSessionManager manager] GET:url parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"上架下架返回%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"上架下架错误%@",error);
    }];

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
//    return _storageArray.count;
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    StorageManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[StorageManagementCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.nameLabel.text = @"商品名称";
    cell.countLabel.text = @"商品库存";
    cell.statusLabel.text = @"商品状态";

    
//    StorageManagementModel *storageManagementModel = _storageArray[indexPath.row];
//    
//    cell.nameLabel.text = storageManagementModel.productname;
//    cell.countLabel.text = storageManagementModel.inventory;
//    cell.statusLabel.text = storageManagementModel.saleState;

    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditProductAndPublishTableVC *editProductAndPublishTableVC = [[EditProductAndPublishTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    
    StorageManagementModel *model = _storageArray[indexPath.row];
    
    editProductAndPublishTableVC.storageManagementModel = model;
        
    [self.navigationController pushViewController:editProductAndPublishTableVC animated:YES];
}




@end
