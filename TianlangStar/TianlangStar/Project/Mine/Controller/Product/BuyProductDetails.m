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


@end

@implementation BuyProductDetails


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.FooterView];

    self.title = @"积分兑换详情";
    
    [self addHeader];
    
    
    
    
    ProductModel *model = [[ProductModel alloc] init];
    /*
     self.productname.text = model.productname;
     self.price.text = model.price;
     self.productmodel.text = model.productmodel;
     self.specifications.text = model.specifications;
     self.applycar.text = model.applycar;
     self.vendors.text = model.vendors;
     self.introduction.text = model.introduction;
     */
    
    model.productname = @"商品名称";
    model.price = @"9000";
    model.productmodel = @"美孚";
    model.specifications = @"品牌三滤 ";
    model.applycar = @"大众";
    model.vendors = @"中国制造";
    model.introduction = @"uyqo34gojad;kd;AKG;ef简介  简介  就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介就是简介";
    model.cartype = @"ti4q03wt034";
    
    
    self.model = model;
}



-(void)addHeader
{
    NSArray *arr = [NSArray array];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 210)];
    SDCycleScrollView *view = [SDCycleScrollView cycleScrollViewWithFrame:headerView.bounds imageURLStringsGroup:arr];//_ImgList为图片url数组
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
        
        CGFloat width = KScreenWidth / 3;
        
        
        for (NSInteger i = 0; i < 3; i++)
        {
            //创建三个按钮
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, 49)];
            btn.titleLabel.font = Font17;
            btn.x = width * i;
            
            [footerView addSubview:btn];
            
            
            switch (i) {
                case 0://收藏
                {
                    [btn setTitle:@"收藏" forState:UIControlStateNormal];
                    btn.backgroundColor = [UIColor redColor];
                    [btn addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    break;
                }
                case 1://加入购物车
                {
                    [btn setTitle:@"加入购物车" forState:UIControlStateNormal];
                    btn.backgroundColor = [UIColor orangeColor];
                    [btn addTarget:self action:@selector(addshoppingCarBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    break;
                }
                case 2://立即购买
                {
                    [btn setTitle:@"立即购买" forState:UIControlStateNormal];
                    btn.backgroundColor = Tintcolor;
                    [btn addTarget:self action:@selector(buyNowBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    break;
                }
                    
                default:
                    break;
            }
        }
        
        _FooterView = footerView;
    }
    return _FooterView;
}

//收藏
-(void)collectBtnClick
{
    YYLog(@"collectBtnClick");
}
//加入购物车
-(void)addshoppingCarBtnClick
{
    YYLog(@"addshoppingCarBtnClick");
}
//立即购买
-(void)buyNowBtnClick
{
    YYLog(@"buyNowBtnClick");
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
    YYLog(@"SDCycleScrollView---%ld",(long)index);

}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
        YYLog(@"SDCycleScrollView====%ld",(long)index);



}







@end
