//
//  ProductDetailTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/12/2.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ProductDetailTableVC.h"

#import "ProductModel.h"
#import "ServiceModel.h"
#import "CarModel.h"
#import "UserInfo.h"
#import "BuyingSuccessListModel.h"
#import "BuyingSuccessList.h"

#import "CollectionModel.h"
#import "LoginVC.h"

@interface ProductDetailTableVC ()<SDCycleScrollViewDelegate>

// scrollView
@property (nonatomic,strong) SDCycleScrollView *scrollView;
// 轮播图
@property (nonatomic,strong) UIView *headerView;

@property (nonatomic,strong) NSMutableArray *imagesArray;

@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *collectionButton;
@property (nonatomic,strong) UIButton *addCartButton;
@property (nonatomic,strong) UIButton *buyButton;
@property (nonatomic,strong) UIButton *chatButton;

@property (nonatomic,copy) NSString *productId;


@property (nonatomic,strong) UserInfo *userInfo;
/** 收藏状态 */
@property (nonatomic,assign) BOOL isCollection;
/** 收藏model */
@property (nonatomic,strong) CollectionModel *collectionModel;
/** 保存数据模型 */
@property (nonatomic,strong) NSMutableArray *collectionArray;
/** 保存已收藏所有商品id */
@property (nonatomic,strong) NSMutableArray *collectionIdArray;


@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) UIView *countView;
@property (nonatomic,strong) UIView *coverPicView;
@property (nonatomic,strong) UIImageView *picView;
@property (nonatomic,strong) UILabel *selectCountLabel;
@property (nonatomic,strong) UIButton *minusButton;
@property (nonatomic,strong) UIButton *plusButton;
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *memberDiscountLabel;
@property (nonatomic,strong) UILabel *discountLabel;
@property (nonatomic,strong) UILabel *actuallyPaidLabel;
@property (nonatomic,strong) UILabel *paidLabel;

@property (nonatomic,copy) NSString *price;

@property (nonatomic,strong) UIButton *okAddCartButton;

//购买数量
@property (nonatomic,copy) NSString *countNum;
@property (nonatomic,assign) NSInteger countNumber;


@property (nonatomic,copy) NSString *totalStar;

@property (nonatomic,assign) NSInteger appearCount;


@property (nonatomic,copy) NSString *telNum;
@property (nonatomic,strong) UIWebView *webView;

//判断是商品还是服务

/** 显示是商品详情的1---商品  2----是服务 */
@property (nonatomic,assign) NSInteger productType;

@end

@implementation ProductDetailTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userInfo = [UserInfo sharedUserInfo];
    
     _imagesArray = [NSMutableArray array];
    
    self.tableView.separatorStyle = 0;
    
    self.appearCount = 0;
    
    [self rightItem];
    
    [self addFooterView];
    
    [self fetchData];
}



- (void)fetchData
{    if ([self.title isEqualToString:@"商品详情"])//商品
{
    YYLog(@"_productModel.brand::%@",_productModel.brand);
    
    self.productId = _productModel.ID;
    
    self.price = _productModel.price;
    
    self.productType = 1;
    
    NSString *images = _productModel.images;
    
    NSArray *array = [images componentsSeparatedByString:@","];
    
    for (NSInteger i = 0; i < array.count - 1; i++)
    {
        NSString *pic = array[i];
        
        NSString *image = [NSString stringWithFormat:@"%@%@",picURL,pic];
        
        [_imagesArray addObject:image];
    }
    
}
else if ([self.title isEqualToString:@"保养维护详情"])
{
    self.productId = _serviceModel.ID;
    
    self.price = _serviceModel.price;
    
    self.productType = 2;
    
    NSString *images = _serviceModel.images;
    
    NSArray *array = [images componentsSeparatedByString:@","];
    
    for (NSInteger i = 0; i < array.count - 1; i++)
    {
        NSString *pic = array[i];
        
        NSString *image = [NSString stringWithFormat:@"%@%@",picURL,pic];
        
        [_imagesArray addObject:image];
    }
    
}
else
{
    self.productId = _carModel.ID;
    
    self.telNum = _carModel.telephone;
    
    YYLog(@"_carModel.carDescription::--------- %@",_carModel.carDescription);
    
    NSString *images = _carModel.images;
    
    self.price = _carModel.price;
    
    NSArray *array = [images componentsSeparatedByString:@","];
    
    for (NSInteger i = 0; i < array.count - 1; i++)
    {
        NSString *pic = array[i];
        
        NSString *image = [NSString stringWithFormat:@"%@%@",picURL,pic];
        
        [_imagesArray addObject:image];
    }
    
}
    
    
    [self creatHeaderView];

}




