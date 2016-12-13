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

@property (nonatomic,assign) NSInteger selectCount;

@end

@implementation StorageManagementTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    
    [self creatTitleView];// 导航栏的选择title
    
    [self creatHeaderView];
    
    switch (self.segment.selectedSegmentIndex)
    {
        case 0:
            [self fetchPutawayAndSoldoutDataWithType:2];
            break;
        case 1:
            [self fetchPutawayAndSoldoutDataWithType:3];
            break;
            
        default:
            break;
    }
    
    [self pullOnLoadingwWithType:1];
    
    [self dropdownRefresh];

    [self creatFooterView];

}



- (void)creatFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 44, KScreenWidth, 44)];
    self.tableView.tableFooterView = footerView;
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
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"已上架",@"已下架"]];
    self.segment.frame = CGRectMake(0, 10, 120, 30);
    
    self.segment.tintColor = [UIColor whiteColor];
    
    NSDictionary *normalDic = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *selectedDic = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.segment setTitleTextAttributes:normalDic forState:(UIControlStateNormal)];
    [self.segment setTitleTextAttributes:selectedDic forState:(UIControlStateSelected)];
    
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
        {
            YYLog(@"上架");
            self.allSelectedImageButton.selected = NO;
            [self.putawayAndSoldoutButton setTitle:@"下架" forState:(UIControlStateNormal)];
            [self fetchPutawayAndSoldoutDataWithType:2];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self.tableView reloadData];
            });
        }
            break;
        case 1:
        {
            YYLog(@"下架");
            self.allSelectedImageButton.selected = NO;
            [self.putawayAndSoldoutButton setTitle:@"上架" forState:(UIControlStateNormal)];
            [self fetchPutawayAndSoldoutDataWithType:3];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
            break;
            
        default:
            break;
    }
}




- (void)fetchPutawayAndSoldoutDataWithType:(NSInteger)type
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    self.pageNum = 1;
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;

    parmas[@"pageNum"]  = @(self.pageNum);
    parmas[@"pageSize"] = @"10";
    parmas[@"type"]  = @(type);

    YYLog(@"仓库管理参数parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@find/products/list?",URL];
    
    [[AFHTTPSessionManager manager] POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"仓库管理返回%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            self.pageNum++;
            self.storageArray = [StorageManagementModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
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
        
        switch (self.segment.selectedSegmentIndex)
        {
            case 0:
            {
                [self fetchPutawayAndSoldoutDataWithType:2];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                });
            }
                break;
            case 1:
            {
                [self fetchPutawayAndSoldoutDataWithType:3];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                });
            }
                break;
                
            default:
                break;
        }

        [self.tableView.mj_header endRefreshing];
    }];
    
}



// 上拉加载
- (void)pullOnLoadingwWithType:(NSInteger)type
{
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        
//        self.pageNum = 1;

        parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
        parmas[@"pageNum"]  = @(self.pageNum);
        parmas[@"pageSize"] = @"10";
        parmas[@"type"]  = @(type);
        
        YYLog(@"仓库管理参数parmas--%@",parmas);
        
        NSString *url = [NSString stringWithFormat:@"%@find/products/list?",URL];
        
        [[AFHTTPSessionManager manager] POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
            
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
    
    
    CGFloat nameLabelX = allSelectedLabelX + allSelectedLabelWidth + 40;
    
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
    self.statusLabel.textAlignment = 1;
    [self.headerView addSubview:self.statusLabel];
    
    self.tableView.tableHeaderView = self.headerView;
}




#pragma mark - 全选的点击事件
- (void)allSelectedImageAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    for (StorageManagementModel *model in self.storageArray)
    {
        model.selectedBtn = button.selected;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.tableView reloadData];
        
    });
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
            [self.putawayAndSoldoutButton setTitle:@"下架" forState:(UIControlStateNormal)];
            break;
        case 1:
            [self.putawayAndSoldoutButton setTitle:@"上架" forState:(UIControlStateNormal)];
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
            [self fetchPutawayAndSoldoutWithType:2];
            break;
        case 1:
            [self fetchPutawayAndSoldoutWithType:1];
            break;
            
        default:
            break;
    }
}



- (void)fetchPutawayAndSoldoutWithType:(NSInteger)type
{
    
    NSString *string;
    NSString *productids;
    
    NSMutableArray *marray = [NSMutableArray array];
    
    for (StorageManagementModel *model in _storageArray)
    {
        if (model.selectedBtn == YES)
        {
            string = model.ID;
            
            productids = [NSMutableString string];
            
            [marray addObject:string];
        }
    }
    
    productids = [marray componentsJoinedByString:@","];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"productIds"]  = productids;
    NSString *shelves = [NSString stringWithFormat:@"%ld",type];
    parmas[@"shelves"] = shelves;
    
    YYLog(@"上架下架参数parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@update/products/shelves?",URL];
    
    [[AFHTTPSessionManager manager] POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"上架下架返回%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            switch (self.segment.selectedSegmentIndex)
            {
                case 0:
                {
                    [[AlertView sharedAlertView] addAfterAlertMessage:@"下架成功" title:@"提示"];
                }
                    break;
                case 1:
                {
                    [[AlertView sharedAlertView] addAfterAlertMessage:@"上架成功" title:@"提示"];
                }
                    break;
                    
                default:
                    break;
            }
            
            switch (self.segment.selectedSegmentIndex)
            {
                case 0:
                    [self fetchPutawayAndSoldoutDataWithType:2];
                    break;
                case 1:
                    [self fetchPutawayAndSoldoutDataWithType:3];
                    break;
                    
                default:
                    break;
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
        
        
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
    return _storageArray.count;
//    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    StorageManagementCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        
        cell = [[StorageManagementCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    StorageManagementModel *storageManagementModel = _storageArray[indexPath.row];
    
    cell.nameLabel.text = storageManagementModel.productname;
    cell.countLabel.text = storageManagementModel.inventory;
    cell.statusLabel.text = storageManagementModel.saleState;
    
    [cell.selectButton addTarget:self action:@selector(selectRowAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    cell.selectButton.selected = storageManagementModel.selectedBtn;
    cell.selectButton.tag = indexPath.row;

    return cell;
}




- (void)selectRowAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    StorageManagementModel *storageManagementModel = _storageArray[button.tag];
    storageManagementModel.selectedBtn = button.selected;
    
    self.selectCount = 0;
    
    for (storageManagementModel in _storageArray)
    {
        if (storageManagementModel.selectedBtn && self.selectCount < self.storageArray.count)
        {
            self.selectCount++;
        }
        
        if (self.selectCount == _storageArray.count)
        {
            self.allSelectedImageButton.selected = YES;
        }
        else
        {
            self.allSelectedImageButton.selected = NO;
        }
    }
 
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        
    });

}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditProductAndPublishTableVC *editProductAndPublishTableVC = [[EditProductAndPublishTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    
    StorageManagementModel *model = _storageArray[indexPath.row];
    
    editProductAndPublishTableVC.storageManagementModel = model;
        
    [self.navigationController pushViewController:editProductAndPublishTableVC animated:YES];
}




@end
