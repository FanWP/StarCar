//
//  RechargeVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/10.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "RechargeVC.h"
#import "VirtualcenterModel.h"
#import "RechargeHistoryCell.h"

@interface RechargeVC ()<UITableViewDelegate,UITableViewDataSource>

/** 保存服务器返回的充值记录数据 */
@property (nonatomic,strong) NSArray *RecordArr;

/** 手机号的输入框 */
@property (nonatomic,weak) UITextField *phoneText;

/** 用户输入的充值金额 */
@property (nonatomic,weak) UITextField *moneyTF;


/** 充值记录 */
@property (nonatomic,weak) UIButton *recordsBtn;



/** 充值时查询到的用户名 */
@property (nonatomic,weak) UILabel *username;


/** 输入充值现金时候直接转换成星币 */
@property (nonatomic,weak) UILabel *addStar;


/** 账户余额 */
@property (nonatomic,weak) UILabel *balanceLable;

/** 充值模型 */
@property (nonatomic,strong) VirtualcenterModel *virtualcenterModel;

/** 设置遮盖 */
@property (nonatomic,weak) UIView *coverView;

/** 充值记录列表 */
@property (nonatomic,weak) UITableView *RecordView;

@end

@implementation RechargeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XLXcolor(240, 240, 242);
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    
    [self setupRechargeRecordView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.RecordView removeFromSuperview];
}