- (void)addFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - Klength44, KScreenWidth, Klength44)];
    self.tableView.tableFooterView = footerView;
}



-(void)setProductType:(NSInteger)productType
{
    _productType = productType;
    [self changeModelCount];

}



- (void)rightItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareAction)];
}



- (void)shareAction
{
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if ([UserInfo sharedUserInfo].userType == 2 || [UserInfo sharedUserInfo].isLogin == NO)
    {
        [self creatFootView];
        
    }
    if ([UserInfo sharedUserInfo].isLogin)
    {
        [self allCollectionAction];
    }
    else
    {
        [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
    }
}





- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self.bottomView removeFromSuperview];
    
    [self.okAddCartButton removeFromSuperview];
}



#pragma mark - 轮播图
- (void)creatHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.3 * KScreenHeight)];
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, 0.3 * KScreenHeight) imageNamesGroup:_imagesArray];
    _scrollView.delegate = self;
    _scrollView.placeholderImage = [UIImage imageNamed:@"touxiang"];
    _scrollView.autoScrollTimeInterval = 2.0;
    [_headerView addSubview:_scrollView];
    self.tableView.tableHeaderView = _headerView;
}




- (void)creatFootView
{
    CGFloat bottomViewY = KScreenHeight - Klength44;
    
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomViewY, KScreenWidth, Klength44)];
        [[UIApplication sharedApplication].keyWindow addSubview:self.bottomView];
        
    CGFloat buttonWidth = KScreenWidth / 3;
    
    
    self.collectionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.collectionButton.frame = CGRectMake(0, 0, buttonWidth, Klength44);
    [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
    
    
    
    self.addCartButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.addCartButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, Klength44);
    self.addCartButton.tag = 111;
    [self.addCartButton setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    
    
    
    self.buyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.buyButton.frame = CGRectMake(2 * buttonWidth, 0, buttonWidth, Klength44);
    self.buyButton.tag = 112;
    [self.buyButton setTitle:@"立即购买" forState:(UIControlStateNormal)];

    
    self.chatButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.chatButton.frame = CGRectMake(KScreenWidth / 2, 0, KScreenWidth / 2, Klength44);
    [self.chatButton setTitle:@"咨询" forState:(UIControlStateNormal)];
    [self.chatButton addTarget:self action:@selector(chatAction) forControlEvents:(UIControlEventTouchUpInside)];

    
    if ([self.title isEqualToString:@"二手车详情"])
    {
        self.collectionButton.frame = CGRectMake(0, 0, KScreenWidth / 2, Klength44);
        [self.bottomView addSubview:self.collectionButton];
        
        [self.bottomView addSubview:self.chatButton];
    }
    else
    {
        [self.bottomView addSubview:self.collectionButton];
        [self.bottomView addSubview:self.addCartButton];
        [self.bottomView addSubview:self.buyButton];
    }
    
    
    
    self.collectionButton.backgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:26.0 / 255.0 blue:2.0 / 255.0 alpha:1];
    self.addCartButton.backgroundColor =[UIColor colorWithRed:255.0 / 255.0 green:148.0 / 255.0 blue:2.0 / 255.0 alpha:1];
    self.buyButton.backgroundColor = [UIColor colorWithRed:8.0 / 255.0 green:125.0 / 255.0 blue:255.0 / 255.0 alpha:1];
    self.chatButton.backgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:148.0 / 255.0 blue:2.0 / 255.0 alpha:1];
    
    
    [self.collectionButton addTarget:self action:@selector(collectionAction) forControlEvents:(UIControlEventTouchUpInside)];

    [self.addCartButton addTarget:self action:@selector(addCountAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buyButton addTarget:self action:@selector(addCountAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.chatButton addTarget:self action:@selector(chatAction) forControlEvents:(UIControlEventTouchUpInside)];
}



- (void)collectionAction
{
    YYLog(@"收藏");

    if (self.userInfo.isLogin)
    {
        NSString *url = [NSString stringWithFormat:@"%@getallcollectionservlet",URL];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
        parameters[@"sessionId"] = sessionid;
        parameters[@"currentPage"] = @(0);
        NSInteger type;
        if ([self.title isEqualToString:@"保养维护详情"])
        {
            type = 2;
        }
        else if ([self.title isEqualToString:@"商品详情"])
        {
            type = 1;
        }
        else
        {
            type = 3;
        }
        parameters[@"type"] = @(type);
        
        [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            YYLog(@"收藏列表返回：%@",responseObject);
            
            NSNumber *num = responseObject[@"resultCode"];
            NSInteger result = [num integerValue];
            
            NSArray *array = responseObject[@"body"];
            
            CollectionModel *collectionModel = [[CollectionModel alloc] init];
            
            if (result == 1000)
            {
                for (NSDictionary *dic in array)
                {
                    [collectionModel setValuesForKeysWithDictionary:dic];
                    [self.collectionArray addObject:collectionModel];
                    [self.collectionIdArray addObject:collectionModel.productid];
                }
                
                YYLog(@"self.collectionModel.productid:%@",collectionModel.productid);
                
                // 收藏过的数据里包含这个id则取消收藏  collectionModel.productid
                if ([self.collectionIdArray containsObject:self.productId])
                {
                    // 取消收藏
                    if ([self.title isEqualToString:@"保养维护详情"])
                    {
                        [self cancleCollectionActionWithType:2];
                    }
                    else if ([self.title isEqualToString:@"商品详情"])
                    {
                        [self cancleCollectionActionWithType:1];
                    }
                    else
                    {
                        [self cancleCollectionActionWithType:3];
                    }
                }
                // 否则添加收藏
                else
                {
                    // 添加收藏
                    if ([self.title isEqualToString:@"保养维护详情"])
                    {
                        [self addCollectionActionWithType:2];
                    }
                    else if ([self.title isEqualToString:@"商品详情"])
                    {
                        [self addCollectionActionWithType:1];
                    }
                    else
                    {
                        [self addCollectionActionWithType:3];
                    }
                }
                
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            YYLog(@"获取指定用户的全部收藏物请求失败-%@",error);
            
        }];
        
    }
    else
    {
        // 提示用户先登录
        [[AlertView sharedAlertView] loginAction];
    }
}



#pragma mark - 添加收藏
/**
 *  添加收藏
 */
- (void)addCollectionActionWithType:(NSInteger)type
{
    NSString *url = [NSString stringWithFormat:@"%@addtocollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"id"] = self.productId;
    parameters[@"type"] = @(type);// 1:物品 2:服务
    
    YYLog(@"添加收藏参数：%@",parameters);
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"添加收藏请求返回-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"收藏成功" title:@"提示"];
                
                [self.collectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
                
                self.isCollection = YES;
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAlertMessage:@"收藏失败" title:@"提示"];
            });
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"添加收藏请求失败-%@",error);
        
    }];
}



