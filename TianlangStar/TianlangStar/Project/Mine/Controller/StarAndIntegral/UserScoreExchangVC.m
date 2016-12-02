//
//  UserScoreExchangVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/2.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "UserScoreExchangVC.h"
#import "VirtualcenterModel.h"

@interface UserScoreExchangVC ()

/** 我的星币 */
@property (nonatomic,weak) UILabel *star;

/** 转增 */
@property (nonatomic,weak) UITextField *transferStarTF;

/** 手机号 */
@property (nonatomic,weak) UITextField *usernameTF;

/** 接收人 */
@property (nonatomic,weak) UILabel *receiveLB;

/** 转增按钮 */
@property (nonatomic,weak) UIButton *transferBtn;

/** 接收到的积分模型 */
@property (nonatomic,strong) VirtualcenterModel *virtualcenterModel;

@end

@implementation UserScoreExchangVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"积分";
    
    self.view.backgroundColor = BGcolor;
    
    //设置左侧子控件
    [self setupContorls];
    
    
}

-(void)setupContorls
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 71, KScreenWidth, 227)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    NSArray *arr = @[@"我的积分",@"积分兑换细则>>",@"转增",@"手机号",@"接收人"];
    
    for (NSInteger i = 0; i < arr.count; i++)
    {
        UILabel *label = [[UILabel alloc] init];
        label.x = 16;
        label.height = 44;
        label.width = 120;
        label.y = i * label.height + 7;
        //        label.backgroundColor = [UIColor whiteColor];
        label.font = Font17;
        label.text = arr[i];
        
        switch (i) {
            case 0://星币
            {
                label.y -= 7;
                //设置右侧数据
                UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - 20 - 200, 0, 200, 44)];
                self.star = right;
                right.textAlignment = NSTextAlignmentRight;
//                right.text = @"57329147591";
                right.font = Font17;
                [view addSubview:right];
                
                
                //灰色的线条
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame), KScreenWidth - 20, 1)];
                line.backgroundColor = BGcolor;
                [view addSubview:line];
                
                
                break;
            }
            case 1://积分兑换细则
            {
                label.y -= 7;

                //添加手势
                UIGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scoreExchangeDetail)];
                label.userInteractionEnabled = YES;
                [label addGestureRecognizer:touch];
                
                //灰色的线条
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), KScreenWidth, 7)];
                line.backgroundColor = BGcolor;
                [view addSubview:line];
                
                //设置右侧数据
                UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - 20 - 120, 0, 120, 44)];
                right.centerY = label.centerY;
                self.star = right;
                right.textAlignment = NSTextAlignmentRight;
                right.text = @"兑换记录查询>>";
                right.font = Font14;
                right.textColor = Tintcolor;
                
                //添加手势
                UIGestureRecognizer *rightTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scorerecordQuerry)];
                right.userInteractionEnabled = YES;
                [right addGestureRecognizer:rightTouch];
                
                [view addSubview:right];
                
                label.font = Font14;
                label.textColor = Tintcolor;
                break;
            }
                
            case 2://转增
            {
                //灰色的线条
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame), KScreenWidth - 20, 1)];
                line.backgroundColor = BGcolor;
                [view addSubview:line];
                
                //设置右边的数据
                UITextField *transferStarTF = [[UITextField alloc] initWithFrame:CGRectMake(KScreenWidth - 20 - 200, 44, 200, 35)];
                transferStarTF.centerY = label.centerY;
                transferStarTF.layer.cornerRadius = 5;
                transferStarTF.layer.masksToBounds = YES;
                transferStarTF.backgroundColor = BGcolor;
                [transferStarTF addTarget:self action:@selector(checkTransferBtnEnable) forControlEvents:UIControlEventEditingChanged];
                self.transferStarTF = transferStarTF;
                [view addSubview:transferStarTF];
                break;
            }
            case 3://手机号
            {
                //灰色的线条
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame), KScreenWidth - 20, 1)];
                line.backgroundColor = BGcolor;
                [view addSubview:line];
                
                //设置右边的数据
                UITextField *transferStarTF = [[UITextField alloc] initWithFrame:CGRectMake(KScreenWidth - 20 - 200, 44, 200, 35)];
                transferStarTF.centerY = label.centerY;
                transferStarTF.font = Font15;
                transferStarTF.layer.cornerRadius = 5;
                transferStarTF.layer.masksToBounds = YES;
                transferStarTF.backgroundColor = BGcolor;
                [transferStarTF addTarget:self action:@selector(usernameTFChanged:) forControlEvents:UIControlEventEditingChanged];
                transferStarTF.keyboardType = UIKeyboardTypeNumberPad;
                self.usernameTF = transferStarTF;
                [view addSubview:transferStarTF];
                break;
            }
            case 4://接收人
            {
                //设置右侧数据
                UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - 20 - 200, 0, 200, 44)];
                right.centerY = label.centerY;
                self.receiveLB = right;
                right.textAlignment = NSTextAlignmentRight;
                right.text = @"57329147591";
                right.font = Font17;
                [view addSubview:right];
                break;
            }
            default:
                break;
        }
        [view addSubview:label];
        
    }
    
    //添加底部的转增按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(view.frame) + 50, KScreenWidth - 40, 45)];
    btn.backgroundColor = Tintcolor;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    btn.titleLabel.font = Font18;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.enabled = NO;
    [btn setTitle:@"转增" forState:UIControlStateNormal];
    self.transferBtn = btn;
    [self.view addSubview:btn];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//积分兑换
