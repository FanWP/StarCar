//
//  UserInfoManagementTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "UserInfoManagementTVC.h"
#import "RSA.h"

@interface UserInfoManagementTVC ()


/** 接收服务器返回的数据 */
@property (nonatomic,strong) NSMutableArray *userArr;

@end

@implementation UserInfoManagementTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户信息管理";
    
    [self loadData];
}


-(void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    UserInfo * userInfo = [UserInfo sharedUserInfo];
    params[@"sessionId"] = userInfo.RSAsessionId;
    
    NSString *url = [NSString stringWithFormat:@"%@getallcustomerservlet",URL];

    [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"管理员查询用户列表返回-responseObject---%@",responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"管理员查询用户列表返回-error---%@",error);
        
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text  = [NSString stringWithFormat:@"测试------%ld",(long)indexPath.row];
    
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self getUsers];
    }
    if (indexPath.row == 1)
    {
        [self deleteUsers];
    }

}



/**
 *  管理员创建新用户
 */
-(void)getUsers
{
    UserInfo * userInfo = [UserInfo sharedUserInfo];
    NSString *password  = @"123456Aa";
    NSString *RsaPassword = [RSA encryptString:password publicKey:userInfo.publicKey];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"sessionId"] = userInfo.RSAsessionId;
    params[@"username "] = @"18092456614";
    params[@"value"] = RsaPassword;
    
    NSString *url = [NSString stringWithFormat:@"%@creatuserservlet",URL];
    
    
    /*
     Int resultCode  1000表示成功
     Int resultCode  1007用户没有登录
     Int resultCode  1014用户名在数据库中已经存在
     Int resultCode  1016用户没有权限
     Int resultCode  1018添加操作没有成功
     */
    [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"管理员创建用户返回---%@",responseObject);
         NSNumber *num = responseObject[@"resultCode"];
         NSInteger result = [num integerValue];
         
         switch (result)
         {
             case 1000:
                 YYLog(@"操作成功");
                 break;
             case 1007:
                 YYLog(@"没有登录");
                 [HttpTool loginUpdataSession];
                 break;
             case 1014:
                 YYLog(@"数据库中已经存在");
                 break;
             case 1016:
                 YYLog(@"用户没有权限");
                 break;
             case 1018:
                 YYLog(@"操作没有成功");
                 break;
                 
             default:
                 break;
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"管理员创建用户失败---%@",error);
     }];
}



/**
 *  管理员删除用户
 */
-(void)deleteUsers
{
    UserInfo * userInfo = [UserInfo sharedUserInfo];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"sessionId"] = userInfo.RSAsessionId;
    params[@"id"] = @"4321";
    
    NSString *url = [NSString stringWithFormat:@"%@deleteusersevlet",URL];
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
}



@end
