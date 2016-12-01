//
//  UserScoreExchangeTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "UserScoreExchangeTVC.h"
#import "UserScoreExchangeCell.h"
#import "ProductModel.h"

@interface UserScoreExchangeTVC ()

@end

@implementation UserScoreExchangeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGcolor;
    self.title = @"兑换记录";
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserScoreExchangeCell *cell = [UserScoreExchangeCell cellWithTableView:tableView];
    
    ProductModel *model = [[ProductModel alloc] init];
    cell.model = model;

    return cell;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;
}

@end
