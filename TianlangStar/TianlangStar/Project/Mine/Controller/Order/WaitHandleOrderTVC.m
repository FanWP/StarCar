//
//  WaitHandleOrderTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "WaitHandleOrderTVC.h"
#import "WaitHandleOrderCell.h"
#import "OrderModel.h"
#import "BossOkdetailOrderVC.h"
#import "WaitOrderModel.h"
#import "TBFooterDateView.h"

@interface WaitHandleOrderTVC ()

/** 接收到的数据 */
@property (nonatomic,strong) NSMutableArray *orderArr;

/** 当前页码 */
@property (nonatomic,assign) NSInteger currentPage;

/** 标记确认是否调整 */
@property (nonatomic,assign) BOOL flag;



@end

@implementation WaitHandleOrderTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BGcolor;
    
    [self setupRefresh];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.flag)
    {
        [self loadNewOrderInfo];
    }
}


-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewOrderInfo)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header isAutomaticallyChangeAlpha];

    //不做上拉刷新
//    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreOrderInfo)];
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
        self.orderArr = [WaitOrderModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
        if (self.orderArr.count > 0) {
            self.currentPage++;
        }
        [self.tableView reloadData];
        
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
         NSArray *newArr = [WaitOrderModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
         
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.orderArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    WaitOrderModel *model = self.orderArr[section];

    return model.valueList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    WaitHandleOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[WaitHandleOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    WaitOrderModel *model = self.orderArr[indexPath.section];
    OrderModel *orderM = model.valueList[indexPath.row];
    cell.orderModel = orderM;
    return cell;
}




-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    TBFooterDateView *view = [TBFooterDateView footer];
    WaitOrderModel *model = self.orderArr[section];
    view.date.text = model.date;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaitOrderModel *model = self.orderArr[indexPath.section];
    OrderModel *orderM = model.valueList[indexPath.row];
    BossOkdetailOrderVC *vc = [[BossOkdetailOrderVC alloc] init];
    vc.orderModel = orderM;
    self.flag = YES;
    [self.navigationController pushViewController:vc animated:YES];
}





@end
