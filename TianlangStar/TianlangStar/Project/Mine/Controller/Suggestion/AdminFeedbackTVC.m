//
//  AdminFeedbackTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AdminFeedbackTVC.h"
#import "FeedbackModel.h"
#import "InputCell.h"
#import "ReFeedbackVC.h"
#import "ReplyFeedbackVC.h"

@interface AdminFeedbackTVC ()


/** 获取服务器返回的意见列表 */
@property (nonatomic,strong) NSMutableArray *feedbackArr;

/** 给服务器发送的当前页面 */
@property (nonatomic,assign) NSInteger currentPage;


/** 设置未回复还是已回复 0---未回复   1----已回复 */
@property (nonatomic,assign) NSInteger revertType;

@end

@implementation AdminFeedbackTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleview];
    
    [self setupRefresh];
}


-(void)addTitleview
{
    NSArray *arr = [NSArray arrayWithObjects:@"未回复 ",@"已回复", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:arr];
    segment.frame = CGRectMake(0, 0, 100, 40);
   
    [segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    segment.apportionsSegmentWidthsByContent = YES;
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor whiteColor];
    self.navigationItem.titleView = segment;
    self.revertType = 0;

}

-(void)segmentChange:(UISegmentedControl *)segment
{
    self.revertType = segment.selectedSegmentIndex;
    
    //刷新数据
    [self loadNewFeedbackAction];
}


//添加上下拉功能
-(void)setupRefresh
{

    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewFeedbackAction)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreFeedbackAction)];

}



#pragma mark - 查询客户提交的意见列表

//下拉加载最新数据
- (void)loadNewFeedbackAction
{
    
    [self.tableView.mj_footer endRefreshing];
    NSString *url = [NSString stringWithFormat:@"%@findsuggestionlistservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    self.currentPage = 1;
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"currentPage"] = @(self.currentPage);
    parameters[@"flag"] = @(self.revertType);
    
    [HttpTool post:url parmas:parameters success:^(id json)
     {
         [self.tableView.mj_header endRefreshing];
         YYLog(@"查询客户提交的意见列表返回：%@",json);
         self.currentPage++;
         self.feedbackArr = [FeedbackModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         YYLog(@"self.feedbackArr.count----%lu",(unsigned long)self.feedbackArr.count);
         [self.tableView reloadData];
     } failure:^(NSError *error)
     {
         [self.tableView.mj_header endRefreshing];
         YYLog(@"%@",error);
     }];
}


//下拉加载最新数据
- (void)loadMoreFeedbackAction
{
    NSString *url = [NSString stringWithFormat:@"%@findsuggestionlistservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    self.currentPage = 1;
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"currentPage"] = @(self.currentPage);
    parameters[@"flag"] = @(self.revertType);
    
    
    [HttpTool post:url parmas:parameters success:^(id json)
     {
         [self.tableView.mj_footer endRefreshing];
         YYLog(@"查询客户提交的意见列表返回：%@",json);
         self.currentPage++;
         NSMutableArray *arr = [FeedbackModel mj_keyValuesArrayWithObjectArray:json[@"obj"]];
         self.feedbackArr = [NSMutableArray arrayWithArray:arr];
         YYLog(@"%@",arr);
         [self.tableView reloadData];
     } failure:^(NSError *error)
     {
         YYLog(@"%@",error);
         [self.tableView.mj_footer endRefreshing];
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
    return self.feedbackArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    FeedbackModel *model = self.feedbackArr[indexPath.row];
    cell.textLabel.text = model.membername;
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.text = model.username;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedbackModel *model = self.feedbackArr[indexPath.row];
    
    if (self.revertType == 0)//未回复
    {
        ReFeedbackVC *vc = [[ReFeedbackVC alloc] init];
        vc.feedbackModel = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else//已回复
    {
        ReplyFeedbackVC *vc = [[ReplyFeedbackVC alloc] init];
        vc.feedbackModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth * 0.5, 14)];
    lable.centerX = KScreenWidth * 0.5;
    lable.backgroundColor = [UIColor redColor];
    [foot addSubview:lable];

    return foot;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}



@end
