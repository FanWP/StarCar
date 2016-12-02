//
//  UserScoreExchangeTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "UserScoreExchangeListTVC.h"
#import "UserScoreExchangeCell.h"
#import "ProductModel.h"

@interface UserScoreExchangeListTVC ()
/** 当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/** 接受到的服务器返回的数据 */
@property (nonatomic,strong) NSMutableArray *orderArr;

@end

@implementation UserScoreExchangeListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGcolor;
    self.title = @"兑换记录";
    
    [self setupRefresh];
}


-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewOrderInfo)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header isAutomaticallyChangeAlpha];
    
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreOrderInfo)];
}



//下拉刷新--最新数据
-(void)loadNewOrderInfo
{
    [self.tableView.mj_footer endRefreshing];
    
    self.currentPage = 1;
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@findorderinfoservlet",URL];
    
    YYLog(@"parmas---%@",parmas);
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         [self.tableView.mj_header endRefreshing];
         self.orderArr = [ProductModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
         if (self.orderArr.count > 0) {
             self.currentPage++;
             [self.tableView reloadData];
         }
         
         YYLog(@"json---%@",json);
         
     } failure:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
         YYLog(@"error---%@",error);
     }];
}

//上啦刷新加载更多
-(void)loadMoreOrderInfo
{
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@findorderinfoservlet",URL];
    
    YYLog(@"待处理订单下来刷新parmas---%@",parmas);
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         [self.tableView.mj_footer endRefreshing];
         NSArray *newArr = [ProductModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
         
         if (newArr.count > 0) {
             [self.orderArr addObjectsFromArray:newArr];
             self.currentPage++;
             [self.tableView reloadData];
         }
         YYLog(@"待处理订单加载更多json---%@",json);
     } failure:^(NSError *error) {
         [self.tableView.mj_footer endRefreshing];
         YYLog(@"error---%@",error);
     }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserScoreExchangeCell *cell = [UserScoreExchangeCell cellWithTableView:tableView];
    
    ProductModel *model = [[ProductModel alloc] init];
    cell.model = model;

    return cell;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;
}

@end
