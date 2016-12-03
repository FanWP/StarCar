//
//  BossTransactionDetailsTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BossTransactionDetailsTVC.h"
#import "LeftAndRightModel.h"
#import "OrderModel.h"
#import "TBHeadersSucceedView.h"

@interface BossTransactionDetailsTVC ()


/** 传入的模型数组 */
@property (nonatomic,strong) NSMutableArray *detalLiat;

@end

@implementation BossTransactionDetailsTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    
    self.title = @"交易详情";
    
    self.view.backgroundColor = BGcolor;
    
    self.detalLiat = [NSMutableArray array];
    
    
    [self addHeader];
    
    
    //设置数据
    LeftAndRightModel *name = [LeftAndRightModel modelWithLeft:@"商品名称" Right:self.OrderModel.productname];
    LeftAndRightModel *time = [LeftAndRightModel modelWithLeft:@"交易时间" Right:self.OrderModel.productname];
    LeftAndRightModel *num = [LeftAndRightModel modelWithLeft:@"交易单号" Right:self.OrderModel.productname];
    LeftAndRightModel *receive = [LeftAndRightModel modelWithLeft:@"收款方" Right:self.OrderModel.productname];
    
    NSArray *group1 = @[name,time,num,receive];
    
    
    LeftAndRightModel *orginPrice = [LeftAndRightModel modelWithLeft:@"商品原价" Right:self.OrderModel.productname];
    LeftAndRightModel *discount = [LeftAndRightModel modelWithLeft:@"折扣信息" Right:self.OrderModel.productname];
    LeftAndRightModel *price = [LeftAndRightModel modelWithLeft:@"实付金额" Right:self.OrderModel.productname];
//    
//    if (USERType ) {
//        <#statements#>
//    }
    
    NSArray *group2 = @[orginPrice,discount,price];
    
    [self.detalLiat addObject:group1];
    [self.detalLiat addObject:group2];
    
}

- (void)addHeader
{
    TBHeadersSucceedView *view = [TBHeadersSucceedView SuccessfulTrade];
    
    self.tableView.tableHeaderView = view;
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.detalLiat.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *arr = self.detalLiat[section];
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];


    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    NSArray *arr = self.detalLiat[indexPath.section];
    
    LeftAndRightModel *model = arr[indexPath.row];
    
    cell.textLabel.text = model.leftLB;
    cell.detailTextLabel.text = model.rightLB;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}







@end