-(void)setupView
{
    CGFloat left = KScreenWidth * 0.14;
    CGFloat top = KScreenHeight * 0.14;
    CGFloat margin = 10;
    CGFloat labelH = 30;
    
    //手机号
    UILabel *phone = [[UILabel alloc] init];
    phone.text  = @"手机号";
    phone.x = left;
    phone.y = top;
    phone.width = 54;
    phone.height = labelH;
    phone.font = Font16;
//    phone.backgroundColor = [UIColor redColor];
    [self.view addSubview:phone];
    
    
//    UIButton *checkBtn = [[UIButton alloc] init];
//    checkBtn.width = 60;
//    checkBtn.height = labelH;
//    checkBtn.centerY = phone.centerY;
//    checkBtn.backgroundColor = [UIColor blueColor];
//    checkBtn.layer.masksToBounds = YES ;
//    checkBtn.layer.cornerRadius = BtncornerRadius;
//    checkBtn.titleLabel.font = Font14;
//    checkBtn.x = KScreenWidth - checkBtn.width - margin;
//    [checkBtn setTitle:@"检查" forState:UIControlStateNormal];
//    [checkBtn addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:checkBtn];
    
    //手机号输入框
    UITextField *phoneText = [[UITextField alloc] init];
    phoneText.x = CGRectGetMaxX(phone.frame) + margin;
    phoneText.width = KScreenWidth - phoneText.x - 5 * margin;
    phoneText.height = labelH;
    phoneText.font = Font14;
    phoneText.centerY = phone.centerY;
    phoneText.borderStyle = TFborderStyle;
    phoneText.placeholder = @"请输入手机号";
    self.phoneText = phoneText;
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    [phoneText addTarget:self action:@selector(phoneTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:phoneText];
    
    //用户名
    UILabel *user = [[UILabel alloc] init];
    user.x = left;
    user.y = CGRectGetMaxY(phone.frame) + 20;
    user.width = 55;
    user.height  = labelH;
    user.font = Font16;
    user.text = @"用户名";
    [self.view addSubview:user];
    
    
    //查询到的用户名
    //用户名
    UILabel *username = [[UILabel alloc] init];
    username.x = CGRectGetMaxX(user.frame) + 20;
    username.width = 156;
    username.height  = labelH;
    username.centerY = user.centerY;
//    username.text = @"用户名";
    self.username = username;
//    username.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:username];
    
    
    //账户余额和历史记录
    
//    UIButton *balanceBtn = [[UIButton alloc] init];
//    balanceBtn.width = 100;
//    balanceBtn.height = labelH;
//    balanceBtn.y = CGRectGetMaxY(user.frame) + 30;
//    balanceBtn.backgroundColor = [UIColor blueColor];
//    balanceBtn.layer.masksToBounds = YES ;
//    balanceBtn.layer.cornerRadius = BtncornerRadius;
//    balanceBtn.titleLabel.font = Font14;
//    balanceBtn.x = left + 15;
//    [balanceBtn setTitle:@"账户余额" forState:UIControlStateNormal];
//    [balanceBtn addTarget:self action:@selector(balanceBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:balanceBtn];
    UILabel *balanceLB = [[UILabel alloc] init];
    balanceLB.width = 70;
    balanceLB.height = labelH;
    balanceLB.y = CGRectGetMaxY(user.frame) + 30;
    //    balanceLB.backgroundColor = [UIColor redColor];
    balanceLB.layer.masksToBounds = YES ;
    balanceLB.layer.cornerRadius = BtncornerRadius;
    balanceLB.font = Font16;
    balanceLB.x = left - 10;
    balanceLB.text = @"账户余额";
    [self.view addSubview:balanceLB];
    
    
    //显示账户余额
    UILabel *balanceLable = [[UILabel alloc] init];
    balanceLable.width = 100;
    balanceLable.height = labelH;
    balanceLable.y = CGRectGetMaxY(user.frame) + 30;
//    balanceLable.backgroundColor = [UIColor blueColor];
    balanceLable.layer.masksToBounds = YES ;
    balanceLable.layer.cornerRadius = BtncornerRadius;
    balanceLable.font = Font16;
    balanceLable.x = CGRectGetMaxX(balanceLB.frame) +5;
//    balanceLable.text = @"账户余额";
    self.balanceLable = balanceLable;
    [self.view addSubview:balanceLable];
    
    
    
    
    UIButton *recordsBtn = [[UIButton alloc] init];
    recordsBtn.width = balanceLB.width + 20;
    recordsBtn.height = balanceLB.height;
    recordsBtn.y = balanceLB.y;
    recordsBtn.backgroundColor = [UIColor blueColor];
    recordsBtn.titleLabel.font = Font14;
    recordsBtn.layer.masksToBounds = YES ;
    recordsBtn.layer.cornerRadius = BtncornerRadius;
    recordsBtn.x = KScreenWidth - CGRectGetMaxX(balanceLB.frame) - 3 * margin;
    [recordsBtn setTitle:@"历史记录" forState:UIControlStateNormal];
    self.recordsBtn = recordsBtn;
    recordsBtn.enabled = NO;
    [recordsBtn addTarget:self action:@selector(recordsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordsBtn];
    
    
    
    //设置分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight * 0.4, KScreenWidth, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    
    UILabel *rechargeLB = [[UILabel alloc] init];
    rechargeLB.text  = @"充值金额";
    rechargeLB.x = left;
    rechargeLB.y = CGRectGetMaxY(balanceLB.frame) + 70;
    rechargeLB.width = 75;
    rechargeLB.height = labelH;
    rechargeLB.font = Font16;
    
    [self.view addSubview:rechargeLB];
    
    
    //账户余额和充值金额
    UILabel *creditLB = [[UILabel alloc] init];
    creditLB.text  = @"现金";
    creditLB.x = left + 10;
    creditLB.y = CGRectGetMaxY(rechargeLB.frame) + 20;
    creditLB.width = 50;
    creditLB.height = labelH;
    creditLB.font = Font16;
    //    phone.backgroundColor = [UIColor redColor];
    [self.view addSubview:creditLB];
    
    
    //冲值金额的输入框
    UITextField *moneyTF = [[UITextField alloc] init];
    moneyTF.x = CGRectGetMaxX(phone.frame) + margin - 5;
    moneyTF.width = KScreenWidth * 0.5 - CGRectGetMaxX(creditLB.frame) + 20;
    moneyTF.height = labelH;
    moneyTF.centerY = creditLB.centerY;
    moneyTF.borderStyle = TFborderStyle;
    moneyTF.placeholder = @"请输入金额";
    moneyTF.font = Font14;
    [moneyTF addTarget:self action:@selector(moneyTFChanged:) forControlEvents:UIControlEventEditingChanged];
    moneyTF.keyboardType = UIKeyboardTypeNumberPad;
//    moneyTF.backgroundColor = [UIColor redColor];
    self.moneyTF = moneyTF;
    [self.view addSubview:moneyTF];
    
    
    //星币
    UILabel *star = [[UILabel alloc] init];
    star.text  = @"星币";
    star.x = KScreenWidth * 0.5 + 3 * margin;
    star.y = creditLB.y;
    star.width = 35;
    star.height = labelH;
    star.font = Font16;
//    star.backgroundColor = [UIColor redColor];
    [self.view addSubview:star];
    
    
    UILabel *addStar = [[UILabel alloc] init];
//    addStar.text  = @"1000";
    addStar.x = CGRectGetMaxX(star.frame);
    addStar.y = creditLB.y;
    addStar.width = 100;
    addStar.height = labelH;
    addStar.font = Font16;
    self.addStar = addStar;
    //    phone.backgroundColor = [UIColor redColor];
    [self.view addSubview:addStar];
    
    
    
    //底部的确认充值按钮
    UIButton *OKBtn = [[UIButton alloc] init];
    OKBtn.width = KScreenWidth;
    OKBtn.height = 50;
    OKBtn.y = KScreenHeight - OKBtn.height;
    OKBtn.x = 0;
    OKBtn.backgroundColor = [UIColor blueColor];
    OKBtn.titleLabel.font = Font18;
//    OKBtn.layer.masksToBounds = YES;
//    OKBtn.layer.cornerRadius = BtncornerRadius;
    [OKBtn setTitle:@"确认充值" forState:UIControlStateNormal];
    [OKBtn addTarget:self action:@selector(OKBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OKBtn];

}




/* 历史记录按钮的点击事件 */
-(void)recordsBtnClick
{
    //获取充值数据
    
    [self.view endEditing:YES];
    
    if (!self.virtualcenterModel)
    {
        [[AlertView sharedAlertView] addAlertMessage:@"请输入手机号！" title:@"提示"];
        return;
    }
    
    [self getRechargeRecord];
    
    [UIView animateWithDuration:0.25 delay:0 options:(UIViewAnimationOptionBeginFromCurrentState) animations:^{
        self.coverView.hidden = NO;
        self.title = @"充值记录";
        self.RecordView.x = KScreenWidth * 0.3;
    } completion:^(BOOL finished) {
    }];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}




#pragma mark============Http请求============
/* 确认充值按钮的点击事件 */
-(void)OKBtnClick
{
    
    if (!self.virtualcenterModel)//没有查询
    {
        [self.phoneText becomeFirstResponder];
        [[AlertView sharedAlertView] addAlertMessage:@"请输入手机号" title:@"提示"];
        return;
    }
    
    if (self.moneyTF.text == nil || self.moneyTF.text.length == 0)//充值金额
    {
        [self.moneyTF becomeFirstResponder];
        [[AlertView sharedAlertView] addAlertMessage:@"请输入充值金额！" title:@"提示"];
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@"确认充值%@狼币?",self.moneyTF.text];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        YYLog(@"取消");
    }] ];
    [alert addAction:[UIAlertAction actionWithTitle:@"充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //充值
        [self recharge];
    }] ];
    
    [self presentViewController:alert animated:YES completion:^{
        
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
    parmas[@"username"] = self.phoneText.text;
    parmas[@"amount"] = self.moneyTF.text;
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@rchrgsrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         
         [SVProgressHUD showSuccessWithStatus:@"充值成功！"];
         self.moneyTF.text = nil;
         self.addStar.text = nil;
         [self.view setNeedsLayout];
         YYLog(@"json-充值%@",json);
         
     } failure:^(NSError *error)
     {
         YYLog(@"json-充值%@",error);
     }];
}


