//
//  MyCollectionTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "MyCollectionTableVC.h"
#import "CollectionCell.h"
#import "CollectionModel.h"

@interface MyCollectionTableVC ()

@property (nonatomic,strong) UIView *headerView;// 顶部切换商品、服务、车辆的view
@property (nonatomic,strong) NSMutableArray *collectionArray;// 保存所有收藏物的数组
@property (nonatomic,strong) UIView *bottomView;// 底部view
@property (nonatomic,strong) UIButton *addCartButton;// 加入购物车按钮
@property (nonatomic,strong) UIButton *cancleCollectionButton;// 取消收藏按钮

@end

@implementation MyCollectionTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 0.2 * KScreenWidth + 2 * Klength5;
    
}



#pragma mark - 顶部的headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, Klength44)];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"商品",@"服务",@"车辆"]];
    segment.frame = CGRectMake(0, 0, KScreenWidth, Klength44);
    
    segment.tintColor = [UIColor orangeColor];
    
    NSDictionary *normalDic = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *selectedDic = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [segment setTitleTextAttributes:normalDic forState:(UIControlStateNormal)];
    [segment setTitleTextAttributes:selectedDic forState:(UIControlStateSelected)];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:Font16 forKey:NSFontAttributeName];
    [segment setTitleTextAttributes:attributes forState:(UIControlStateNormal)];
    
    segment.selectedSegmentIndex = 0;
    
    [self.headerView addSubview:segment];
    
    return self.headerView;
}



#pragma mark - 获取收藏信息
- (void)fetchAllCollectionDataWithType:(NSInteger)type
{
    NSString *url = [NSString stringWithFormat:@"%@getallcollectionservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    NSString *collectionType = [NSString stringWithFormat:@"%ld",type];
    parameters[@"type"] = collectionType;
    
    YYLog(@"sessionid===%@",sessionid);
    YYLog(@"获取指定用户的全部收藏物的parameters===%@",parameters);
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"获取指定用户的全部收藏物请求返回-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result == 1000)
        {
            
            self.collectionArray = [CollectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"obj"]];

        }
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.tableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"获取指定用户的全部收藏物请求失败-%@",error);
        
    }];
}



#pragma mark - 视图即将出现时调用
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self fetchAllCollectionDataWithType:1];
    
    [self creatCartAndCancleCollection];
}



#pragma mark - 视图将要消失时调用
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.bottomView removeFromSuperview];
}



#pragma mark - 创建加入购物车和取消收藏按钮
- (void)creatCartAndCancleCollection
{
    CGFloat bottomViewY = KScreenHeight - Klength44;
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomViewY, KScreenWidth, Klength44)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bottomView];
    
    
    
    CGFloat buttonWidth = KScreenWidth / 2;
    self.addCartButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.addCartButton.frame = CGRectMake(0, 0, buttonWidth, Klength44);
    [self.addCartButton setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    self.addCartButton.backgroundColor = [UIColor orangeColor];
    [self.addCartButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.addCartButton addTarget:self action:@selector(addCartAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bottomView addSubview:self.addCartButton];
    
    
    
    self.cancleCollectionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.cancleCollectionButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, Klength44);
    [self.cancleCollectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
    [self.cancleCollectionButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.cancleCollectionButton.backgroundColor = [UIColor redColor];
    [self.cancleCollectionButton addTarget:self action:@selector(cancleCollectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bottomView addSubview:self.cancleCollectionButton];
    
}



#pragma mark - 加入购物车的点击事件
- (void)addCartAction
{
    [self addToCartData];// 调取加入购物车的接口
    
    YYLog(@"加入购物车");
}



- (void)addToCartData
{
    NSString *url = [NSString stringWithFormat:@"%@addshoppingcarservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"buytype"] = @"1";// 购买类型，1表示商品  2表示服务
    parameters[@"count"] = @"2";
    parameters[@"productid"] = @"2";// 商品id
    
    [HttpTool post:url parmas:parameters success:^(id json) {
        
        YYLog(@"添加进购物车返回：%@",json);
        
    } failure:^(NSError *error) {
        
        YYLog(@"添加进购物车返回失败：%@",error);
    }];
}



#pragma mark - 取消收藏的点击事件
- (void)cancleCollectionAction
{
    [self cancleCollectionData];// 调取取消收藏的接口
    
    YYLog(@"取消收藏");
}



- (void)cancleCollectionData
{
    NSString *url = [NSString stringWithFormat:@"%@canclecollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"productid"] = @"1";
    parameters[@"type"] = @"1";// 1:物品 2:服务
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"取消收藏请求返回-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result == 1000) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"取消收藏成功" title:@"提示"];
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"取消收藏失败" title:@"提示"];
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"取消收藏请求失败-%@",error);
        
    }];
}



// headerView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return Klength44;
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
    YYLog(@"数组个数%ld",self.collectionArray.count);
    return self.collectionArray.count;
}



#pragma mark - 加载单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[CollectionCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }

    return cell;
}



@end
