//
//  HttpTool.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/7.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "HttpTool.h"
#import <AFNetworking.h>


@interface HttpTool ()



@end

@implementation HttpTool


+ (void)post:(NSString *)url parmas:(NSDictionary *)parmas success:(void (^)(id json))success failure:(void(^) (NSError *error))failure
{
    //1，创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSNumber *num = responseObject[@"resultCode"];
         NSInteger result = [num integerValue];
         YYLog(@"success-http%@",responseObject);
         
         if (result == 1000) {
             if (success) {
                 success(responseObject);
             }
         }else
         {
             [self checkReultCode:result];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (error)
         {
             failure(error);
             YYLog(@"error-http%@",error);
         }
     }];
}




+(void)get:(NSString *)url parmas:(NSDictionary *)parmas success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1，创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:url parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (success && result == 1000)
        {
            success(responseObject);
        }
        
        [self checkReultCode:result];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error)
        {
            failure(error);
        }
    }];



}



+(void)checkReultCode:(NSInteger )result
{
    [SVProgressHUD dismiss];
    YYLog(@"num------%ld",(long)result);
    switch (result) {
            
        case 1001:
        {
            YYLog(@"reultCode=1001,数据库没有这条数据");
            break;
        }
        case 1002:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"服务繁" title:@"提示"];
            [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"reultCode=1002,系统错误");
            break;
        }
        case 1003:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"服务繁" title:@"提示"];
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"reultCode=1003,密码错误");
            break;
        }
        case -1004:
        {
            [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"reultCode=1004,sql语句执行错误");
            break;
        }
        case 1005:
        {
            [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"reultCode=1005,未知错误");
            break;
        }
        case 1006:
        {
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"reultCode=1006,参数中有空");
            break;
        }
        case 1007:
        {
            //自定登录
            [self loginUpdataSession];
            break;
        }
        case 1008:
        {
            [[AlertView sharedAlertView] addAlertMessage:@"验证码错误" title:@"提示"];
            YYLog(@"reultCode=1008,验证码错误");
            break;
        }
        case 1009:
        {
            [self loginUpdataSession];
            YYLog(@"reultCode=1009,登录IP不符");
            break;
        }
        case 1011:
        {
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            [self loginUpdataSession];
            YYLog(@"reultCode=1011,用户登录macid和本次请求macid不符");
            break;
        }
        case 1012:
        {
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"reultCode=1012,误差值过大");
            break;
        }
//        case 1013:
//        {
//            //                [[AlertView sharedAlertView] addAlertMessage:@"服务繁忙，请稍后再试" title:@"提示"];
//            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
//            YYLog(@"reultCode=1013,登录手机号改变");
//            break;
//        }
        case 1014:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"服务繁忙，请稍后再试" title:@"提示"];
            [SVProgressHUD showErrorWithStatus:@"数据库中已存在该数据"];
            YYLog(@"reultCode=1014,数据库中已存在数据");
            break;
        }
        case 1015:
        {
            [[AlertView sharedAlertView] addAlertMessage:@"验证码不匹配" title:@"提示"];
            //                [SVProgressHUD showErrorWithStatus:@"数据库中已存在该数据"];
            YYLog(@"reultCode=1015,验证码不匹配");
            break;
        }
        case 1016:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"验证码不匹配" title:@"提示"];
            //                                [SVProgressHUD showErrorWithStatus:@"数据库中已存在该数据"];
            YYLog(@"reultCode=1016,用户没有权限");
            break;
        }
        case 1017:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"验证码不匹配" title:@"提示"];
            //                                [SVProgressHUD showErrorWithStatus:@"数据库中已存在该数据"];
            YYLog(@"reultCode=1017,图片符合格式");
            break;
        }
        case 1018:
        {
            [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"reultCode=1018,操作没有成功");
            break;
        }
        case 1019:
        {
            //                [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"reultCode=1019,删除没有成功");
            break;
        }
        case 1020:
        {
            //                [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"reultCode=1020,修改操作没有成功");
            break;
        }
        case 1021:
        {
            //                [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"reultCode=1021,用户名在数据库中不存存在");
            break;
        }
        case 1022:
        {
            //                [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"reultCode=1022,请核对金额");
            break;
        }
        case 1023:
        {
            //                [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"reultCode=1022,用户名不存在");
            break;
        }
        default:
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            break;
    }
}




/** 自动登录 */
+ (void)loginUpdataSession
{
    
    YYLog(@"自动登录");
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    
    NSString *password = [RSA encryptString:userInfo.passWord publicKey:userInfo.publicKey];
    //手机序列号的获取
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = userInfo.username;
    params[@"value"] = password;
    params[@"terminal"] = @"421A6988-DA96-49FE-B99E-16820320F1BB";
    
    //        params[@"code"] = @"88080";
    
    //    params[@"terminal"] = uuid
    
    YYLog(@"自动登录---%@",params);
    
    //    YYLog(@"序列号%@",uuid);
    /*
     Int resultCode  1006 表示参数中有null
     Int resultCode  1007表示没有登录
     Int resultCode  1010表示用户密码与用户确认密码不同
     Int resultCode  1011 表示年龄不符合条件
     Int resultCode  1013  表示用户名在数据库中已经存在
     Int resultCode  1015  表示用户验证码不匹配
     Int resultCode  1003 密码错误
     1001数据库没有记录
     1014账户名重复
     */
    //设置这遮盖
    
    [SVProgressHUD showWithStatus:@"正在自动登录中~"];
    
    NSString *url = [NSString stringWithFormat:@"%@unlogin/userlogin",URL];
    
    [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {         //进度
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //1.移除遮盖
         [SVProgressHUD dismiss];
         YYLog(@"更新登录返回--%@",responseObject);
         
         NSNumber *resultCode = responseObject[@"resultCode"];
         int result = [resultCode intValue];
         //2.判断并处理服务器的返回值
         //3记录sessionID,和用户模型数据
         if (result == 1000)//如果登陆成功才能取出sessionID，否则为空报错
         {
             [UserInfo sharedUserInfo].isLogin = YES;
             //获取sessionId,并更新至本地
             NSNumber * mun = responseObject[@"obj"][@"sessionId"];
             userInfo.sessionId = [NSString stringWithFormat:@"%@",mun];
             userInfo.RSAsessionId = [RSA encryptString:userInfo.sessionId publicKey:userInfo.publicKey];
             [userInfo synchronizeToSandBox];
         }else
         {
             //用户名或者密码发生改变，提示用户重新登录
             [[AlertView sharedAlertView] loginAlertView];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [SVProgressHUD dismiss];
         [SVProgressHUD showErrorWithStatus:@"登录失败，请稍后再试！"];
         YYLog(@"登录失败----%@",error);
     }];
}



// 获取验证码
+ (void)getNumbers:(NSString *)iphoneNum
{
    //设置界面的按钮显示 根据自己需求设置
    
    if (![iphoneNum isMobileNumber])
    {//不是手机号
        [SVProgressHUD showErrorWithStatus:@"获取验证码的手机号输入有误，请核对"];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = iphoneNum;
    YYLog(@"接收验证码的手机--%@",iphoneNum);
    
    NSString *url = [NSString stringWithFormat:@"%@unlogin/sendcheckcodeservlet",URL];
    [[AFHTTPSessionManager manager] POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
         //进度
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"验证码获取成功----%@",responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"验证码获取失败----%@",error);
     }];
}





@end
