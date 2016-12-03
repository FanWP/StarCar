//
//  ShoppingCartVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShoppingCartVC.h"
#import "ShoppingCarCell.h"
#import "ProductModel.h"


@interface ShoppingCartVC ()

/** 当前页码 */
@property (nonatomic,assign) NSInteger currentPage;

/** 获取服务器返回的数据 */
@property (nonatomic,strong) NSMutableArray *orderArr;

/** 结算时的总价格 */
@property (nonatomic,weak) UILabel *totalStar;

/** 底部的结算按钮 */
@property (nonatomic,strong) UIView *footerView;

/** 全选按钮 */
@property (nonatomic,weak) UIButton *allSelectedBtn;




@end

@implementation ShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGcolor;
    self.title = @"购物车";
    
    [self addOrderArr];
}


- (void)addOrderArr
{
    ProductModel *model1 = [[ProductModel alloc] init];
    model1.price = @"100";
    model1.count = 1;
    model1.productname = @"guwqrt";
    
    ProductModel *model2 = [[ProductModel alloc] init];
    model2.price = @"100";
    model2.count = 1;
    model2.productname = @"guwqrt";
    
    ProductModel *model3 = [[ProductModel alloc] init];
    model3.price = @"100";
    model3.count = 1;
    model3.productname = @"guwqrt";
    
    self.orderArr = @[model1,model2,model3];


}


-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self addFoorView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.footerView removeFromSuperview];
}


-(void)addFoorView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 88, KScreenWidth, 44)];
    footerView.backgroundColor = [UIColor whiteColor];
    self.footerView  = footerView;
    [[UIApplication sharedApplication].keyWindow addSubview:footerView];
    
    //全选按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(16, 0, 80, 44)];
    [button setTitle:@"全选" forState:UIControlStateNormal];
    [button setTitleColor:lableTextcolor forState:UIControlStateNormal];
    button.titleLabel.font = Font12;
//    button.backgroundColor = [UIColor redColor];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [button setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(allSelectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.allSelectedBtn = button;
    [footerView addSubview:button];
    
    //结算
   UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 80, 0, 80, 44)];
    checkBtn.backgroundColor = [UIColor redColor];
    [checkBtn setTitle:@"结算" forState:UIControlStateNormal];
    checkBtn.titleLabel.font = Font18;
    [checkBtn addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:checkBtn];
    
    //显示总计多少星币
    UILabel *totalStar = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - checkBtn.width - 100, 0, 100, 44)];
    totalStar.textColor = [UIColor redColor];
    totalStar.font = Font17;
    totalStar.text = @"0";
    self.totalStar = totalStar;
//    totalStar.backgroundColor = [UIColor orangeColor];
    self.totalStar = totalStar;
    [footerView addSubview:totalStar];
    
    //合计
   UILabel *total = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - totalStar.width - checkBtn.width - 50, 0, 50, 44)];
    total.font = Font15;
    total.textAlignment = NSTextAlignmentRight;
    total.text = @"合计：";
    total.textColor = lableTextcolor;
    [footerView addSubview:total];
    
    


    //设置footer
    UIView *foot = [[UIView alloc] initWithFrame:footerView.bounds];
    foot.backgroundColor = BGcolor;
    self.tableView.tableFooterView = foot;
    
}


-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewOrderInfo)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header isAutomaticallyChangeAlpha];
    
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreOrderInfo)];
}



//下拉刷新--最新数据
-(void)loadNewOrderInfo
{
    [self.tableView.mj_footer endRefreshing];
    
    self.currentPage = 1;
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@",URL];
    YYLog(@"parmas---%@--url:%@",parmas,url);
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         [self.tableView.mj_header endRefreshing];
         self.orderArr = [ProductModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
         if (self.orderArr.count > 0) {
             self.currentPage++;
             [self.tableView reloadData];
         }
         
         YYLog(@"json---%@",json);
         
     } failure:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
         YYLog(@"error---%@",error);
     }];
}

//上啦刷新加载更多
-(void)loadMoreOrderInfo
{
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@",URL];
    
    YYLog(@"待处理订单下来刷新parmas---%@",parmas);
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         [self.tableView.mj_footer endRefreshing];
         NSArray *newArr = [ProductModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
         
         if (newArr.count > 0) {
             [self.orderArr addObjectsFromArray:newArr];
             self.currentPage++;
             [self.tableView reloadData];
         }
         YYLog(@"待处理订单加载更多json---%@",json);
     } failure:^(NSError *error) {
         [self.tableView.mj_footer endRefreshing];
         YYLog(@"error---%@",error);
     }];
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCarCell *cell = [ShoppingCarCell cellWithtableView:tableView];
    [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectBtn.tag = indexPath.row;
    ProductModel *model = self.orderArr[indexPath.row];
    cell.productModel = model;
    return cell;
}


//复选框按钮的点击事件、
-(void)selectBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    //取出对应的模型
    ProductModel *model = self.orderArr[button.tag];
    model.btnSelected = button.selected;
    self.totalStar.text = [self checkTotalPrice];
}

//全选按钮的点击事件
-(void)allSelectedBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    for (ProductModel *model in self.orderArr)
    {
        model.btnSelected = button.selected;
    }
    self.totalStar.text = [self checkTotalPrice];

    [self.tableView reloadData];
}


-(NSString *)checkTotalPrice
{
    CGFloat totalStar = 0;
    for (ProductModel *model in self.orderArr)
    {
        NSInteger price = [model.price integerValue];
        if (model.btnSelected)
        {
            totalStar = totalStar + model.count * price;
        }else
        {
            self.allSelectedBtn.selected = NO;
        }
    }
    return [NSString stringWithFormat:@"%.0f星币",totalStar];
}


//结算按钮的点击事件
-(void)checkBtnClick
{
    YYLog(@"结算");
}





@end