/**
 * 地址管理：获取用户充值记录ID
 */
-(void)getRechargeRecord
{
    /*
     username 用户名
     amount 金额
     sessionId 会话id
     */
    
    if (!self.virtualcenterModel)
    {
        [[AlertView sharedAlertView] addAlertMessage:@"请输入充值手机号！" title:@"提示"];
        return;
    }
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userid"] = self.virtualcenterModel.userid;
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@gtsrrchrgrcordsrvlt",URL];
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-获取充值记录%@",json);
        self.RecordArr = [VirtualcenterModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         
         YYLog(@"Arr---%@",self.RecordArr);
         [self.RecordView reloadData];
         
         
     } failure:^(NSError *error)
     {
         YYLog(@"json-获取充值记录%@",error);
     }];
}


/**
 *  地址管理：获取用户账户余额
 */
-(void)getAccountBalance
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"username"] = self.phoneText.text;
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@gtsrcrrncybynmsrvlt",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"json-获取账户余额%@",json);
//         self.virtualcenterModel = [VirtualcenterModel mj_objectWithKeyValues:json[@"obj"]];
         NSArray *arr = [VirtualcenterModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         if (arr && arr.count > 0)
         {
             self.virtualcenterModel = arr[0];
         }
         YYLog(@"self.virtualcenterModel.balance--%f",self.virtualcenterModel.balance);
         self.balanceLable.text = [NSString stringWithFormat:@"%.0f星币",self.virtualcenterModel.balance];
         self.username.text = self.virtualcenterModel.membername;

     } failure:^(NSError *error)
     {
         YYLog(@"json-获取账户余额%@",error);
     }];
}



