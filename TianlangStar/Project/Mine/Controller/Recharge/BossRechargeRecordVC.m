//
//  ViewController.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BossRechargeRecordVC.h"
#import "VirtualcenterModel.h"
#import "RechargeRecoredCell.h"
#import "BossRechargeScoreCell.h"
#import "UWDatePickerView.h"

typedef enum : NSUInteger
{
    timeSearch = 0,
    userSearch,
    paySearch,
    priceSearch
} rechargeSearchType;

#define tableViewH KScreenHeight - 64 - 44

#define StableViewH KScreenHeight - 64 - 40 - 70 - 8


@interface BossRechargeRecordVC ()<UITableViewDelegate,UITableViewDataSource,UWDatePickerViewDelegate,UITextFieldDelegate>

/** 设置tableView */
@property (nonatomic,weak) UITableView *tableView;


/** 当前页 */
@property (nonatomic,assign) BOOL currentPage;

/** 获取服务器返回的充值记录 */
@property (nonatomic,strong) NSMutableArray *recoredArr;


/** 积分或者是星币的总额 */
@property (nonatomic,weak) UILabel *totalStarLable;

/** 积分或者是星币的总额 */
@property (nonatomic,weak) UILabel *totalCountLable;



/** 发送请求的类型 */
@property (nonatomic,assign) rechargeSearchType searchType;

/** 查询的大的条件框 */
@property (nonatomic,weak) UIView *queryView;

/** 蒙版 */
@property (nonatomic,weak) UIView *coverView;

/** 蒙版 */
@property (nonatomic,weak) UIView *footerView;

/** 时间查询的起始时间 */
@property (nonatomic,copy) NSString *startTime;

/** 时间查询的结束 */
@property (nonatomic,copy) NSString *endtTime;

/** 按时间查询的容器 */
@property (nonatomic,weak) UIView *timeView;


/** 记录当前搜索容器框的搜索View */
@property (nonatomic,strong) UIView *currentsearchView;

/** 按账户查询的容器 */
@property (nonatomic,strong) UIView *accountView;

/** 按项目查询的容器 */
@property (nonatomic,strong) UIView *productView;

/** 按时间查询的容器 */
@property (nonatomic,strong) UIView *timeSearchView;

/** 按价格查询的容器 */
@property (nonatomic,strong) UIView *priceSearchView;


/** 按用户查询输入框 */
@property (nonatomic,weak) UITextField *accountText;


/** 开始时间 */
@property (nonatomic,strong) UITextField *startText;

/** 结束时间 */
@property (nonatomic,strong) UITextField *endText;

/** 开始金额 */
@property (nonatomic,strong) UITextField *startPriceText;

/** 结束金额 */
@property (nonatomic,strong) UITextField *endPriceText;

/** 结束金额 */
@property (nonatomic,strong) UITextField *productText;


/** 记录时间选择器 */
@property (nonatomic,assign) NSInteger timetpye;


/** 请求参数 */
@property (nonatomic,strong) NSMutableDictionary *parmas;

/** 时间选择器 */
@property (nonatomic,weak) UWDatePickerView *dateView;

/** 记录当前时间 */
@property (nonatomic,copy) NSString *currentDate;


/** 总价格 */
@property (nonatomic,weak) UILabel *totalPrice;

/** 总积分 */
@property (nonatomic,weak) UILabel *totalScore;

/** 总个数 */
@property (nonatomic,weak) UILabel *itemCount;


/** 查询按钮点击后的参数拼接 */
@property (nonatomic,strong) NSMutableDictionary *newparmas;

@end

@implementation BossRechargeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = BGcolor;
    
    [self setupTableView];
    
    [self addrightBar];
    
    [self setupFooterView];
    
    self.title = self.rechareType == 1 ? @"星币充值记录":@"积分充值记录";
    
}


-(void)addrightBar
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)rightBarClick
{
    if (!_coverView)
    {
        [self addCoverView];
    }else
    {
        self.coverView.hidden = NO;
    }

}


