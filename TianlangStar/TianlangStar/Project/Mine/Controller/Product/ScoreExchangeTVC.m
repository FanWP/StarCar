//
//  ScoreExchange.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ScoreExchangeTVC.h"
#import "ScoreExchangeCell.h"
#import "ProductModel.h"
#import "BuyProductDetails.h"


@interface ScoreExchangeTVC ()


/** 请求的当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/** 接收服务器返回的商品兑换数据 */
@property (nonatomic,strong) NSMutableArray *productArr;

@end

@implementation ScoreExchangeTVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BGcolor;
    
    [self setupRefresh];
}


#pragma mark ====   ======添加上下拉
-(void)setupRefresh
{
    
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewScrore)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header isAutomaticallyChangeAlpha];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreScrore)];



}

-(void)loadNewScrore
{
    
    [self.tableView.mj_footer endRefreshing];
    self.currentPage = 1;
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@integrallistingservlet",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json) {
        YYLog(@"%@",json);
        self.productArr = [ProductModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
        if (self.productArr.count > 0)
        {
            self.currentPage++;
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        YYLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
    }];

}



-(void)loadMoreScrore
{
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@integrallistingservlet",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json) {
        YYLog(@"%@",json);
       NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
        if (arr.count > 0)
        {
            [self.productArr addObjectsFromArray:arr];
            self.currentPage++;
            [self.tableView reloadData];
        }
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        YYLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];
    }];

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productArr.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreExchangeCell *cell = [ScoreExchangeCell cellWithTableView:tableView];
    
    ProductModel *model = self.productArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 130;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductModel *model = self.productArr[indexPath.row];
    BuyProductDetails *vc = [[BuyProductDetails alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];



}
@end