-(void)setupRechargeRecordView
{
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    self.coverView = coverView;
    UIGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTap)];
    self.coverView.hidden = YES;
    [coverView addGestureRecognizer:touch];
    [self.view addSubview:coverView];
    
    
    UITableView *RecordView = [[UITableView alloc] initWithFrame:CGRectMake(KScreenWidth, 64, KScreenWidth, KScreenHeight - 64)];

    RecordView.delegate = self;
    RecordView.dataSource = self;
    self.RecordView = RecordView;
    [[UIApplication sharedApplication].keyWindow addSubview:RecordView];
//    [coverView addSubview:RecordView];
}

-(void)coverViewTap
{
    [UIView animateWithDuration:0.25 delay:0 options:(UIViewAnimationOptionBeginFromCurrentState) animations:^{
        self.RecordView.x = KScreenWidth;
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
        self.title = @"充值";
    }];
}




#pragma mark========UITextField点击事件=============
/* 手机号的输入框的监听事件 **/
-(void)phoneTextChanged:(UITextField *)phoneTF
{
    
    if (phoneTF.text.length == 11)//手机号长度
    {
        if (![phoneTF.text isMobileNumber])//不是手机号
        {
            phoneTF.text = nil;
            self.recordsBtn.enabled = NO;
            [[AlertView sharedAlertView] addAlertMessage:@"手机号输入有误，请核对" title:@"提示"];
        }else
        {
            //查询余额
            [self getAccountBalance];
            self.recordsBtn.enabled = YES;
        }
    }else  //不是手机号的时候直接清空手机号和用户名
    {
        self.balanceLable.text = nil;
        self.username.text = nil;
    }
}


-(void)moneyTFChanged:(UITextField *)moneyTF
{
    YYLog(@"moneyTF.text---%@",moneyTF.text);
    if(moneyTF.text.length == 0)//没有输入或者是删除
    {
        self.addStar.text = nil;
        
    }else if (![moneyTF.text isPureInt]) {//不是数字
        self.addStar.text = nil;
        moneyTF.text = nil;
        [[AlertView sharedAlertView] addAlertMessage:@"充值金额为数字，请核对！" title:@"提示"];
    }else
    {
        self.addStar.text = moneyTF.text;
    }
}

#pragma mark=======UITableViewDataSource=======
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.RecordArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeHistoryCell *cell = [RechargeHistoryCell cellWithTableView:tableView];
    VirtualcenterModel *model = self.RecordArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)dealloc
{
    [self.RecordView removeFromSuperview];
}




@end
