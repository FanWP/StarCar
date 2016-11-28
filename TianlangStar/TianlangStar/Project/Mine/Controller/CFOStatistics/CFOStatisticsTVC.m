//
//  CFOStatisticsTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CFOStatisticsTVC.h"
#import "BossCFOCell.h"
#import "CFOModel.h"
#import "CFOBarView.h"
#import "UWDatePickerView.h"
#import "CFOTotalModel.h"


typedef enum : NSUInteger
{
    timeSearch = 0,
    userSearch,
    accountSearch,
    priceSearch
} searchType;



//搜索框未出来时的tableView的高度
#define tableViewH KScreenHeight - 64 - 44 - 44

#define StableViewH KScreenHeight - 64 - 40 - 70 - 44 - 8 


@interface CFOStatisticsTVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UWDatePickerViewDelegate>

/** 底部的tableView */
@property (nonatomic,strong) UITableView *tableView;

/** 下面的主容器框 */
@property (nonatomic,weak) UIView *tabView;

/** 保存服务器返回的数据 */
@property (nonatomic,strong) NSMutableArray *CFOArr;

/** 保存服务器返回的数据 */
@property (nonatomic,strong) CFOTotalModel *cfoTotalModel;

/** 发送请求的类型 */
@property (nonatomic,assign) searchType searchType;


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

/** 按项目查询输入框 */
@property (nonatomic,weak) UITextField *productText;

/** 开始时间 */
@property (nonatomic,strong) UITextField *startText;

/** 结束时间 */
@property (nonatomic,strong) UITextField *endText;

/** 开始金额 */
@property (nonatomic,strong) UITextField *startPriceText;

/** 结束金额 */
@property (nonatomic,strong) UITextField *endPriceText;


/** 记录时间选择器 */
@property (nonatomic,assign) NSInteger timetpye;


/** 请求参数 */
@property (nonatomic,strong) NSMutableDictionary *parmas;

/** 时间选择器 */
@property (nonatomic,weak) UWDatePickerView *dateView;

/** 当前页码 */
@property (nonatomic,assign) NSInteger currentPage;


/** 记录当前时间 */
@property (nonatomic,copy) NSString *currentDate;


/** 总价格 */
@property (nonatomic,weak) UILabel *totalPrice;

/** 总积分 */
@property (nonatomic,weak) UILabel *totalScore;

/** 总个数 */
@property (nonatomic,weak) UILabel *itemCount;





@end

@implementation CFOStatisticsTVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = BGcolor;

    [self  addrightBar];
    
    [self addTableView];
    

    [self addFooter];

}

-(void)addFooter
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 44, KScreenWidth, 44)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:footView aboveSubview:self.tabView];
    self.footerView = footView;
    footView.hidden = YES;
    
    CGFloat width = KScreenWidth / 4;
    
    for (NSInteger i = 0; i < 4; i++)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.x = i * width -10;
        lable.y = 7;
        lable.height = 30;
        lable.width = width;
        lable.font = Font14;
        [footView addSubview:lable];
        
        switch (i)
        {
            case 0://合计
                lable.text = @"合计";
                lable.textAlignment = NSTextAlignmentCenter;
                break;
            case 1://交易数
                self.itemCount = lable;
                break;
            case 2://星币
               self.totalPrice = lable;
                break;
            case 3://积分
                self.totalScore = lable;
                break;
            default:
                break;
        }
    }
}



-(void)setCfoTotalModel:(CFOTotalModel *)cfoTotalModel
{
    _cfoTotalModel = cfoTotalModel;
    self.itemCount.text = [NSString stringWithFormat:@"%@笔交易",cfoTotalModel.itemCount];
    self.totalPrice.text = [NSString stringWithFormat:@"%@星币",cfoTotalModel.totalPrice];
    self.totalScore.text = [NSString stringWithFormat:@"%@积分",cfoTotalModel.totalScore];

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
        self.parmas[@"type"] = @"1";
        
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

          [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];

        self.parmas[@"startTime"] = dateString;
        self.parmas[@"endTime"] = dateString;

        
        YYLog(@"[self.startText.text getCurrentTime]--%@",[self.startText.text getCurrentTime]);
        
    }
    return _parmas;
}