#pragma mark - 取消收藏
/**
 *  取消收藏
 */
- (void)cancleCollectionActionWithType:(NSInteger)type
{
    NSString *url = [NSString stringWithFormat:@"%@canclecollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"productid"] = self.productId;
    parameters[@"type"] = @(type);// 1:物品 2:服务
    
    YYLog(@"取消收藏参数：%@",parameters);
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"取消收藏请求返回-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result == 1000) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"取消收藏成功" title:@"提示"];
                
                [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
                
                self.isCollection = NO;
                
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



#pragma mark - 获取指定用户的全部收藏物
/**
 *  获取指定用户的全部收藏物的点击事件
 */
- (void)allCollectionAction
{
    NSString *url = [NSString stringWithFormat:@"%@getallcollectionservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"currentPage"] = @(0);
    
    NSInteger type;
    if ([self.title isEqualToString:@"保养维护详情"])
    {
        type = 2;
    }
    else if ([self.title isEqualToString:@"商品详情"])
    {
        type = 1;
    }
    else
    {
        type = 3;
    }
    parameters[@"type"] = @(type);
    
    YYLog(@"获取指定用户的全部收藏物的parameters===%@",parameters);
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"获取指定用户的全部收藏物请求返回-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result == 1000)
        {        
            NSArray *array = responseObject[@"body"];
            
            NSMutableArray *mArray = [CollectionModel mj_objectArrayWithKeyValuesArray:array];
            
            for (CollectionModel *collectionModel in mArray)
            {
                [self.collectionIdArray addObject:collectionModel.productid];
            }

            
            // 收藏过的数据里包含这个id则显示取消收藏 self.collectionModel.ID
            if ([self.collectionIdArray containsObject:self.productId])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                
                    // 取消收藏
                    [self.collectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
                });
            }
            // 否则显示添加收藏
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // 添加收藏
                    [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
                    
                });
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"获取指定用户的全部收藏物请求失败-%@",error);
        
    }];
}



