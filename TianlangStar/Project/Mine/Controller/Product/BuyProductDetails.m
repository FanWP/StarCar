//
//  BuyProductDetails.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/30.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BuyProductDetails.h"
#import "BuyProductDetailsCell.h"
#import "ProductModel.h"
#import "SDCycleScrollView.h"


@interface BuyProductDetails ()<SDCycleScrollViewDelegate>


/** 底部的footerView */
@property (nonatomic,strong) UIView *FooterView;

/** 记录余额 */
@property (nonatomic,assign) NSInteger scoreBlance;


@end

@implementation BuyProductDetails


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.FooterView];
    
    [self dataDiscountAndAccountBalance];

    self.title = @"积分兑换详情";
    
    [self addHeader];
}


- (void)dataDiscountAndAccountBalance
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/base/userInfo",URL];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"折扣信息账户余额返回：%@",responseObject);
         
         NSArray *dataArray = responseObject[@"body"];
         
         if (dataArray.count > 0) {//有值
             NSDictionary *dic = dataArray[0];
             NSNumber *num = dic[@"score"];
             self.scoreBlance = [num integerValue];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"折扣信息账户余额错误：%@",error);
     }];
    
}



-(void)addHeader
{
    NSArray *arr = [self.model.images componentsSeparatedByString:@","];
    
    NSMutableArray *picArr  = [NSMutableArray array];
    
    for (NSString *pic  in arr)
    {
        NSString *url = [NSString stringWithFormat:@"%@%@",picURL,pic];
        [picArr addObject:url];
    }

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 210)];
    SDCycleScrollView *view = [SDCycleScrollView cycleScrollViewWithFrame:headerView.bounds imageURLStringsGroup:picArr];//_ImgList为图片url数组
    view.delegate = self;
    view.placeholderImage = [UIImage imageNamed:@"touxiang"];
    view.autoScroll = YES;
    view.autoScrollTimeInterval = 2;
    [headerView addSubview:view];
    
    self.tableView.tableHeaderView = headerView;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.FooterView removeFromSuperview];

}

//创建底部的三个按钮
-(UIView *)FooterView
{
    if (!_FooterView)
    {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,KScreenHeight - 49, KScreenWidth, 49)];
        
        //底部的按钮
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 49)];
        btn.titleLabel.font = Font17;
        [btn setTitle:@"兑换" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buyNowBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = Tintcolor;
        
        [footerView addSubview:btn];
        
        _FooterView = footerView;
    }
    return _FooterView;
}


//积分兑换
-(void)buyNowBtnClick
{
    YYLog(@"buyNowBtnClick");
    
    if (_scoreBlance < [self.model.scoreprice integerValue]) {
        
        [SVProgressHUD showErrorWithStatus:@"余额不足"];
        return;
    }
    
    NSString *message = [NSString stringWithFormat:@"支付%@积分？",self.model.scoreprice];
    
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        //积分兑换
        [self exchanggeProduct];

    }]];
    
    [self presentViewController:alert animated:YES completion:nil];

}



-(void)exchanggeProduct
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"productid"] = self.model.ID;
    parmas[@"purchasetype"] = @"2";
    parmas[@"scoreprice"] = self.model.scoreprice;
    parmas[@"count"] = @"1";
    
    NSString *url = [NSString stringWithFormat:@"%@paymenyservlet",URL];
    
    YYLog(@"parmas:%@url:%@",parmas,url);
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json:%@",json);
         NSNumber *num = json[@"resultCode"];
         if ([num integerValue] == 1000)
         {
             [SVProgressHUD showSuccessWithStatus:@"提交兑换成功！"];
         }
        
     } failure:^(NSError *error) {
         YYLog(@"error:%@",error);
     }];
    

}






-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyProductDetailsCell *cell = [BuyProductDetailsCell cellWithTableView:tableView];

    
    cell.model = self.model;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.model.introductionH;
}





#pragma mark==========cycleScrollView代理事件=================

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    YYLog(@"SDCycleScrollView---%ld",(long)index);

}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
//        YYLog(@"SDCycleScrollView====%ld",(long)index);
}







@end
