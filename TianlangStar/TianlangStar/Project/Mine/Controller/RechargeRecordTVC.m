//
//  RechargeRecordTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "RechargeRecordTVC.h"
#import "RechargeRecoredCell.h"
#import "VirtualcenterModel.h"

@interface RechargeRecordTVC ()

/** 请求时候的当前页面 */
@property (nonatomic,assign) NSInteger currentPage;

/** 保存服务器返回的数据 */
@property (nonatomic,strong) NSMutableArray *recoredArr;

@end

@implementation RechargeRecordTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BGcolor;
    
    [self setupRefresh];
}

#pragma mark==== 添加上下拉===========
-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRecord)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header isAutomaticallyChangeAlpha];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRecord)];
    
}

-(void)loadNewRecord
{
    /*
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);

    
    NSString *url = [NSString stringWithFormat:@"%@gtsrrchrgrcordsrvlt",URL];
         */
    
    [self.tableView.mj_footer endRefreshing];
    self.currentPage = 1;
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"userid"] = [UserInfo sharedUserInfo].userID;
    parmas[@"currentPage"] = @(self.currentPage);

    NSString *url = [NSString stringWithFormat:@"%@gtsrrchrgrcordsrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json) {
        [self.tableView.mj_header endRefreshing];
        self.recoredArr = [VirtualcenterModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
        if (self.recoredArr.count > 0)
        {
            self.currentPage++;
            [self.tableView reloadData];
        }
        YYLog(@"%@",json);
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        YYLog(@"%@",error);
    }];

}

-(void)loadMoreRecord
{
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"userid"] = [UserInfo sharedUserInfo].userID;
    parmas[@"currentPage"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@gtsrrchrgrcordsrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json) {
        [self.tableView.mj_footer endRefreshing];
        NSArray *arr = [VirtualcenterModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
        if (arr.count > 0)
        {
            [self.recoredArr addObjectsFromArray:arr];
            self.currentPage++;
            [self.tableView reloadData];
        }
        YYLog(@"%@",json);
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        YYLog(@"%@",error);
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recoredArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VirtualcenterModel *model = self.recoredArr[indexPath.row];
    RechargeRecoredCell *cell = [RechargeRecoredCell cellWithTableview:tableView];
    cell.rechargedModel = model;
    return cell;
}






@end