- (void)tapAction
{
    [self.coverView removeFromSuperview];
    
    [self.okAddCartButton removeFromSuperview];
}


// 加入购物车-立即购买
- (void)addCountAction:(UIButton *)button
{
    if ([UserInfo sharedUserInfo].isLogin)
    {
        self.countNumber = 1;
        
        self.appearCount++;
        
        CGFloat coverViewHeight = KScreenHeight - Klength44;
        self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, coverViewHeight)];
        self.coverView.backgroundColor = [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:0.8];
        self.coverView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self.coverView addGestureRecognizer:tap];
        [self.view addSubview:self.coverView];
        [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
        
        
        
        CGFloat countViewheight = 205;
        CGFloat countViewY = coverViewHeight - countViewheight;
        self.countView = [[UIView alloc] initWithFrame:CGRectMake(0, countViewY, KScreenWidth, countViewheight)];
        self.countView.backgroundColor = [UIColor whiteColor];
        self.countView.userInteractionEnabled = YES;
        [self.coverView addSubview:self.countView];
        
        
        
        
        CGFloat coverPicViewX = 16;
        CGFloat coverPicViewY = coverViewHeight - countViewheight - 57;
        CGFloat coverPicViewWidth = 0.6 * KScreenWidth;
        CGFloat coverPicViewHeight = 107 + 12 + 12;
        self.coverPicView = [[UIView alloc] initWithFrame:CGRectMake(coverPicViewX, coverPicViewY, coverPicViewWidth, coverPicViewHeight)];
        self.coverPicView.layer.cornerRadius = BtncornerRadius;
        self.coverPicView.backgroundColor = [UIColor whiteColor];
        [self.coverView addSubview:self.coverPicView];
        
        
        
        
        CGFloat picViewX = 16;
        CGFloat picViewY = 12;
        CGFloat picViewWidth = coverPicViewWidth - 2 * picViewX;
        CGFloat picViewHight = 107;
        self.picView = [[UIImageView alloc] initWithFrame:CGRectMake(picViewX, picViewY, picViewWidth, picViewHight)];
        [self.coverPicView addSubview:self.picView];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,_imagesArray.firstObject]];
        [self.picView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
        
        
        
        CGFloat selectCountLabelX = 50;
        CGFloat selectCountLabelY = countViewheight - 50 - 3 * Klength20;
        CGFloat selectCountLabelWidth = (coverPicViewWidth + 16) - 100;
        self.selectCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectCountLabelX, selectCountLabelY, selectCountLabelWidth, Klength30)];
        self.selectCountLabel.text = @"选择数量";
        [self.countView addSubview:self.selectCountLabel];
        
        
        
        CGFloat priceLabelX = coverPicViewX + coverPicViewWidth + 20;
        CGFloat priceLabelY = 30;
        CGFloat priceLabelWidth = KScreenWidth - priceLabelX - coverPicViewX;
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabelX, priceLabelY, priceLabelWidth, Klength30)];
        self.priceLabel.text = [NSString stringWithFormat:@"%@星币",self.price];
        self.priceLabel.font = Font18;
        [self.countView addSubview:self.priceLabel];
        
        
        
        CGFloat minusButtonX = coverPicViewX + coverPicViewWidth;
        CGFloat minusButtonY = selectCountLabelY;
        CGFloat minusButtonWidth = Klength30;
        self.minusButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.minusButton.frame = CGRectMake(minusButtonX, minusButtonY, minusButtonWidth, minusButtonWidth);
        [self.minusButton setImage:[UIImage imageNamed:@"minus"] forState:(UIControlStateNormal)];
        [self.minusButton addTarget:self action:@selector(minusCountAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.countView addSubview:self.minusButton];
        
        
        
        CGFloat countLabelX = minusButtonX + minusButtonWidth;
        CGFloat countLabelWidth = 44;
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(countLabelX, minusButtonY, countLabelWidth, Klength30)];
        
        self.countNum = [NSString stringWithFormat:@"%ld",self.countNumber];
        
        [self addObserver:self forKeyPath:@"countNum" options:(NSKeyValueObservingOptionNew) context:nil];
        
        
        
        self.countLabel.text = self.countNum;
        self.countLabel.textAlignment = 1;
        [self.countView addSubview:self.countLabel];
        
        
        
        CGFloat plusButtonX = countLabelX + countLabelWidth;
        self.plusButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.plusButton.frame = CGRectMake(plusButtonX, minusButtonY, minusButtonWidth, minusButtonWidth);
        [self.plusButton setImage:[UIImage imageNamed:@"plus"] forState:(UIControlStateNormal)];
        [self.plusButton addTarget:self action:@selector(plusCountAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.countView addSubview:self.plusButton];
        
        
        
        
        CGFloat memberDiscountLabelY = selectCountLabelY + Klength30;
        self.memberDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectCountLabelX, memberDiscountLabelY, selectCountLabelWidth, Klength30)];
        self.memberDiscountLabel.text = @"会员折扣";
        [self.countView addSubview:self.memberDiscountLabel];
        
        
        
        
        CGFloat discountLabelWidth = minusButtonWidth + countLabelWidth + minusButtonWidth;
        self.discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(minusButtonX, memberDiscountLabelY, discountLabelWidth, Klength30)];
        self.discountLabel.text = [NSString stringWithFormat:@"%.f折",[UserInfo sharedUserInfo].discount];
        self.discountLabel.textAlignment = 1;
        [self.countView addSubview:self.discountLabel];
        
        
        
        
        CGFloat actuallyPaidLabelY = memberDiscountLabelY + Klength30;
        self.actuallyPaidLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectCountLabelX, actuallyPaidLabelY, selectCountLabelWidth, Klength30)];
        self.actuallyPaidLabel.text = @"实付金额";
        [self.countView addSubview:self.actuallyPaidLabel];
        
        
        
        self.paidLabel = [[UILabel alloc] initWithFrame:CGRectMake(minusButtonX, actuallyPaidLabelY, discountLabelWidth, Klength30)];
        [self changeModelCount];
        self.paidLabel.textAlignment = 1;
        [self.countView addSubview:self.paidLabel];
        
        
        
        
        self.okAddCartButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.okAddCartButton.frame = CGRectMake(0, KScreenHeight - Klength44, KScreenWidth, Klength44);
        self.okAddCartButton.backgroundColor = [UIColor redColor];
        
        
        if (button.tag == 111)
        {
            [self.okAddCartButton setTitle:@"加入购物车" forState:(UIControlStateNormal)];
            [self.okAddCartButton addTarget:self action:@selector(okAddCartAction) forControlEvents:(UIControlEventTouchUpInside)];
        }
        else if (button.tag == 112)
        {
            [self.okAddCartButton setTitle:@"结算" forState:(UIControlStateNormal)];
            [self.okAddCartButton addTarget:self action:@selector(settlementAction) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
        [self.okAddCartButton setTintColor:[UIColor whiteColor]];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.okAddCartButton];
    }
    else
    {
        // 提示用户先登录
        [[AlertView sharedAlertView] loginAction];
    }
}


