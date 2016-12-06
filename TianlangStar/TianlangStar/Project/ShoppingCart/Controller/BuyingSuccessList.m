//
//  BuyingSuccessList.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/6.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BuyingSuccessList.h"
#import "LeftAndRightModel.h"
#import "OrderModel.h"
#import "TBHeadersSucceedView.h"
#import "BuyingSuccessListModel.h"
#import "BuyingSuccessDetailmodel.h"
#import "BuyingSuccessCell.h"

@interface BuyingSuccessList ()

/** 交易时间 */
@property (nonatomic,weak) UILabel *currenttime;

/** 折扣信息 */
@property (nonatomic,weak) UILabel *discountInfo;

/** 收款方 */
@property (nonatomic,weak) UILabel *payee;

/** 总价 */
@property (nonatomic,weak) UILabel *totalPrice;

/** 余额 */
@property (nonatomic,weak) UILabel *blance;


@end

@implementation BuyingSuccessList

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    
    self.title = @"交易详情";
    
    self.view.backgroundColor = BGcolor;

    
    [self addHeader];
    
    
    [self addFooter];
    
    
}

- (void)addHeader
{
    TBHeadersSucceedView *view = [TBHeadersSucceedView SuccessfulTrade];
    
    self.tableView.tableHeaderView = view;

}


-(void)addFooter
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 300)];
    view.backgroundColor = [UIColor whiteColor];
    
    //设置数据
    NSArray *arr = @[@"交易信息",@"折扣信息",@"收款方",@"合计支付",@"余额"];
    
    CGFloat lableH = 50;
    for (NSInteger i = 0; i < arr.count; i++)
    {
        //左侧的数据
        UILabel *left = [[UILabel alloc] init];
        left.x = 16;
        left.height = lableH;
        left.width = KScreenWidth * 0.45;
        left.y = i * left.height;
        left.font = Font17;
        left.text = arr[i];
        
        //加灰色线条
        if (i == 1 || i== 2)
        {
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(16, i *left.height, KScreenWidth - 32, 1)];
            line.backgroundColor = BGcolor;
            [view addSubview:line];
        }
        
        if (i == 2 || i == 3) {//加灰色宽线条 并调节位置
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(16, left.height + left.y, KScreenWidth - 32, 7)];
            line.backgroundColor = BGcolor;
            [view addSubview:line];
            left.y = left.y + 7;
        }
        [view addSubview:left];
        
        
        //设置右边的数据
        
        UILabel *right = [[UILabel alloc] init];
        right.width = KScreenWidth * 0.55;
        right.height = lableH;
        right.y = left.y;
        right.x = KScreenWidth - 20 - right.width;
        right.textAlignment = NSTextAlignmentRight;
        right.font = Font15;
        [view addSubview:right];
        
        
        switch (i) {
            case 0://交易时间
                self.currenttime = right;
                break;
            case 1://交易时间
                self.currenttime = right;
                break;
            case 2://交易时间
                self.currenttime = right;
                break;
            case 3://交易时间
                self.currenttime = right;
                break;
            case 4://交易时间
                self.currenttime = right;
                break;
                
            default:
                break;
        }
        
        
        
        
        
    }
    


    
    self.tableView.tableFooterView = view;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arr = self.detalList.orderList;
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BuyingSuccessCell *cell = [BuyingSuccessCell cellWithTableView:tableView];
    BuyingSuccessDetailmodel *model = self.detalList.orderList[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 207;
}


/*
 {
	totalPrice = 154,
	resultCode = 1000,
	orderList = [
 {
	saleId = 148100580825156869,
	discountPrice = 38,
	price = 96,
	count = 2,
	discount = 0,
	currenttime = 1481005807913,
	proName = 玻璃水,
	payee = 天狼星汽车服务有限公司,
	realPrice = 154
 }
 */



@end
