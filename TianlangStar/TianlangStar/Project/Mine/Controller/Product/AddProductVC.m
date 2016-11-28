//
//  AddProductVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/7.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AddProductVC.h"
#import "HttpTool.h"
#import "ProductModel.h"
#import "AdressModel.h"
#import "VirtualcenterModel.h"


@interface AddProductVC ()


@end

@implementation AddProductVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加商品----过
//    [self addProduct];
    
    //添加服务
//    [self addServices];
    
    //获取所有商品及服务---过  记得更改type
//    [self getAllProduct];
    
    
    //更新商品信息
//    [self updataProduct];
    
    
    //修改用户信息
//    [self updataUserInfo];
    
    
    //添加地址
//    [self addAdres];
    
    
    //地址管理：删除
//    [self deletaAddress];
    
    //获取用户地址
//    [self getAllAddress];
    
    //更新用户地址
//    [self updataAddress];
    
    //更新默认的用户地址
//    [self updataDefaultAddress];
    
    

    //地址管理：获取用户账户余额
//    [self getAccountBalance];
    
    
    //地址管理：充值
    [self recharge];
    
    //地址管理：获取充值记录
//    [self getRechargeRecord];
    
}


#pragma mark====商品和服务--宇鹏========
/** 添加商品接口测试 */
-(void)addProduct
{
    
    /*地    址:	http://192.168.10.114:8080/carservice/releasecommodityservlet
     需要参数:	String sessionId用户登录标记
     商品：
     String type 商品分类  1商品  2 服务
     String productname 商品名称
     long price 商品价格
     Long scoreprice 积分价格
     String inventory 商品库存
     String images 商品图片
    
     Int resultCode  1000表示成功
     Int resultCode  1005未知错误
     Int resultCode  1007用户没有登录
     Int resultCode  1016用户没有权限
     Int resultCode  1018添加没有成功

     */
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"type"]  = @"1";
    parmas[@"productname"]  = @"机油432r";
    parmas[@"price"]  = @"190";
    parmas[@"scoreprice"]  = @"2000";
    parmas[@"inventory"]  = @"200";

    YYLog(@"商品发布parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@upload/releasecommodityservlet",URL];

    [[AFHTTPSessionManager manager]POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        UIImage *image1 = [UIImage imageNamed:@"homePage_normal"];
        UIImage *image2 = [UIImage imageNamed:@"homePage_normal"];
        UIImage *image3 = [UIImage imageNamed:@"homePage_normal"];
        
        NSArray *imagesArr = [NSArray arrayWithObjects:image1,image2,image3, nil];
        
        NSUInteger i = 0 ;
        
        YYLog(@"imagesArr.count---%lu",(unsigned long)imagesArr.count);
        
        /**出于性能考虑,将上传图片进行压缩*/
        for (UIImage * image in imagesArr)
        {
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            //拼接data
            [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"添加商品responseObject--%@",responseObject);
        NSNumber *num = responseObject[@"resultCode"];

        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
           YYLog(@"添加商品error--%@",error);
    }];
}


/** 添加服务 */
-(void)addServices
{
    /*
     地    址:	http://192.168.10.114:8080/carservice/releasecommodityservlet
     需要参数:	String sessionId用户登录标记
     商品：
     汽车服务：
     String type 商品分类
     String services 服务名称
     Long price 服务价格
     Long scoreprice 积分价格
     String images 图片
     */
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"type"]  = @"2";
    parmas[@"services"]  = @"服务";
    parmas[@"price"]  = @"1090";
    parmas[@"scoreprice"]  = @"99000";
    
    YYLog(@"商品发布parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@upload/releasecommodityservlet",URL];
    
    [[AFHTTPSessionManager manager]POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         UIImage *image1 = [UIImage imageNamed:@"homePage_normal"];
         UIImage *image2 = [UIImage imageNamed:@"homePage_normal"];
         UIImage *image3 = [UIImage imageNamed:@"homePage_normal"];
         
         NSArray *imagesArr = [NSArray arrayWithObjects:image1,image2,image3, nil];
         
         NSUInteger i = 0 ;
         
         YYLog(@"imagesArr.count---%lu",(unsigned long)imagesArr.count);
         
         /**出于性能考虑,将上传图片进行压缩*/
         for (UIImage * image in imagesArr)
         {
             NSData *data = UIImageJPEGRepresentation(image, 1.0);
             //拼接data
             [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
             i++;
         }
     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"添加服务responseObject--%@",responseObject);
         
         NSNumber *num = responseObject[@"resultCode"];
         NSInteger result = [num integerValue];
         if (result == 1007)
         {
             [HttpTool loginUpdataSession];
         }
         
         
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"添加服务error--%@",error);
     }];
}


