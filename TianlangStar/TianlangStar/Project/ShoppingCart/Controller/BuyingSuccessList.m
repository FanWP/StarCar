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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 414)];
    view.backgroundColor = [UIColor whiteColor];
    
    //设置数据
    NSArray *arr = @[@"交易信息",@"折扣信息",@"收款方",@"合计支付",@"余额"];
    NSString *time = [self.model.buytime getDetailCurrentTime];
    NSString *discount = [NSString stringWithFormat:@"%@折",self.model.discount];
    NSString *total = [NSString stringWithFormat:@"%@星币",self.model.totalPrice];
    NSString *blance = [NSString stringWithFormat:@"%@星币",self.model.balance];
    NSArray *arrright = @[time,discount,self.model.payee,total,blance];
    
    CGFloat lableH = 45;
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
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(16, i *left.height, KScreenWidth - 32, 0.5)];
            line.backgroundColor = BGcolor;
            [view addSubview:line];
        }
        
        if (i == 3 || i == 4) {//加灰色宽线条 并调节位置
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0,left.y + 7 *(i - 3), KScreenWidth, 7)];
            line.backgroundColor = BGcolor;
            [view addSubview:line];
            left.y = left.y + 7 * (i - 2);
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
        right.text = arrright[i];
        [view addSubview:right];

    }
    
    //设置完成按钮及VIew
    UIView *foot= [[UIView alloc] initWithFrame:CGRectMake(0, 239, KScreenWidth, 175)];
    foot.backgroundColor = BGcolor;
    [view addSubview:foot];
    UIButton *OKBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, KScreenWidth - 40, 44)];
    [foot addSubview:OKBtn];
    [OKBtn setTitle:@"完成" forState:UIControlStateNormal];
    OKBtn.backgroundColor = Tintcolor;
    [OKBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    OKBtn.layer.cornerRadius = 5;
    OKBtn.layer.masksToBounds =YES;
    
    
    self.tableView.tableFooterView = view;

}


-(void)okBtnClick
{
    YYLog(@"完成");
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arr = self.model.orderList;
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BuyingSuccessCell *cell = [BuyingSuccessCell cellWithTableView:tableView];
    BuyingSuccessDetailmodel *model = self.model.orderList[indexPath.row];
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

/*
 2016-12-07 14:52:43.667 TianlangStar[4275:1918112] {
	buytime = 1481093567581,
	totalPrice = 231,
	discount = 0.7,
	resultCode = 1000,
	payee = 天狼星汽车服务有限公司,
	orderList = [
 {
	saleId = 148109356759759420,
	discountPrice = 99,
	price = 330,
	count = 1,
	discount = 0,
	currenttime = 1481093567581,
	productname = 机油iloveyou,
	realPrice = 231
 }
 ],
	balance = 109648
 }

 */



@end