//显示查询导出框
-(void)addCoverView
{
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 800)];
    cover.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    
    //    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth - 150, 64, 150, 80)];
    //    rightView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"drop-down"]];
    UIImageView *rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop-down"]];
    rightView.userInteractionEnabled = YES;
    rightView.x = KScreenWidth - rightView.width - 5;
    rightView.y = 64 ;
    
    [cover addSubview:rightView];
    
    CGFloat centerY= rightView.height * 0.5;
    
    UIButton *modificationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, centerY - 30, rightView.width, 30)];
    modificationBtn.centerX = rightView.width * 0.5;
    //    modificationBtn.backgroundColor = [UIColor orangeColor];
    modificationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    [modificationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [modificationBtn setTitle:@"查询" forState:UIControlStateNormal ];
    [modificationBtn setImage:[UIImage imageNamed:@"inquire"] forState:UIControlStateNormal];
    [modificationBtn setTitle:@"取消" forState:UIControlStateSelected ];
    [modificationBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:modificationBtn];
    
    UIButton *exportBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, centerY, rightView.width, 50)];
    exportBtn.centerX = rightView.width * 0.5;
    [exportBtn setTitle:@"导出" forState:UIControlStateNormal ];
    exportBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    [exportBtn setImage:[UIImage imageNamed:@"educe"] forState:UIControlStateNormal];
    [exportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [exportBtn addTarget:self action:@selector(exportBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:exportBtn];
    
    self.coverView = cover;
    UIGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch)];
    [cover addGestureRecognizer:touch];
    
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    //    [self.view addSubview:cover];
    //    cover.hidden = YES;
}


//点击蒙版消除
-(void)touch
{
    self.coverView.hidden = YES;
}


//导出按钮的点击事件
-(void)exportBtnClick:(UIButton *)button
{
    self.coverView.hidden = YES;
    
    YYLog(@"导出");
    
//        NSString *url = [NSString stringWithFormat:@"%@export/finance/list",URL];
    
//    NSMutableDictionary *parmas = self.newparmas ? self.newparmas : self.parmas;
    
    
//    YYLog(@"parmas-----:%@",parmas);
    

}

-(void)searchBtnClick:(UIButton *)button
{
    
    button.selected = !button.selected;
    self.coverView.hidden = YES;
    
    if (button.selected)//点击的是查询.添加搜索框
    {
        [self searchSetupQueryView];
    }else
    {
        [self.queryView removeFromSuperview];
        self.tableView.y = 64;
        self.tableView.height = tableViewH;
    }
}


#pragma mark===== 查询，导出按钮的点击事件=======

-(void)searchSetupQueryView
{
    
    UIView *queryView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 77)];
    queryView.backgroundColor = [UIColor whiteColor];
    self.queryView = queryView;
    [self.view insertSubview:queryView belowSubview:self.coverView];
    
    NSArray *arr = @[@"按时间",@"用户名",@"类型"];
    if (_rechareType == 2) {
        arr = @[@"按时间",@"用户名"];
    }
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:arr];
    segment.frame = CGRectMake(0, 0, KScreenWidth * 0.9, 44);
    segment.centerX = KScreenWidth * 0.5;
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor whiteColor];
    segment.backgroundColor = [UIColor whiteColor];
    
    //设置颜色
    NSDictionary *normalDic=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    [segment setTitleTextAttributes:normalDic forState:(UIControlStateNormal)];
    
    NSDictionary *normalDicSeleted=@{NSForegroundColorAttributeName:[UIColor blueColor]};
    [segment setTitleTextAttributes:normalDicSeleted forState:UIControlStateSelected];
    
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    [queryView addSubview:segment];

    //添加搜索
    [queryView addSubview:self.timeSearchView];
    //记录
    self.currentsearchView = self.timeSearchView;

    //下面的分割线
    CGFloat marginX = 10;
    CGFloat lineW = KScreenWidth -2 * marginX;
    CGFloat lineY = CGRectGetMaxY(segment.frame);
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(marginX, lineY, lineW, 1)];
    lineView.backgroundColor = BGcolor;
    [queryView addSubview:lineView];
    
    self.tableView.y = CGRectGetMaxY(queryView.frame);
    self.tableView.height = StableViewH;
}

