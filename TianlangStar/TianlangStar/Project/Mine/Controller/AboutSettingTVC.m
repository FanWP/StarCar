//
//  AboutSettingTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/9.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AboutSettingTVC.h"
#import "ILSettingItem.h"
#import "ILSettingArrowItem.h"
#import "ILSettingGroup.h"
#import "FeedbackVC.h"
#import "AdminFeedbackTVC.h"


@interface AboutSettingTVC ()


/** 退出登录 */
@property (nonatomic,weak) UIButton *exitLoginButton;

@end

@implementation AboutSettingTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addGroup];
    
    [self creatExitLoginView];
}



-(void)addGroup
{
    ILSettingItem *version = [ILSettingItem itemWithIcon:nil title:@"当前版本"];
    NSString *ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    version.subTitle = ver;
    
    ILSettingItem *cache = [ILSettingItem itemWithIcon:nil title:@"清理缓存"];
    cache.subTitle = [NSString stringWithFormat:@"%.2fM",[self getCache]];
    cache.option = ^{
        [self clearCache];
    };
    
    ILSettingItem *contact = [ILSettingItem itemWithIcon:nil title:@"联系我们"];
    contact.subTitle = @"029-87563668";
    contact.option = ^{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://029-87563668"]];
    };
    
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    
    ILSettingItem *opinion = nil;
    if (userInfo.userType == 1 || userInfo.userType == 0)
    {
        opinion = [ILSettingArrowItem itemWithIcon:nil title:@"用户意见" destVcClass:[AdminFeedbackTVC class]];
    }else
    {
        opinion = [ILSettingArrowItem itemWithIcon:nil title:@"用户意见" destVcClass:[FeedbackVC class]];
    }
    

    
    
    ILSettingGroup *group0 = [[ILSettingGroup alloc] init];
    group0.header = @"设置";
    group0.footer = @"设置foot";
    group0.items = @[version,cache,contact,opinion];
    
    [self.dataList addObject:group0];
}


#pragma mark - 创建底部的退出登录
- (void)creatExitLoginView
{
    UIView *exitLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
    
    exitLoginView.backgroundColor = [UIColor whiteColor];
    
    UIButton *exitLoginButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.exitLoginButton = exitLoginButton;
    exitLoginButton.frame = CGRectMake(0, 0, KScreenWidth, 44);
    [exitLoginButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [exitLoginButton addTarget:self action:@selector(exitLoginAction) forControlEvents:(UIControlEventTouchUpInside)];
    [exitLoginButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [exitLoginButton setTitleColor:[UIColor colorWithRed:0.702 green:0.007 blue:0.020 alpha:1.000] forState:(UIControlStateNormal)];
    
    if ([UserInfo sharedUserInfo].isQuit == NO)
    {
        [exitLoginView addSubview:exitLoginButton];
    }
    self.tableView.tableFooterView = exitLoginView;
}



//退出登录的点击事件处理
- (void)exitLoginAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您是否确定退出登录？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
                         {
                             //退出登录
                             [self quitLogin];
                         }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}





/**
 *  退出登录的操作
 */
-(void)quitLogin
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    NSString * url = [NSString stringWithFormat:@"%@logoutservlet",URL];

    YYLog(@"退出登录参数%@",parmas);
    
//    [[AFHTTPSessionManager manager] POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        YYLog(@"退出登录返回:%@",responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        YYLog(@"退出登录错误：%@",error);
//    }];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"退出登录--%@",json);
         NSInteger resultCode = [json[@"resultCode"] integerValue];
         if (resultCode == 1000)
         {
             [UserInfo sharedUserInfo].isLogin = NO;
             [[UserInfo sharedUserInfo] synchronizeToSandBox];
             //获取公钥并且弹出登录窗口
             
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
         {
             [[AlertView sharedAlertView] addAfterAlertMessage:@"退出登录失败" title:@"提示"];
         }

     } failure:^(NSError *error)
     {
         YYLog(@"退出登录--%@",error);
     }];
}



#pragma mark - 获取缓存大小以及缓存的处理
/**
 *  获取缓存大小
 */
-(CGFloat)getCache
{
    NSInteger totalCount = [[SDImageCache sharedImageCache] getDiskCount];
    NSInteger totalSize = [[SDImageCache sharedImageCache] getSize];
    
    float totalSizeM = totalSize/1024.0/1024.0;
//    YYLog(@"图片数量%ld",(long)totalCount);
//    YYLog(@"图片大小%ld",(long)totalSize);
//    YYLog(@"图片大小M%.2f",totalSizeM);
    return totalSizeM;
}


/**
 *  清除缓存
 */
-(void)clearCache
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存？" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"清除缓存" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        //清除缓存
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDisk];
        
        //缓存大小
        NSString *cache = [NSString stringWithFormat:@"%.2fM",[self getCache]];
        
        ILSettingGroup *group =  self.dataList[0];
        ILSettingItem *item = group.items[1];
        item.subTitle = cache;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:cancleAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
