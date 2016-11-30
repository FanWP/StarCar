//
//  MineVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MineVC.h"
#import "LoginVC.h"
#import "ForgetPwdVC.h"
#import "LoginView.h"
#import "UserInfoManagementTVC.h"
#import "ILSettingGroup.h"
#import "FeedbackVC.h"
#import "CarInfoChangeVC.h"
#import "AddCarInfo.h"

#import "ILSettingArrowItem.h"
#import "CarInfoListVC.h"
#import "ResetPasword.h"
#import "AddProductVC.h"
#import "AboutSettingTVC.h"
#import "RechargeVC.h"

#import "UserCommonView.h"
#import "MyCollectionTableVC.h"
#import "BossAccountInfoListTVC.h"
#import "AddCarInfo.h"
#import "BossInsuranceManagement.h"
#import "UserInsurecemangement.h"
#import "MembersTVC.h"
#import "WaitHandleOrderTVC.h"
#import "CFOStatisticsTVC.h"

#import "CarDetailInfoTableVC.h"
#import "UserOrderQueryTVC.h"

#import "StorageManagementTableVC.h"
#import "ProductPublishTableVC.h"
#import "AddNewActivityTableVC.h"
#import "AddWheelPicVC.h"
#import "RechargeRecordTVC.h"
#import "ScoreExchangeTVC.h"
#import "AdminFeedbackTVC.h"

@interface MineVC ()<LoginViewDelegate>

/** 公钥 */
@property (nonatomic,copy) NSString *publicKey;

/** 单元格的左边的数组显示 */
@property (nonatomic,strong) NSArray *leftTitleArr;

/** 顶部的信息 */
@property (nonatomic,strong) UserCommonView *userCommonView;



@end

@implementation MineVC

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)creatHeaderView
{
    if (!self.userCommonView)
    {
        UserCommonView *userCommonView = [[UserCommonView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 154)];
        self.userCommonView = userCommonView;
    }
    self.tableView.tableHeaderView = self.userCommonView;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //1.判断是否登录
    if ([UserInfo sharedUserInfo].isLogin)//已经登录
    {
        //2.根据用户的类型选择对应的单元格列表
        UserInfo *userInfo = [UserInfo sharedUserInfo];
        self.dataList = nil;
        [self creatHeaderView];
        
        //3.填充顶部的用户数据
        [self setupHearderInfo];
        
        //4.设置列表
        if (userInfo.userType == 1 || userInfo.userType == 0)//管理员
        {
            [self addGroupAdmin];
        }else if (userInfo.userType == 2)//普通用户
        {
            [self addGroupCustomer];
        }
        [self.tableView reloadData];
    }else//未登录
    {
          [self getPubicKey];
    }
}



#pragma mark - 添加客户和管理员的数组的单元格数组
/**
 *  普通客户
 */
-(void)addGroupCustomer
{
    // 0组
    ILSettingArrowItem *collection = [ILSettingArrowItem itemWithIcon:@"collect" title:@"收藏" destVcClass:[MyCollectionTableVC class]];
    
    ILSettingArrowItem *orderquery = [ILSettingArrowItem itemWithIcon:@"indent" title:@"订单查询" destVcClass:[UserOrderQueryTVC class]];
    
    ILSettingArrowItem *pointsFor = [ILSettingArrowItem itemWithIcon:@"integral" title:@"积分兑换" destVcClass:[ScoreExchangeTVC class]];
    
//    
//    ILSettingArrowItem *account = [ILSettingArrowItem itemWithIcon:nil title:@"账户管理" destVcClass:[CarDetailInfoTableVC class]];
    
//    ILSettingArrowItem *Insurance = [ILSettingArrowItem itemWithIcon:nil title:@"保单" destVcClass:[UserInsurecemangement class]];

    
    ILSettingArrowItem *carInfoRegist = [ILSettingArrowItem itemWithIcon:@"register" title:@"车辆信息登记" destVcClass:[AddCarInfo class]];
    ILSettingArrowItem *prepaidRecords = [ILSettingArrowItem itemWithIcon:@"record" title:@"充值记录查询" destVcClass:[RechargeRecordTVC class]];
    
    ILSettingArrowItem *setting = [ILSettingArrowItem itemWithIcon:@"set" title:@"设置" destVcClass:[AboutSettingTVC class]];
    

    ILSettingGroup *group0 = [[ILSettingGroup alloc] init];
    group0.items = @[collection,orderquery,pointsFor,prepaidRecords,carInfoRegist,setting];
    
    [self.dataList addObject:group0];
}



/**
 *  管理员
 */