#pragma mark===按项目或者按用户查询输入框==================
/** 按用户查询输入框 */
-(UIView *)accountView
{
    if (!_accountView)
    {
        CGFloat margin = 25;
        
        UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, KScreenWidth, 36)];
        
        CGFloat width = KScreenWidth - 3 * margin - 50;
        UITextField *accountText = [[UITextField alloc] initWithFrame:CGRectMake(margin, 6, width, 24)];
        accountText.layer.cornerRadius = 5;
        accountText.layer.masksToBounds = YES;
        accountText.font = Font14;
        accountText.textAlignment = NSTextAlignmentCenter;
        accountText.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.accountText = accountText;
        
        CGFloat BtnX = CGRectGetMaxX(accountText.frame) + margin;
        UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(BtnX, 3, 50, 30)];
        [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [accountView addSubview:searchBtn];
        [accountView addSubview:accountText];
        
        accountView.backgroundColor = [UIColor whiteColor];
        self.accountView = accountView;
    }
    return _accountView;
}

/** 按项目查询输入框 */
-(UIView *)productView
{
    if (!_productView)
    {
        CGFloat margin = 25;
        
        UIView *productView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, KScreenWidth, 36)];
        CGFloat width = KScreenWidth - 3 * margin - 50;
        UITextField *accountText = [[UITextField alloc] initWithFrame:CGRectMake(margin, 6, width, 24)];
        accountText.layer.cornerRadius = 5;
        accountText.layer.masksToBounds = YES;
        accountText.font = Font14;
        accountText.textAlignment = NSTextAlignmentCenter;
        accountText.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.productText = accountText;
        
        CGFloat BtnX = CGRectGetMaxX(accountText.frame) + margin;
        UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(BtnX, 3, 50, 30)];
        [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [productView addSubview:searchBtn];
        [productView addSubview:accountText];
        
        productView.backgroundColor = [UIColor whiteColor];
        self.productView = productView;
    }
    
    
    return _productView;
}



#pragma mark===按时间查询输入框==================
/** 按时间查询输入框 */
-(UIView *)timeSearchView
{
    if (!_timeSearchView)
    {
        CGFloat margin = 25;
        UIView *timeSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, KScreenWidth, 36)];
        
        CGFloat width = (KScreenWidth - 3 * margin - 50) * 0.5 - 30;
        UITextField *startText = [[UITextField alloc] initWithFrame:CGRectMake(margin, 6, width, 24)];
        startText.layer.cornerRadius = 5;
        startText.layer.masksToBounds = YES;
        startText.font = Font14;
        startText.textAlignment = NSTextAlignmentCenter;
        startText.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        startText.placeholder = @"起始时间";
        startText.tag = 1;
        startText.text = [startText.text getCurrentTime];
        self.startText = startText;
        startText.delegate = self;
        //        startText.text = @"2015-12-33";
        [timeSearchView addSubview:startText];
        
        CGFloat lineViewX = CGRectGetMaxX(startText.frame) + 5;
        
        //设置分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, 18, 40, 1)];
        lineView.backgroundColor = [UIColor grayColor];
        [timeSearchView addSubview:lineView];

        
        CGFloat endTextX = CGRectGetMaxX(startText.frame) + 50;
        UITextField *endText = [[UITextField alloc] initWithFrame:CGRectMake(endTextX, 6, width, 24)];
        endText.layer.cornerRadius = 5;
        endText.layer.masksToBounds = YES;
        endText.font = Font14;
        endText.textAlignment = NSTextAlignmentCenter;
        endText.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        endText.placeholder = @"结束时间";
        endText.tag = 2;
        endText.text = [startText.text getCurrentTime];
        endText.delegate = self;
        self.endText = endText;
        [timeSearchView addSubview:endText];
        
        
        CGFloat BtnX = KScreenWidth - 50 - margin;
        UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(BtnX, 3, 50, 30)];
        [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [timeSearchView addSubview:searchBtn];
        
        
        timeSearchView.backgroundColor = [UIColor whiteColor];
        self.timeSearchView = timeSearchView;
    }
    return _timeSearchView;
}