-(void)searchClick:(UIButton *)button
{
    [self.view endEditing:YES];
    
    self.parmas = nil;
    self.parmas[@"pageNum"] = @"1";
    self.parmas[@"pageSize"] = @"10";
    self.parmas[@"type"] = @(self.searchType + 1);
    
    
    switch (self.searchType)
    {
        case timeSearch://时间
        {
            YYLog(@"%@",self.startText.text);
            YYLog(@"%@",self.endText.text);
 
            self.parmas[@"startTime"] = self.startText.text;
            self.parmas[@"endTime"] = self.endText.text;
            break;
        }
            
        case userSearch://账户
        {
            YYLog(@"账户--%@",self.accountText.text);
            if (![self.accountText.text isMobileNumber]) {//不是手机号
                [[AlertView sharedAlertView] addAlertMessage:@"请输入正确的手机号！" title:@"提示"];
                return;
            }
            self.parmas[@"account"] = self.accountText.text;
            break;
        }
            
        case accountSearch://项目
        {
            YYLog(@"项目--%@",self.productText.text);
            if (self.productText.text.length == 0 || self.productText.text == nil) {
             
                [[AlertView sharedAlertView] addAlertMessage:@"请输入查询条件" title:@"提示"];
                return;
            }
            
            self.parmas[@"product"] = self.productText.text;
            break;
        }
        case priceSearch://积分/金币
        {
            YYLog(@"%@",self.startPriceText.text);
            YYLog(@"%@",self.endPriceText.text);
            self.parmas[@"minMoney"] = self.startPriceText.text;
            self.parmas[@"maxMoney"] = self.endPriceText.text;
            self.parmas[@"type"] = @(button.tag);
            break;
        }
            
        default:
            break;
    }
    YYLog(@"self.parm as----%@",self.parmas);
    [self loadNewCFOInfo];
}



-(void)addTableView
{
    //主容器框
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64)];
//    [self.view insertSubview:ta belowSubview:<#(nonnull UIView *)#>];
    [self.view addSubview:tabView];
    
    self.tabView = tabView;
    
    CFOBarView *barView = [[CFOBarView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    [tabView addSubview:barView];
    
    
//    CGFloat tableViewH = KScreenHeight - 64 - 44 - 5;

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(barView.frame), KScreenWidth, tableViewH) style:UITableViewStylePlain];
    
    self.tableView = tableView;
    tableView.backgroundColor = BGcolor;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //添加上下拉刷新
    [self setupRefresh];

    [tabView addSubview:tableView];
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
    
    
//    [self.tableView reloadData];
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
    [exportBtn addTarget:self action:@selector(exportBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
-(void)exportBtnClick
{
    YYLog(@"导出");
    self.coverView.hidden = YES;
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
        self.tabView.y = 64;
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
    
    NSArray *arr = @[@"按时间",@"按账户",@"按项目",@"按金额"];
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
    
    self.tabView.y = CGRectGetMaxY(queryView.frame);
//    self.tableView.height = KScreenHeight - 64 - 40 - 70 - 44 - 5;
    
    self.tableView.height = StableViewH;
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
            YYLog(@"按时间查询");
            break;
        }
        case userSearch:
        {
            [self.queryView addSubview:self.accountView];
            self.currentsearchView = self.accountView;
            self.accountText.placeholder = @"请输入手机号";
            YYLog(@"按账户查询");
            break;
        }
        case accountSearch:
        {
            [self.queryView addSubview:self.productView];
            self.currentsearchView = self.productView;
            YYLog(@"按项目查询");
            self.productText.placeholder = @"请输入关键字";
            break;
        }
        case priceSearch:
        {
            [self.queryView addSubview:self.priceSearchView];
            self.currentsearchView = self.priceSearchView;
            YYLog(@"按金额查询");
            break;
        }
        default:
            break;
    }
}



#pragma mark===添加上下拉==================
-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewCFOInfo)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header isAutomaticallyChangeAlpha];
    
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCFOInfo)];
}



//下拉刷新--最新数据
-(void)loadNewCFOInfo
{
    [self.tableView.mj_footer endRefreshing];
    
    self.currentPage = 1;
    
    self.parmas[@"pageNum"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@find/finance/list",uRL];
    
    [HttpTool get:url parmas:self.parmas success:^(id json) {
        
        [self.tableView.mj_header endRefreshing];
        
        self.CFOArr = [CFOModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"finaceList"]];
        self.cfoTotalModel = [CFOTotalModel mj_objectWithKeyValues:json[@"body"]];
        
        //创建底部数据
        self.footerView.hidden = NO;
        
        
        if (self.CFOArr.count > 0)
        {
            self.currentPage++;
        }
        YYLog(@"json----%@",json);
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        YYLog(@"error----%@",error);
        [self.tableView.mj_header endRefreshing];
        
    }];
}

//上啦刷新加载更多x
-(void)loadMoreCFOInfo
{
    [self.tableView.mj_header endRefreshing];
    self.parmas[@"pageNum"] = @(self.currentPage);
    
    NSString *url = [NSString stringWithFormat:@"%@find/finance/list",uRL];
    
    [HttpTool get:url parmas:self.parmas success:^(id json) {
        [self.tableView.mj_footer endRefreshing];
        
        NSArray *arr = [CFOModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"finaceList"]];
        
        [self.CFOArr addObjectsFromArray:arr];
        
        if (arr.count > 0)
        {
            self.currentPage++;
        
            [self.tableView reloadData];
        }
        YYLog(@"json----%@",json);
        
    } failure:^(NSError *error) {
        YYLog(@"error----%@",error);
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.CFOArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BossCFOCell *cell = [BossCFOCell cellWithTableView:tableView];
    
    
    CFOModel *model = self.CFOArr[indexPath.row];
    cell.cfoModel = model;
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
    return YES;
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