-(void)addGroupAdmin
{
    //管理员
    ILSettingArrowItem *order= [ILSettingArrowItem itemWithIcon:@"pay" title:@"充值" destVcClass:[RechargeVC class]];
    
    ILSettingArrowItem *topup= [ILSettingArrowItem itemWithIcon:@"order" title:@"待处理订单" destVcClass:[WaitHandleOrderTVC class]];
    
    ILSettingArrowItem *CFOOrders = [ILSettingArrowItem itemWithIcon:@"finance" title:@"财务统计" destVcClass:[CFOStatisticsTVC class]];
    
    ILSettingArrowItem *Warehouse = [ILSettingArrowItem itemWithIcon:@"repertory" title:@"仓库管理" destVcClass:[StorageManagementTableVC class]];
    
    ILSettingArrowItem *SalesStatistics = [ILSettingArrowItem itemWithIcon:@"in repertory" title:@"入库登记" destVcClass:[ProductPublishTableVC class]];
    
    ILSettingArrowItem *GoodsReleased = [ILSettingArrowItem itemWithIcon:@"member" title:@"会员信息管理" destVcClass:[BossAccountInfoListTVC class]];
    
//    ILSettingArrowItem *informationRelease = [ILSettingArrowItem itemWithIcon:@"order" title:@"车辆管理" destVcClass:[UserInfoManagementTVC class]];
    
//    ILSettingArrowItem *orderquery = [ILSettingArrowItem itemWithIcon:@"order" title:@"保单管理" destVcClass:[BossInsuranceManagement class]];
    
    ILSettingArrowItem *carInfochange = [ILSettingArrowItem itemWithIcon:@"map" title:@"轮播图" destVcClass:[AddWheelPicVC class]];
    
    ILSettingArrowItem *InfoRegister = [ILSettingArrowItem itemWithIcon:@"activity" title:@"最新活动" destVcClass:[AddNewActivityTableVC class]];
    
    ILSettingArrowItem *TopupQuery= [ILSettingArrowItem itemWithIcon:@"message" title:@"优惠信息" destVcClass:[MembersTVC class]];
    
    ILSettingItem *opinion = [ILSettingArrowItem itemWithIcon:@"news" title:@"用户意见" destVcClass:[AdminFeedbackTVC class]];
    
    ILSettingArrowItem *setting = [ILSettingArrowItem itemWithIcon:@"set" title:@"设置" destVcClass:[AboutSettingTVC class]];

    ILSettingGroup *group0 = [[ILSettingGroup alloc] init];
    group0.items = @[order,topup,CFOOrders,Warehouse,SalesStatistics,GoodsReleased,carInfochange,InfoRegister,TopupQuery,opinion,setting];
    
    [self.dataList addObject:group0];
}



#pragma mark - 获取公钥并登录
/**
 *  获取公钥并提示登录
 */
-(void) getPubicKey
{
    
    LoginView *logView = [[LoginView alloc] initWithFrame:self.view.bounds];
    logView.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:logView];
    
    NSString *url = [NSString stringWithFormat:@"%@unlogin/sendpubkeyservlet",URL];
    [[AFHTTPSessionManager manager]POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"公钥----%@",responseObject);
         UserInfo *userIn = [UserInfo sharedUserInfo];
         
         self.publicKey =responseObject[@"pubKey"];
         //若一开始从未从服务器获取到公钥，则从本地获取公钥
         if (_publicKey == nil )
         {
             self.publicKey = userIn.publicKey;
             YYLog(@"本地公钥%@",self.publicKey);
         }else
         {
             userIn.publicKey = self.publicKey;
             [userIn synchronizeToSandBox];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"公钥获取失败---%@",error);
     }];
}

-(void)setupHearderInfo
{

  UserInfo *userInfo = [UserInfo sharedUserInfo];
    //用户名
    self.userCommonView.userNameLabel.text = userInfo.username;
    //头像
    NSString *strHeader = [NSString stringWithFormat:@"%@%@",picURL,userInfo.headerpic];
    
    [self.userCommonView.headerPic sd_setImageWithURL:[NSURL URLWithString:strHeader] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    //级别或者是老板  或者是店长
    NSString *username = nil;
    switch (userInfo.userType) {
        case 0://老板
            username = @"老板";
            break;
        case 1://店长
            username = @"店长";
            break;
        case 2://普通用户
        {
            username = [NSString VIPis:userInfo.viplevel];
            break;
        }
        default:
            break;
    }
    self.userCommonView.gradeLabel.text = username;
}



#pragma mark - 登录成功后调用代理，设置tableView上下滑动可用
-(void)loginSuccess
{
    self.tableView.scrollEnabled = YES;
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    
    //设置数据
    [self setupHearderInfo];

    //清空原有数组
    self.dataList = nil;
    if (userInfo.userType == 1)//管理员
    {
        [self addGroupAdmin];
    }else if (userInfo.userType == 2)//普通用户
    {
        [self addGroupCustomer];
    }
    [self.tableView reloadData];
}



-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}


@end