#pragma mark===按金额查询输入框==================
/** 按金额查询输入框 */
-(UIView *)priceSearchView
{
    if (!_priceSearchView)
    {
        CGFloat margin = 25;
        
        UIView *priceSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, KScreenWidth, 36)];
        self.priceSearchView = priceSearchView;
        
        CGFloat width = (KScreenWidth - 3 * margin - 140) * 0.5 ;
        UITextField *startText = [[UITextField alloc] initWithFrame:CGRectMake(margin, 6, width, 24)];
        startText.layer.cornerRadius = 5;
        startText.layer.masksToBounds = YES;
        startText.font = Font14;
        startText.textAlignment = NSTextAlignmentCenter;
        startText.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        startText.placeholder = @"起始";
        self.startPriceText = startText;
        [priceSearchView addSubview:startText];
        
        
        CGFloat lineViewX = CGRectGetMaxX(startText.frame) + 5;
        
        //设置分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, 18, 10, 1)];
        lineView.backgroundColor = [UIColor grayColor];
        [priceSearchView addSubview:lineView];
        
        CGFloat endTextX = CGRectGetMaxX(lineView.frame) + 5;
        UITextField *endText = [[UITextField alloc] initWithFrame:CGRectMake(endTextX, 6, width, 24)];
        endText.layer.cornerRadius = 5;
        endText.layer.masksToBounds = YES;
        endText.font = Font14;
        endText.textAlignment = NSTextAlignmentCenter;
        endText.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        endText.placeholder = @"结束";
        self.endPriceText = endText;
        [priceSearchView addSubview:endText];
        
        
        CGFloat BtnX = CGRectGetMaxX(endText.frame) + margin;
        UIButton *starBtn = [[UIButton alloc] initWithFrame:CGRectMake(BtnX, 5, 50, 26)];
        [starBtn setTitle:@"星币" forState:UIControlStateNormal];
        starBtn.backgroundColor = Tintcolor;
        starBtn.layer.cornerRadius = 5;
        starBtn.layer.masksToBounds = YES;
        starBtn.titleLabel.font = Font14;
        starBtn.tag = 4;
        [starBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
        [priceSearchView addSubview:starBtn];
        
        UIButton *integralBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starBtn.frame) + 10, 5, 50, 26)];
        [integralBtn setTitle:@"积分" forState:UIControlStateNormal];
        integralBtn.backgroundColor = Tintcolor;
        integralBtn.layer.cornerRadius = 5;
        integralBtn.layer.masksToBounds = YES;
        integralBtn.titleLabel.font = Font14;
        integralBtn.tag = 5;
        [integralBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
        [priceSearchView addSubview:integralBtn];
        
        priceSearchView.backgroundColor = [UIColor whiteColor];
    }
    return _priceSearchView;
}


-(NSMutableDictionary *)parmas
{
    if (!_parmas)
    {
        _parmas = [NSMutableDictionary dictionary];
        _parmas[@"pageNum"] = @"1";
        _parmas[@"pageSize"] = @"10";
        _parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
        self.parmas[@"type"] = @"1";
        
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        
        self.startText.text = dateString;
        self.endText.text = dateString;
        
        self.parmas[@"startTime"] = dateString;
        self.parmas[@"endTime"] = dateString;
        
    }
    return _parmas;
}


