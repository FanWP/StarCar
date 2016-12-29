//
//  ViewController.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BossRechargeRecordVC.h"
#import "VirtualcenterModel.h"
#import "RechargeRecoredCell.h"
#import "BossRechargeScoreCell.h"

@interface BossRechargeRecordVC ()<UITableViewDelegate,UITableViewDataSource>

/** 设置tableView */
@property (nonatomic,weak) UITableView *tableView;


/** 当前页 */
@property (nonatomic,assign) BOOL currentPage;

/** 获取服务器返回的充值记录 */
@property (nonatomic,strong) NSMutableArray *recoredArr;


/** 积分或者是星币的总额 */
@property (nonatomic,weak) UILabel *totalStarLable;

/** 积分或者是星币的总额 */
@property (nonatomic,weak) UILabel *totalCountLable;

@end

@implementation BossRechargeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = BGcolor;
    
    [self setupTableView];
    
    [self setupFooterView];
    
    self.title = self.rechareType == 1 ? @"星币充值记录":@"积分充值记录";
    
}

-(void)setupFooterView
{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 44, KScreenWidth, 44)];
    [self.view addSubview:footerView];
    //设置header
    NSArray *titleArr = @[@"合计",@"1000积分",@"1000笔"];
    CGFloat width = KScreenWidth / titleArr.count;

    for (NSInteger i = 0; i < titleArr.count; i++) {
        UILabel *lable = [[UILabel alloc] init];
        lable.y = 0;
        lable.x = i * width;
        lable.height  = 44;
        lable.width = width;
        lable.textAlignment = NSTextAlignmentCenter;
        
        lable.text = titleArr[i];
        
        [footerView addSubview:lable];
    }
}


-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, KScreenWidth, KScreenHeight - 108 - 49) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    //设置header
    NSArray *titleArr = @[@"时间",@"积分数量",@"用户名"];
    CGFloat width = KScreenWidth / titleArr.count;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
    
    for (NSInteger i = 0; i < titleArr.count; i++) {
        UILabel *lable = [[UILabel alloc] init];
        lable.y = 0;
        lable.x = i * width;
        lable.height  = 44;
        lable.width = width;
        lable.textAlignment = NSTextAlignmentCenter;
        
        switch (i) {
            case 1:
                self.totalStarLable = lable;
                break;
            case 2:
                self.totalCountLable = lable;
                break;
                
            default:
                break;
        }
        
        lable.text = titleArr[i];
        
        [headerView addSubview:lable];

    }
    
    self.tableView.tableHeaderView = headerView;
    
    //增加上下拉刷新
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
        }
        [self.tableView reloadData];
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.recoredArr.count;
    return 20;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    VirtualcenterModel *model = self.recoredArr[indexPath.row];
    BossRechargeScoreCell *cell = [BossRechargeScoreCell cellWithTableView:tableView];
//    cell.rechargedModel = model;
    return cell;
}




@end