-(void)scoreExchangeDetail
{
    YYLog(@"积分兑换");
}


-(void)scorerecordQuerry
{
    
    YYLog(@"积分记录查询");
}




//确认转转增按钮的点击事件
-(void)btnClick
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"userid"] = self.virtualcenterModel.userid;
    parmas[@"value"] = self.transferStarTF.text;
    //1---星币  2---积分
    parmas[@"type"] = @"1";
    
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@sendinstarcoinandintegral",URL];
    [HttpTool post:url parmas:parmas success:^(id json) {
        
        NSNumber *num = json[@"resultCode"];
        if ([num integerValue] == 1000)
        {
            [SVProgressHUD showSuccessWithStatus:@"积分兑换成功！"];
            self.transferStarTF = nil;
            self.receiveLB.text = nil;
            self.usernameTF.text = nil;
        }
        
        YYLog(@"json----%@",json);
        
    } failure:^(NSError *error) {
        YYLog(@"error---%@",error);
    }];
    
}


/**
 *  地址管理：获取用户账户余额---积分
 */
-(void)getAccountBalance
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"username"] = self.usernameTF.text;
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@gtsrcrrncybynmsrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-获取账户余额%@",json);
         //         self.virtualcenterModel = [VirtualcenterModel mj_objectWithKeyValues:json[@"obj"]];
         NSArray *arr = [VirtualcenterModel mj_objectArrayWithKeyValuesArray:json[@"body"]];
         if (arr && arr.count > 0)
         {
             self.virtualcenterModel = arr[0];
         }
         self.receiveLB.text = self.virtualcenterModel.membername;
         
         
         
     } failure:^(NSError *error)
     {
         YYLog(@"json-获取账户余额%@",error);
     }];
}




#pragma mark====UITextField================

-(void)usernameTFChanged:(UITextField *)phoneTF
{
    if (phoneTF.text.length == 11)//手机号长度
    {
        if (![phoneTF.text isMobileNumber])//不是手机号
        {
            phoneTF.text = nil;
            self.transferBtn.enabled = NO;
            [[AlertView sharedAlertView] addAlertMessage:@"手机号输入有误，请核对" title:@"提示"];
        }else
        {
            //查询余额
            [self getAccountBalance];
        }
    }else  //不是手机号的时候直接清空手机号和用户名
    {
        self.receiveLB.text = nil;
    }
    
    //判断转正按钮
    [self checkTransferBtnEnable];
}




//判断转增按钮是否可用
-(void)checkTransferBtnEnable
{
    if ([self.usernameTF.text isMobileNumber] && self.transferStarTF.text != nil && self.transferStarTF.text.length != 0)
    {
        self.transferBtn.enabled = YES;
    }else
    {
        self.transferBtn.enabled = NO;
    }
}


@end
