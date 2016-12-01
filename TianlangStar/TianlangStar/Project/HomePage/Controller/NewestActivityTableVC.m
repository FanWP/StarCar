//
//  NewestActivityTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "NewestActivityTableVC.h"
#import "NewestListCell.h"
#import "NewestActivityDetailTableVC.h"
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
    //    find/activities/list
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    self.pageNum = 1;
    parameters[@"pageNum"] = @(self.pageNum);
    parameters[@"pageSize"] = @"4";

    NSString *url = [NSString stringWithFormat:@"%@unlogin/find/activities/list?",URL];

    [[AFHTTPSessionManager manager] GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"获取最新活动返回%@",responseObject);

        NSInteger resultCode = [responseObject[@"resCode"] integerValue];

        if (resultCode == 1000)
        {
            self.activityArray = [NewActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];

            [self.tableView reloadData];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"获取最新活动错误%@",error);
        
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,_activityModel.images]];
    [cell.pictureView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}



#pragma mark - 点击单元格选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NewestActivityDetailTableVC *newestActivityDetailTableVC = [[NewestActivityDetailTableVC alloc] initWithStyle:(UITableViewStylePlain)];
//    [self.navigationController pushViewController:newestActivityDetailTableVC animated:YES];


    ActivityDetailVC *activityDetailVC = [[ActivityDetailVC alloc] init];
    
    [self.navigationController pushViewController:activityDetailVC animated:YES];
    
}



@end