- (void)settlementAction
{
    [self.coverView removeFromSuperview];
    [self.okAddCartButton removeFromSuperview];
    //显示确认支付的金额
    self.totalStar = @"0";
    
    if (self.productType == 1) {//商品
        self.totalStar = [NSString stringWithFormat:@"%ld",(long)self.productModel.realPrice];
    }else//服务
    {
        self.totalStar = [NSString stringWithFormat:@"%ld",(long)_serviceModel.realPrice];
    }
    NSString *message = [NSString stringWithFormat:@"支付%@星币？",self.totalStar];

    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        //清空购物车
        [self buyProductInShoppingCar];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}



-(void)buyProductInShoppingCar
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    NSMutableDictionary *productDic = [NSMutableDictionary dictionary];
    //模型转字典
    if (self.productType == 1)//商品
    {
        productDic = [self.productModel mj_keyValues];
        parmas[@"totalprice"] = @(self.productModel.realPrice);
    }else if (self.productType == 2)//服务
    {
        productDic = [self.serviceModel mj_keyValues];
        parmas[@"totalprice"] = @(self.serviceModel.realPrice);
    }
    
    //拼接josn数据
    YYLog(@"productDic---%@",productDic);
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:productDic options:0 error:&error];
    NSString *dataStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"productlist"] = [NSString stringWithFormat:@"[%@]",dataStr];;
    parmas[@"type"] = @"1";//1是直接购买  2是购物车购买
    
    YYLog(@"购买parmas--:%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@payment/shopcar/servlet",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"购买返回：%@",json);
         NSNumber *num = json[@"resultCode"];
         if ([num integerValue] == 1000)//返回成功
         {
             //跳转
             BuyingSuccessListModel *model = [BuyingSuccessListModel mj_objectWithKeyValues:json];
             BuyingSuccessList *vc = [[BuyingSuccessList alloc] initWithStyle:UITableViewStyleGrouped];
             vc.model = model;
             [self.navigationController pushViewController:vc                              animated:YES];
         }
         
         
     } failure:^(NSError *error) {
         YYLog(@"购买返回错误%@",error);
     }];
    
}






- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{    
    NSString *newNum = [change objectForKey:@"new"];
    
    self.countLabel.text = newNum;
}



- (void)minusCountAction
{
    if (self.countNumber > 0)
    {
        self.countNumber--;
    }
    else
    {
        self.countNumber = 0;
    }

    //计算count
    self.productType == 1 ? (self.productModel.count = self.countNumber):(self.serviceModel.count = self.countNumber);
    
    
    self.countNum = [NSString stringWithFormat:@"%ld",self.countNumber];
    //计算count
    [self changeModelCount];
}

- (void)plusCountAction
{
    self.countNumber++;
    self.countNum = [NSString stringWithFormat:@"%ld",self.countNumber];
    //计算count
    [self changeModelCount];
}


    //计算count
-(void)changeModelCount
{
    //计算count
    self.productType == 1 ? (self.productModel.count = self.countNumber):(self.serviceModel.count = self.countNumber);
    self.productModel.productid = self.productModel.ID;
    self.serviceModel.productid = self.serviceModel.ID;
    self.serviceModel.buytype = 2;//服务
    NSInteger realPrice = self.productType == 1 ? self.productModel.realPrice : self.serviceModel.realPrice;
    self.paidLabel.text = [NSString stringWithFormat:@"%ld星币",(long)realPrice];

}