/** 
  *获取所有商品列表
  */
-(void)getAllProduct
{
    /*
     http://192.168.10.114:8080/carservice/getcommodityinfoservlet
     String sessionId用户登录标记
     String currentPage 当前页
     String type 商品类型(1 商品 2 汽车服务)
     根据type类型获取所有商品信息
     获取的数据进行分页
     Int resultCode  1000表示成功
     Int resultCode  1001数据库没有这条数据
     Int resultCode  1005未知错误
     Int resultCode  1007用户没有登录
     Int resultCode  1016用户没有权限
     */
    
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"]  = @"1";
    parmas[@"type"]  = @"2";
    
    YYLog(@"获取所有商品列表parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@getcommodityinfoservlet",URL];
    
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"%@",json);
         
         NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         
         ProductModel *model = arr[0];
         
         YYLog(@"model---%ld",(long)model.scoreprice);
         
    } failure:^(NSError *error) {
        
        YYLog(@"%@",error);
        
    }];
}



/**
  *  x修改商品不含图片
  */
-(void)updataProduct
{
    /*
     String sessionId用户登录标记
     商品：
     String type 商品分类
     String id 商品数据库编码
     String productname 商品名称
     long price 商品价格
     Long scoreprice 积分价格
     String inventory 商品库存
     String images 商品图片
     汽车服务：
     String type 商品分类
     String id 汽车服务数据库编码
     String services 服务名称
     Long price 服务价格
     Long scoreprice 积分价格
     String images 图片
     */
    NSMutableDictionary  *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"type"] = @"83205";
    parmas[@"id"] = @"10";
    parmas[@"productname"] = @"83205";
    parmas[@"price"] = @"83205";
    parmas[@"scoreprice"] = @"83205";
    parmas[@"inventory"] = @"83205";
    parmas[@"images"] = @"";
    
    
    YYLog(@"%@",parmas);
    NSString * url = [NSString stringWithFormat:@"%@upload/updatecommondityservlet",URL];

    [[AFHTTPSessionManager manager]POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         UIImage *image1 = [UIImage imageNamed:@""];
         UIImage *image2 = [UIImage imageNamed:@""];
         UIImage *image3 = [UIImage imageNamed:@""];
         
         NSArray *imagesArr = [NSArray arrayWithObjects:image1,image2,image3, nil];
         
         NSUInteger i = 0 ;
         
         YYLog(@"imagesArr.count---%lu",(unsigned long)imagesArr.count);
         
         /**出于性能考虑,将上传图片进行压缩*/
         for (UIImage * image in imagesArr)
         {
             NSData *data = UIImageJPEGRepresentation(image, 1.0);
             //拼接data
             [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
             i++;
         }
     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"更新商品responseObject--%@",responseObject);
         NSNumber *num = responseObject[@"resultCode"];
         
         
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"更新商品error--%@",error);
     }];

    
    return;
    [HttpTool post:url parmas:parmas success:^(id json)
    {
        YYLog(@"json--%@",json);
        
    } failure:^(NSError *error) {
        YYLog(@"error---%@",error);
    }];
    
}

#pragma mark=====修改账户信息--宇鹏======

/**
 *  修改账户信息
 */
-(void)updataUserInfo
{
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    
    parmas[@"id"] = @"14";
    parmas[@"username"] = @"FWPPP";
    parmas[@"viplevel"] = @"9";
    YYLog(@"parmas---%@",parmas);
    
    NSString * url = [NSString stringWithFormat:@"%@updateaccountinfoservlet",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
    {
        YYLog(@"修改用户信息json--%@",json);
    } failure:^(NSError *error)
    {
        YYLog(@"修改用户信息error--%@",error);
    }];
}

