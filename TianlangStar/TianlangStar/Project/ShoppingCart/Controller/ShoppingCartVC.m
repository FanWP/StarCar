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
#import "BuyingSuccessList.h"
#import "BuyingSuccessListModel.h"


@interface ShoppingCartVC ()

/** 当前页码 */
@property (nonatomic,assign) NSInteger currentPage;

/** 获取服务器返回的数据 */
@property (nonatomic,strong) NSMutableArray *orderArr;

/** 获取用户购物车选中的数组 */
@property (nonatomic,strong) NSMutableArray *selectedOrderArr;

/** 结算时的总价格 */
@property (nonatomic,weak) UILabel *totalStar;

/** 底部的结算按钮 */
@property (nonatomic,strong) UIView *footerView;

/** 全选按钮 */
@property (nonatomic,weak) UIButton *allSelectedBtn;

/** 结算按钮 */
@property (nonatomic,weak) UIButton *checkBtn;

/** 购物车商品的总价 */
@property (nonatomic,copy) NSString *totalPriceStr;


@end

@implementation ShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGcolor;
    self.title = @"购物车";
    [self setupRefresh];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
}


-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self loadNewOrderInfo];
    [self addFoorView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.footerView removeFromSuperview];
}


-(void)addFoorView
{
    if (self.footerView)
    {
        [[UIApplication sharedApplication].keyWindow addSubview:self.footerView];
        return;
        
    }else{
    
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
    [checkBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    checkBtn.enabled = NO;
    self.checkBtn = checkBtn;
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
    
}

#pragma mark==============添加上下拉功能====================
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
    //    parmas[@"currentPage"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@findshopcarlist",URL];
    YYLog(@"parmas---%@--url:%@",parmas,url);
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json购物车:%@",json);
         [self.tableView.mj_header endRefreshing];
         self.orderArr = [ProductModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
            [self.tableView reloadData];
         if (self.orderArr.count > 0)
         {
             self.currentPage++;
         }
         YYLog(@"购物车查询返回：json---%@",json);
         
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
//    parmas[@"currentPage"] = @(self.currentPage);
    
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


/** 删除购物车 */
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        ProductModel *model = self.orderArr[indexPath.row];
        [self.orderArr removeObjectAtIndex:indexPath.row];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        
        
        
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
        parmas[@"favoriteid"] = model.ID;
        
        NSString *url = [NSString stringWithFormat:@"%@cancel/shopcar/servlet",URL];
        
        //发送删除请求
        [HttpTool post:url parmas:parmas success:^(id json)
         {
             YYLog(@"json删除购物车--%@",json);
             
         } failure:^(NSError *error) {
             YYLog(@"error删除购物车--%@",error);
             
         }];
        
        
    }];
    
    return @[deleteAction];
}

//复选框按钮的点击事件、
-(void)selectBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    //取出对应的模型
    ProductModel *model = self.orderArr[button.tag];
    model.btnSelected = button.selected;
   [self checkTotalPrice];
}

//全选按钮的点击事件
-(void)allSelectedBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    for (ProductModel *model in self.orderArr)
    {
        model.btnSelected = button.selected;
    }
     [self checkTotalPrice];
    
    [self.tableView reloadData];
}


-(void)checkTotalPrice
{
    //判断是否是全选
    for (ProductModel *model in self.orderArr)
    {
        if (!model.btnSelected)
        {
            self.allSelectedBtn.selected = NO;
            break;
        }else
        {
            self.allSelectedBtn.selected = YES;
        }
    }
    
    
    NSMutableArray *seletedArr = [NSMutableArray array];
    
    NSInteger totalStar = 0;
    //当前用户所享受的折扣价格
    
    for (ProductModel *model in self.orderArr)
    {
        if (model.btnSelected)
        {
            totalStar = totalStar + model.realPrice;
            
//            totalStar = [];
            //记录选中数据的商品及个数数组
            [seletedArr addObject:model];
        }
        //判断结算按钮是否可用
        self.checkBtn.enabled = totalStar != 0;
    }
    self.selectedOrderArr = seletedArr;
    self.totalPriceStr = [NSString stringWithFormat:@"%ld",(long)totalStar];
    
    
    NSString *total = totalStar > 0 ? [NSString stringWithFormat:@"%.0ld星币",(long)totalStar] : @"0";
    
    self.totalStar.text = total;

}


//结算按钮的点击事件
-(void)checkBtnClick
{
    
    NSString *message = [NSString stringWithFormat:@"支付%@？",self.totalStar.text];
    
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        //清空购物车
        [self buyProductInShoppingCar];
        
    }]];
    
    [self presentViewController:alert animated:YES completion:^{
        //刷新数据
        [self loadNewOrderInfo];
    }];
}

-(void)buyProductInShoppingCar
{

    NSArray *arr = [ProductModel mj_keyValuesArrayWithObjectArray:self.selectedOrderArr];

    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:0 error:&error];
    
    NSString *dataStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"totalprice"] = self.totalPriceStr;
    parmas[@"productlist"] = dataStr;
    parmas[@"type"] = @"2";
    
    
    NSString *url = [NSString stringWithFormat:@"%@payment/shopcar/servlet",URL];
    YYLog(@"parmas--:%@url---:%@",parmas,url);
    
    [HttpTool post:url parmas:parmas success:^(id json) {


        [self checkTotalPrice];
        NSNumber *num = json[@"resultCode"];
        if ([num integerValue] == 1000)//返回成功
        {

            //跳转
            BuyingSuccessListModel *model = [BuyingSuccessListModel mj_objectWithKeyValues:json];
            BuyingSuccessList *vc = [[BuyingSuccessList alloc] initWithStyle:UITableViewStyleGrouped];
            vc.model = model;
            [self.navigationController pushViewController:vc                              animated:YES];
        }
        
        YYLog(@"%@",json);
    } failure:^(NSError *error) {
        [self checkTotalPrice];
        
        
        YYLog(@"%@",error);
    }];
}





@end
