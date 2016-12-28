//
//  CarInfochangeVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CarInfoListVC.h"
#import "CarInfoChangeVC.h"
#import "CarModel.h"

@interface CarInfoListVC ()


/** 接收服务器返回的车辆信息数据 */
@property (nonatomic,strong) NSArray *carInfoArr;

@end

@implementation CarInfoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"车辆信息";
    
    [self setUpCarData];
    
}

/**
 *  获取指定用户的名下所有车辆信息
 */
-(void)setUpCarData
{
    
    NSString *url = [NSString stringWithFormat:@"%@getallcarinfoservlet",URL];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"car info list parmas----%@",parmas);
    
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"car info list::%@",json);
         
         self.carInfoArr = [CarModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         [self.tableView reloadData];
         
     } failure:^(NSError *error)
     {
         YYLog(@"car info list error---%@",error);
         
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

    return self.carInfoArr.count;;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CarModel *model = self.carInfoArr[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@       %@",model.carid,model.cartype];
    cell.textLabel.text = str;

    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return @"名下车辆信息为:";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 90;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarModel *model = self.carInfoArr[indexPath.row];
    CarInfoChangeVC *vc = [[CarInfoChangeVC alloc] init];
    vc.carInfo = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
