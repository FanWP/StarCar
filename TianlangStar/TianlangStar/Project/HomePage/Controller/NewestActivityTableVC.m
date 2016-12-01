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

@end

@implementation NewestActivityTableVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"最新活动";
    
    self.tableView.rowHeight = 0.8 * (0.3 * KScreenWidth) + 2 * Klength5;
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
    return _activityArray.count;
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
