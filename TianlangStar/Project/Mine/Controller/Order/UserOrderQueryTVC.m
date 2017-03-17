//
//  UserOrderQueryTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "UserOrderQueryTVC.h"
#import "OrderModel.h"
#import "UserOrderQueryCell.h"
#import "ShopCartDetailTableVC.h"

@interface UserOrderQueryTVC ()

/** 保存服务器接收到的数据 */
@property (nonatomic,strong) NSMutableArray *orderArr;

/** 查询数据的当前页码 */
@property (nonatomic,assign) NSInteger currentPage;

@end

@implementation UserOrderQueryTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BGcolor;
    
    self.automaticallyAdjustsScrollViewInsets = YES;

    [self seupRefresh];
}



#pragma mark======添加上下拉==============
-(void)seupRefresh
{
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewOrderInfo)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header isAutomaticallyChangeAlpha];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreOrderInfo)];
}


-(void)loadNewOrderInfo
{
    [self.tableView.mj_footer endRefreshing];
    self.currentPage = 1;
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"] = @(self.currentPage);
    
    
    NSString *url = [NSString stringWithFormat:@"%@findorderinfoservlet",URL];
    
    YYLog(@"parmas---：%@url---:%@",parmas,url);
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         [self.tableView.mj_header endRefreshing];
         
         self.orderArr = [OrderModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
         
         if (self.orderArr.count > 0)
         {
             self.currentPage++;
         }
         [self.tableView reloadData];
         YYLog(@"json----%@",json);
     } failure:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
         YYLog(@"error----%@",error);
     }];
}


-(void)loadMoreOrderInfo
{
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@findorderinfoservlet",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         [self.tableView.mj_footer endRefreshing];
         
         NSArray *arr = [OrderModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
         
         if (arr.count > 0)
         {
             [self.orderArr addObjectsFromArray:arr];
             self.currentPage++;
             [self.tableView reloadData];
         }
         YYLog(@"json----%@",json);
     } failure:^(NSError *error) {
         [self.tableView.mj_footer endRefreshing];
         YYLog(@"error----%@",error);
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.orderArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserOrderQueryCell *cell = [UserOrderQueryCell cellWithTableView:tableView];
    
    OrderModel *model = self.orderArr[indexPath.row];
    cell.orderModel = model;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCartDetailTableVC *shopCartDetailTableVC = [[ShopCartDetailTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    OrderModel *model = self.orderArr[indexPath.row];
    shopCartDetailTableVC.ID = model.productid;
    
    if (model.buytype == 2)
    {
        shopCartDetailTableVC.title = @"保养维护详情";
    }else{
        shopCartDetailTableVC.title = @"商品详情";
    }
    [self.navigationController pushViewController:shopCartDetailTableVC animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}



@end
