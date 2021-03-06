//
//  AccountInfoListTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BossAccountInfoListTVC.h"
#import "AccountInfoCell.h"
#import "UserModel.h"
#import "BossAccountInfoMTVC.h"



@interface BossAccountInfoListTVC ()<UMSocialUIDelegate>

/** 保存服务器返回的数据 */
@property (nonatomic,strong) NSMutableArray *allPeopleArray;


/** 顶部的lable数组 */
@property (nonatomic,strong) NSArray *titleArr;

/** 当前页面 */
@property (nonatomic,assign) NSInteger currentPage;


@end

@implementation BossAccountInfoListTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addHeaderView];
    
    [self setupRefresh];
    
    [self rightItemExportExcel];
}

- (void)rightItemExportExcel
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"导出" style:(UIBarButtonItemStylePlain) target:self action:@selector(exportExcelAction)];
}


- (void)exportExcelAction
{
    NSString *url = [NSString stringWithFormat:@"%@exportfileuserinfoservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"导出excel返回%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {            
            NSString *obj = responseObject[@"body"];
            
            YYLog(@"导出excel链接：：http://192.168.1.18:8080/%@",obj);
            
            NSString *url = [NSString stringWithFormat:@"http://192.168.1.18:8080/%@",obj];
            
            NSString *shareText = [NSString stringWithFormat:@"客户信息表：%@",url];
            
            [UMSocialData defaultData].extConfig.title = @"天狼星";
            
            [UMSocialSnsService presentSnsIconSheetView:self appKey:@"584f99c25312ddbd6a0011b4" shareText:shareText shareImage:[UIImage imageNamed:@"shareIcon"] shareToSnsNames:@[UMShareToQQ] delegate:self];
            
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQQ] content:shareText image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
                
                if (response.responseCode == UMSResponseCodeSuccess)   {
                    
                    [UMSocialData defaultData].extConfig.qqData.url = url;
                    
                    YYLog(@"分享出去的链接%@",url);
                }
            }];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"导出excel失败%@",error);
        
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadNewUserInfoData];
}



#pragma mark====== 增加上下拉功能======
-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUserInfoData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUserInfoData)];
}





-(void)addHeaderView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
    headView.backgroundColor = BGcolor;
    
    NSArray *arr = @[@"手机号",@"等级",@"注册时间"];
    
    NSMutableArray *titleArr = [NSMutableArray array];
    
    
    CGFloat width = KScreenWidth / arr.count;
    
    for (NSInteger i = 0; i < arr.count ; i++)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.x = width * i;
        lable.y = 0;
        lable.width = width;
        lable.height = 44;
        lable.text = arr[i];
        lable.font = Font17;
        lable.textAlignment = NSTextAlignmentCenter;
        
        //做位置的微调
        switch (i)
        {
            case 0://手机号
            {
                lable.width += 20;
                lable.x += 10;
                break;
            }
            case 1://等级
            {
//                lable.width -= 20;
//                lable.x += 15;
                break;
            }
            case 2://注册时间
            {
                lable.x += 10;
                lable.textAlignment = NSTextAlignmentLeft;
                break;
            }
                
            default:
                break;
        }
        [titleArr addObject:lable];
        [headView addSubview:lable];
    }
    
    self.titleArr = titleArr;
    
    self.tableView.tableHeaderView = headView;
}




/** 增加下拉刷新 */
-(void)loadNewUserInfoData
{
    [self.tableView.mj_footer endRefreshing];
    NSString *url = [NSString stringWithFormat:@"%@viewallusersservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    self.currentPage  = 1;
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"currentPage"] = @(self.currentPage);
    
    [HttpTool post:url parmas:parameters success:^(id json)
     {
         [self.tableView.mj_header endRefreshing];
         NSLog(@"json----%@",json);
         self.currentPage++;
         self.allPeopleArray = [UserModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
         
         [self.tableView reloadData];
         
     } failure:^(NSError *error) {
         YYLog(@"所有用户请求失败：%@",error);
         [self.tableView.mj_header endRefreshing];
     }];
    
}


/** 增加上拉加载更多 */
-(void)loadMoreUserInfoData
{
    [self.tableView.mj_header endRefreshing];
    NSString *url = [NSString stringWithFormat:@"%@viewallusersservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"currentPage"] = @(self.currentPage);
    
    YYLog(@"parameterss 上拉-%@",parameters);
    [HttpTool post:url parmas:parameters success:^(id json)
     {
         
         [self.tableView.mj_footer endRefreshing];
         NSLog(@"json----%@",json);
         NSArray *arr = [UserModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
         if (arr.count > 0)
         {
             self.currentPage++;
             [self.allPeopleArray addObjectsFromArray:arr];
         }
         //刷新数据
         [self.tableView reloadData];
     } failure:^(NSError *error) {
         YYLog(@"所有用户请求失败：%@",error);
         [self.tableView.mj_footer endRefreshing];
     }];
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allPeopleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AccountInfoCell *cell = [AccountInfoCell cellWithTableView:tableView];
    UserModel *model = self.allPeopleArray[indexPath.row];
    cell.userModel = model;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}


#pragma mark==== 添加左滑删除功能======
//添加编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (USERType == 1 || USERType == 2)//店长
    {
        return NO;
    }else
    {
    return YES;
    }
}


//删除所做的动作
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";

}


//删除所做的动作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (USERType == 1)//店长
    {
        [SVProgressHUD showErrorWithStatus:@"您没有该权限"];
        return;
    }
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否确认删除此会员？" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            
            /** 管理员删除用户 */
            UserInfo * userInfo = [UserInfo sharedUserInfo];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            UserModel *model = self.allPeopleArray[indexPath.row];
            params[@"sessionId"] = userInfo.RSAsessionId;
            params[@"id"] = model.ID;
            NSString *url = [NSString stringWithFormat:@"%@deleteusersevlet",URL];
            
            YYLog(@"params---%@",params);
            
            [self.allPeopleArray removeObjectAtIndex:indexPath.row];
            // Delete the row from the data source.
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            
            /*
             Int resultCode  1000表示成功
             Int resultCode  1007用户没有登录
             Int resultCode  1016用户没有权限
             Int resultCode  1019删除操作没有成功
             */
            [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 
                 NSLog(@"管理员删除用户返回---%@",responseObject);
                 NSNumber *num = responseObject[@"resultCode"];
                 NSInteger result = [num integerValue];
                 switch (result)
                 {
                     case 1000:
                         YYLog(@"删除成功");
                         break;
                     case 1007:
                         YYLog(@"没登录");
                         [HttpTool loginUpdataSession];
                         break;
                     case 1016:
                         YYLog(@"用户没有权限");
                         break;
                     case 1009:
                         YYLog(@"删除操作没有成功");
                         break;
                         
                     default:
                         break;
                 }
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 NSLog(@"管理员创建用户失败---%@",error);
             }];

            
 
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];

        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


//点击跳转并赋值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserModel *model = self.allPeopleArray[indexPath.row];
    BossAccountInfoMTVC *vc = [[BossAccountInfoMTVC alloc] init];
    vc.userModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}








@end