-(void)searchClick:(UIButton *)button
{
    [self.view endEditing:YES];
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"pageNum"] = @"1";
    parmas[@"pageSize"] = @"10";
    parmas[@"type"] = @(self.searchType + 1);
    
    
    switch (self.searchType)
    {
        case timeSearch://时间
        {
            YYLog(@"%@",self.startText.text);
            YYLog(@"%@",self.endText.text);
            
            parmas[@"startTime"] = self.startText.text;
            parmas[@"endTime"] = self.endText.text;
            break;
        }
            
        case userSearch://账户
        {
            YYLog(@"账户--%@",self.accountText.text);
            if (![self.accountText.text isMobileNumber]) {//不是手机号
                [[AlertView sharedAlertView] addAlertMessage:@"请输入正确的手机号！" title:@"提示"];
                return;
            }
            parmas[@"account"] = self.accountText.text;
            break;
        }
            
//        case paySearch://项目
//        {
//            YYLog(@"项目--%@",self.productText.text);
//            if (self.productText.text.length == 0 || self.productText.text == nil) {
//                
//                [[AlertView sharedAlertView] addAlertMessage:@"请输入查询条件" title:@"提示"];
//                return;
//            }
//            
////            parmas[@"product"] = self.productText.text;
//            break;
//        }
        case priceSearch://积分/金币
        {
            YYLog(@"%@",self.startPriceText.text);
            YYLog(@"%@",self.endPriceText.text);
            parmas[@"minMoney"] = self.startPriceText.text;
            parmas[@"maxMoney"] = self.endPriceText.text;
            parmas[@"type"] = @(button.tag);
            break;
        }
            
        default:
            break;
    }
    
    self.newparmas = parmas;
    
    YYLog(@"self.parm as----%@",self.parmas);
    [self loadNewRecord];
}




-(void)setupFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 44, KScreenWidth, 44)];
//    footerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:footerView];
    //设置header
    NSArray *titleArr = @[@"合计",@"0积分",@"0笔"];
    CGFloat width = KScreenWidth / titleArr.count;

    for (NSInteger i = 0; i < titleArr.count; i++) {
        UILabel *lable = [[UILabel alloc] init];
        lable.y = 0;
        lable.x = i * width;
        lable.height  = 44;
        lable.width = width;
        lable.textAlignment = NSTextAlignmentCenter;
        
        switch (i) {
            case 1:
                self.totalStarLable = lable;
                break;
            case 2:
                self.totalCountLable = lable;
                break;
                
            default:
                break;
        }
        
        lable.text = titleArr[i];
        [footerView addSubview:lable];
    }
}


-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108 - 44, KScreenWidth, KScreenHeight - 108 ) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    CGFloat count = 4;
    if (self.rechareType == 2) {
        count = 3;
    }
    
    //设置header
    NSArray *titleArr = @[@"时间",@"积分数量",@"用户名",@"类型"];
    CGFloat width = KScreenWidth / count;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
    
    for (NSInteger i = 0; i < count; i++) {
        UILabel *lable = [[UILabel alloc] init];
        lable.y = 0;
        lable.x = i * width;
        lable.height  = 44;
        lable.width = width;
        lable.textAlignment = NSTextAlignmentCenter;

        lable.text = titleArr[i];
        
        [headerView addSubview:lable];

    }
    
    self.tableView.tableHeaderView = headerView;
    
    //增加上下拉刷新
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRecord)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header isAutomaticallyChangeAlpha];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRecord)];

}