#pragma mark=====地址管理----韩龙======
/**
 *  地址管理：添加
 */
-(void)addAdres
{
    /*
      url  ddddrsssrvlt
     Phone 收货人电话
     username 收货人
     address 配送地址
     userid 关联的用户
     type 是否为默认（0 不是，1是）第一条数据填1，其他填0；
     sessionId 会话id
     给tbl_address 中插入一条数据
     1000表示成功
*/
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"phone"] = @"18092456641";
    parmas[@"username"] = @"韩龙hanlong";
    parmas[@"address"] = @"陕西省西安市雁塔区";
    //     parmas[@"userid "] = @"18092456641";
    parmas[@"type"] = @"0";//默认为0
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    
    NSString *url = [NSString stringWithFormat:@"%@ddddrsssrvlt",URL];
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-添加地址%@",json);
         
    } failure:^(NSError *error)
    {
        YYLog(@"json-添加地址%@",error);
    }];
}



/**
 *  地址管理：删除
 */
-(void)deletaAddress
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"id"] = @"3";
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);

    NSString *url = [NSString stringWithFormat:@"%@dltddrsssrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-删除地址%@",json);
        
    } failure:^(NSError *error)
     {
        YYLog(@"json-删除地址%@",error);
    }];
}


/**
 *  地址管理：获取用户配货地址
 */
-(void)getAllAddress
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userid"] = @"14";
    parmas[@"type"] = @"1";
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@gtsrddrsssrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-获取地址%@",json);
         NSArray *arr = [AdressModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         YYLog(@"获取地址arr---%@",arr);
         
     } failure:^(NSError *error)
     {
         YYLog(@"json-获取地址%@",error);
     }];
}


/**
 *  地址管理：更新用户配货地址
 */
-(void)updataAddress
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"phone"] = @"18092456600";
    parmas[@"username"] = @"杀人狂魔---韩龙";
    parmas[@"address"] = @"陕西省西安市莲湖区1906";
    parmas[@"userid"] = @"14";
    parmas[@"id"] = @"5";
    parmas[@"type"] = @"1";
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@pdtddrsssrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-更新地址%@",json);
//         NSArray *arr = [AdressModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
//         YYLog(@"更新地址arr---%@",arr);
         
     } failure:^(NSError *error)
     {
         YYLog(@"json-更新地址%@",error);
     }];
}



/**
 *  更新用户默认配货地址
 */
-(void)updataDefaultAddress
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"oldid"] = @"2";
    parmas[@"newid"] = @"4";
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@pdtdfltddrsssrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-更改默认地址%@",json);
     } failure:^(NSError *error)
     {
         YYLog(@"json-更改默认地址%@",error);
     }];
}


#pragma mark=====充值----韩龙=====
/**
 *  地址管理：获取用户账户余额
 */
-(void)getAccountBalance
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userid"] = @"13";
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@gtsrcurrncysrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-获取账户余额%@",json);

         
     } failure:^(NSError *error)
     {
         YYLog(@"json-获取账户余额%@",error);
     }];
}



/**
 *  地址管理：充值
 */
-(void)recharge
{
    /*
     username 用户名
     amount 金额
     sessionId 会话id
     */
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"username"] = [UserInfo sharedUserInfo].username;
    parmas[@"amount"] = @"100";
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@rchrgsrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-充值%@",json);

     } failure:^(NSError *error)
     {
         YYLog(@"json-充值%@",error);
     }];
}



/**
 * 地址管理：获取用户充值记录
 */
-(void)getRechargeRecord
{
    /*
     username 用户名
     amount 金额
     sessionId 会话id
     */
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userid"] = [UserInfo sharedUserInfo].userID;
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@gtsrrchrgrcordsrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-获取充值记录%@",json);
         NSArray *Arr = [VirtualcenterModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         
         YYLog(@"Arr---%@",Arr);
         
         
     } failure:^(NSError *error)
     {
         YYLog(@"json-获取充值记录%@",error);
     }];
}









@end
