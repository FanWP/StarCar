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

@interface UserOrderQueryTVC ()

/** 保存服务器接收到的数据 */
@property (nonatomic,strong) NSMutableArray *orderArr;

@end

@implementation UserOrderQueryTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BGcolor;

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
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    
    NSString *url = [NSString stringWithFormat:@"%@findorderinfoservlet",URL];
    [self.tableView.mj_footer endRefreshing];
    
    
    [HttpTool post:url parmas:parmas success:^(id json) {
        
        [self.tableView.mj_header endRefreshing];
        
        self.orderArr = [OrderModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}



@end