- (void)okAddCartAction
{
    YYLog(@"确定加入购物车");
    if ([self.title isEqualToString:@"商品详情"])
    {
        [self addCartWithType:1];
    }
    else
    {
        [self addCartWithType:2];
    }
}




- (void)addCartWithType:(NSInteger)type
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"productid"] = self.productId;
    parameters[@"type"] = @(type);// 1:商品 2:服务
    parameters[@"count"] = self.countNum;

    YYLog(@"加入购物车参数：%@",parameters);
    
    NSString *url = [NSString stringWithFormat:@"%@add/shopping/car?",URL];
 
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"加入购物车返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            [[AlertView sharedAlertView] addAfterAlertMessage:@"成功加入购物车" title:@"提示"];
        }
        
        [self.coverView removeFromSuperview];
        
        [self.okAddCartButton removeFromSuperview];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"加入购物车错误：%@",error);
    }];
}



- (void)chatAction
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.telNum]];
    
    if ( !_webView )
    {
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:phoneURL]];

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
    if ([self.title isEqualToString:@"商品详情"])
    {
        return 9;
    }
    else if ([self.title isEqualToString:@"保养维护详情"])
    {
        return 6;
    }
    else
    {
        return 10;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.title isEqualToString:@"商品详情"])
    {
        if (indexPath.row == 6)
        {
            CGFloat height = [UITableViewCell heightForString:_productModel.introduction WithFontSize:14];
            
            return height + 20;
        }
        else if (indexPath.row == 7)
        {
            CGFloat height = [UITableViewCell heightForString:_productModel.introduction WithFontSize:14];
            
            return height + 20;
        }
        else
        {
            return 40;
        }
    }
    else if ([self.title isEqualToString:@"二手车详情"])
    {
        if (indexPath.row == 9)
        {
            CGFloat height = [UITableViewCell heightForString:_carModel.property WithFontSize:14];
            
            return height + 20;
        }
        else if (indexPath.row == 10)
        {
            CGFloat height = [UITableViewCell heightForString:_carModel.carDescription WithFontSize:14];
            
            return height + 20;
        }
        else
        {
            return 40;
        }
    }
    else
    {
        return 40;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    if ([self.title isEqualToString:@"商品详情"])
    {
        if (indexPath.row == 6)
        {
            CGFloat height = [UITableViewCell heightForString:_productModel.introduction WithFontSize:14];

            cell.detailTextLabel.height = height + 20;
        }
        else if (indexPath.row == 7)
        {
            CGFloat height = [UITableViewCell heightForString:_productModel.introduction WithFontSize:14];
            
            cell.detailTextLabel.height = height + 20;
        }
        if (indexPath.row == 1)
        {
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
    }
    else if ([self.title isEqualToString:@"二手车详情"])
    {
        if (indexPath.row == 9)
        {
            CGFloat height = [UITableViewCell heightForString:_carModel.property WithFontSize:14];
            
            cell.detailTextLabel.height = height + 20;
        }
        else if (indexPath.row == 10)
        {
            CGFloat height = [UITableViewCell heightForString:_carModel.carDescription WithFontSize:14];
            
            cell.detailTextLabel.height = height + 20;
        }
    }
    
    if ([self.title isEqualToString:@"商品详情"])
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = _productModel.productname;
                break;
            case 1:
                cell.textLabel.text = [NSString stringWithFormat:@"%@星币",_productModel.price];
                break;
            case 2:
                cell.textLabel.text = [NSString stringWithFormat:@"类型：%@",_productModel.productmodel];
                break;
            case 3:
                cell.textLabel.text = [NSString stringWithFormat:@"规格：%@",_productModel.specifications];
                break;
            case 4:
                cell.textLabel.text = [NSString stringWithFormat:@"适用车型：%@",_productModel.applycar];
                break;
            case 5:
                cell.textLabel.text = [NSString stringWithFormat:@"供应商：%@",_productModel.vendors];
                break;
            case 6:
                cell.textLabel.text = [NSString stringWithFormat:@"简介：%@",_productModel.introduction];
                break;
            case 7:
                cell.textLabel.text = [NSString stringWithFormat:@"备注：%@",_productModel.remark];
                break;
                
            default:
                break;
        }
    }
    else if ([self.title isEqualToString:@"保养维护详情"])
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = _serviceModel.services;
                break;
            case 1:
                cell.textLabel.text = [NSString stringWithFormat:@"%@星币",_serviceModel.price];
                break;
            case 2:
                cell.textLabel.text = [NSString stringWithFormat:@"类型：%@",_serviceModel.servicetype];
                break;
            case 3:
                cell.textLabel.text = [NSString stringWithFormat:@"服务内容：%@",_serviceModel.content];
                break;
            case 4:
                cell.textLabel.text = [NSString stringWithFormat:@"保修期限：%@",_serviceModel.warranty];
                break;
            case 5:
                cell.textLabel.text = [NSString stringWithFormat:@"预计耗时：%@小时",_serviceModel.manhours];
                break;
        }
    }
    else
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = _carModel.brand;
                break;
            case 1:
                cell.textLabel.text = [NSString stringWithFormat:@"%@万",_carModel.price];
                break;
            case 2:
                cell.textLabel.text = [NSString stringWithFormat:@"型号：%@",_carModel.model];
                break;
            case 3:
                cell.textLabel.text = [NSString stringWithFormat:@"行驶里程：%@",_carModel.mileage];
                break;
            case 4:
                cell.textLabel.text = [NSString stringWithFormat:@"购买年份：%@",_carModel.buytime];
                break;
            case 5:
                cell.textLabel.text = [NSString stringWithFormat:@"原车主：%@",_carModel.person];
                break;
            case 6:
                cell.textLabel.text = [NSString stringWithFormat:@"车牌号：%@",_carModel.number];
                break;
            case 7:
                cell.textLabel.text = [NSString stringWithFormat:@"车架号：%@",_carModel.frameid];
                break;
            case 8:
                cell.textLabel.text = [NSString stringWithFormat:@"使用性质：%@",_carModel.property];
                break;
            case 9:
                cell.textLabel.text = [NSString stringWithFormat:@"车辆简介：%@",_carModel.carDescription];
                break;

            default:
                break;
        }
    }
    
    return cell;
}