-(void)loadNewRecord
{
    [self.tableView.mj_footer endRefreshing];
    self.currentPage = 1;
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"] = @(self.currentPage);
    parmas[@"type"] = @(self.rechareType);

    NSString *url = [NSString stringWithFormat:@"%@getrechargehistory",URL];
    
    YYLog(@"%@%@",parmas,url);
    
    [HttpTool post:url parmas:parmas success:^(id json) {
        [self.tableView.mj_header endRefreshing];
        self.recoredArr = [VirtualcenterModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"allRecord"]];
        YYLog(@"%@",json);
        if (self.recoredArr.count > 0)
        {
            self.currentPage++;
            
            NSString *scoreStr = [NSString stringWithFormat:@"%@积分",json[@"body"][@"totalPrice"]];
            NSString *starStr = [NSString stringWithFormat:@"%@星币",json[@"body"][@"totalPrice"]];
            self.totalStarLable.text = self.rechareType == 1 ? starStr : scoreStr;
            self.totalCountLable.text = [NSString stringWithFormat:@"%@笔",json[@"body"][@"total"]];
        }
        [self.tableView reloadData];
        
        
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        YYLog(@"%@",error);
    }];
    
}



#pragma mark===顶部的选择按钮的点击事件==============================
-(void)segmentClick:(UISegmentedControl *)segment
{
    //先移除
    [self.currentsearchView removeFromSuperview];
    [self.dateView removeFromSuperview];
    
    
    self.searchType = segment.selectedSegmentIndex;
    //判断搜索条件
    switch (self.searchType)
    {
        case timeSearch:
        {
            [self.queryView addSubview:self.timeSearchView];
            self.currentsearchView = self.timeSearchView;
            
            break;
        }
        case userSearch:
        {
            [self.queryView addSubview:self.accountView];
            self.currentsearchView = self.accountView;
            self.accountText.placeholder = @"请输入手机号";
            
            break;
        }
        case paySearch:
        {
            [self.queryView addSubview:self.productView];
            self.currentsearchView = self.productView;
            self.productText.placeholder = @"请输入类型1--现金 2--网转";
            
            break;
        }
        case priceSearch:
        {
            [self.queryView addSubview:self.priceSearchView];
            self.currentsearchView = self.priceSearchView;
            
            break;
        }
        default:
            break;
    }
}


-(void)loadMoreRecord
{
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"type"] = @(self.rechareType);
    parmas[@"currentPage"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@getrechargehistory",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json) {
        [self.tableView.mj_footer endRefreshing];
        NSArray *arr = [VirtualcenterModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
        if (arr.count > 0)
        {
            [self.recoredArr addObjectsFromArray:arr];
            self.currentPage++;
            [self.tableView reloadData];
        }
        YYLog(@"%@",json);
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        YYLog(@"%@",error);
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recoredArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VirtualcenterModel *model = self.recoredArr[indexPath.row];
    BossRechargeScoreCell *cell = [BossRechargeScoreCell cellWithTableView:tableView];
    cell.rechargeType = _rechareType;
    cell.virtualcenterModel = model;
    return cell;
}


#pragma mark=========== 输入框的额代理事件==================

/**
 *  当输入框的文字发生改变的时候调用，弹出时间选择器--下面为了防止UItextfield弹出键盘
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.timetpye = textField.tag;
    UWDatePickerView *view  = [UWDatePickerView instanceDatePickerView];
    view.frame = CGRectMake(0, KScreenHeight - 300, KScreenWidth, 300);
    view.type = DateTypeOfStart;
    view.delegate = self;
    self.dateView = view;
    [self.view addSubview:view];
    return NO;
}


//时间选择器代理事件
- (void)getSelectDate:(NSString *)date type:(DateType)type button:(UIButton *)button{
    
    NSLog(@"时间 : %@",date);
    
    self.tableView.scrollEnabled = YES;
    
    if (button.tag != 1) {
        return;
    }
    
    //    self.agreementExpireLabel.text = date;
    switch (type) {
        case DateTypeOfStart:
            // TODO 日期确定选择
        {
            if (self.timetpye == 1) {//起始时间
                self.startText.text = date;
            }else if (self.timetpye == 2){//结束时间
                self.endText.text = date;
            }
            
            break;
        }
            
        case DateTypeOfEnd:
            // TODO 日期取消选择
            break;
        default:
            break;
    }
}


-(void)dealloc
{
    [self.coverView removeFromSuperview];
}





@end
