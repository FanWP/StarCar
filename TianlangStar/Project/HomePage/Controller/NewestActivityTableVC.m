//
//  NewestActivityTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "NewestActivityTableVC.h"
#import "NewestListCell.h"
#import "NewActivityModel.h"
#import "ActivityDetailVC.h"

@interface NewestActivityTableVC ()

@property (nonatomic,assign) NSInteger pageNum;

@property (nonatomic,strong) NewActivityModel *activityModel;
@property (nonatomic,strong) NSMutableArray *activityArray;

@end

@implementation NewestActivityTableVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"最新活动";
    
    self.tableView.rowHeight = 0.8 * (0.3 * KScreenWidth) + 2 * Klength5;
    
    [self fetchNewActivityData];
    
    [self dropdownRefresh];
    
    [self loadMoreNewActivityData];
}


- (NSMutableArray *)activityArray
{
    if (!_activityArray)
    {
        _activityArray = [NSMutableArray array];
    }
    
    return _activityArray;
}


- (void)fetchNewActivityData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    self.pageNum = 1;
    parameters[@"pageNum"] = @(self.pageNum);
    parameters[@"pageSize"] = @"10";

    NSString *url = [NSString stringWithFormat:@"%@unlogin/find/activities/list",URL];
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"获取最新活动返回%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            self.pageNum++;
            
            self.activityArray = [NewActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            
            [self.tableView reloadData];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"获取最新活动错误%@",error);
        
    }];
}




// 下拉刷新
- (void)dropdownRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self.activityArray removeAllObjects];
        
        [self fetchNewActivityData];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    }];
}



// 上拉加载
- (void)loadMoreNewActivityData
{
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
       
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        parameters[@"pageNum"] = @(self.pageNum);
        parameters[@"pageSize"] = @"10";
        
        YYLog(@"获取最新活动参数：：%@",parameters);
        
        NSString *url = [NSString stringWithFormat:@"%@unlogin/find/activities/list?",URL];
        
        [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             YYLog(@"获取最新活动返回%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 self.pageNum++;
                 
                 NSArray *moreActivityArray = [NewActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
                 
                 [self.activityArray addObjectsFromArray:moreActivityArray];
                 
                 [self.tableView reloadData];
                 
                 [self.tableView.mj_footer endRefreshing];
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             YYLog(@"获取最新活动错误%@",error);
             
         }];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



#pragma mark - Table view data source
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.activityArray.count;
}



#pragma mark - 加载单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    NewestListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[NewestListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    _activityModel = _activityArray[indexPath.row];
    
    cell.titleLabel.text = _activityModel.title;
    cell.timeLabel.text = _activityModel.createTime;
    NSArray *array = [_activityModel.images componentsSeparatedByString:@","];
    NSString *pic = [NSString stringWithFormat:@"%@%@",picURL,array.firstObject];
    YYLog(@"图片地址：%@",pic);
    [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:pic] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    http://192.168.1.18:8080/picture\2016-12-08\39ec0ebb-d46e-4d58-8c3e-bd166372163a_img.jpg

    return cell;
}



#pragma mark - 点击单元格选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityDetailVC *activityDetailVC = [[ActivityDetailVC alloc] init];
    
    _activityModel = _activityArray[indexPath.row];
    
    activityDetailVC.url = _activityModel.detailUrl;
    
    [self.navigationController pushViewController:activityDetailVC animated:YES];
    
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UserInfo sharedUserInfo].isLogin == YES && (USERType == 0 || USERType == 1))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}




- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        parameters[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
        _activityModel = _activityArray[indexPath.row];
        NSString *actionid = _activityModel.ID;
        parameters[@"actionid"] =actionid;
        
        YYLog(@"删除活动参数:%@",parameters);
        
        NSString *url = [NSString stringWithFormat:@"%@delactivitiesservlet",URL];
        
        [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
        {
            
            YYLog(@"删除活动返回：%@",responseObject);
            
            NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
            
            if (resultCode == 1000)
            {
                [[AlertView sharedAlertView] addAfterAlertMessage:@"删除成功" title:@"提示"];
                
                [self fetchNewActivityData];
                
                [self.tableView reloadData];
            }
            else
            {
                [[AlertView sharedAlertView] addAfterAlertMessage:@"删除失败" title:@"提示"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
        {
            YYLog(@"删除活动错误：%@",error);
        }];
    }
}




@end


