- (void)dealloc
{
    YYLog(@"视图出现次数：%ld",self.appearCount);
    
    for (NSInteger i = 0; i < self.appearCount; i++)
    {
        [self removeObserver:self forKeyPath:@"countNum" context:nil];
    }
    
}





- (ProductModel *)productModel
{
    if (!_productModel)
    {
        _productModel = [[ProductModel alloc] init];
    }
    
    return _productModel;
}




- (ServiceModel *)serviceModel
{
    if (!_serviceModel)
    {
        _serviceModel = [[ServiceModel alloc] init];
    }
    
    return _serviceModel;
}



- (CarModel *)carModel
{
    if (!_carModel)
    {
        _carModel = [[CarModel alloc] init];
    }
    
    return _carModel;
}




- (CollectionModel *)collectionModel
{
    if (!_collectionModel)
    {
        _collectionModel = [[CollectionModel alloc] init];
    }
    
    return _collectionModel;
}




- (NSMutableArray *)collectionArray
{
    if (!_collectionArray)
    {
        _collectionArray = [NSMutableArray array];
    }
    
    return _collectionArray;
}




- (NSMutableArray *)collectionIdArray
{
    if (!_collectionIdArray)
    {
        _collectionIdArray = [NSMutableArray array];
    }
    
    return _collectionIdArray;
}







@end



















