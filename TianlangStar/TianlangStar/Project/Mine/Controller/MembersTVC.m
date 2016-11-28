//
//  MembersTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "MembersTVC.h"
#import "CarInputCell.h"
#import "VIPLevelModel.h"

@interface MembersTVC ()<UITextFieldDelegate>

/** 输入框数组 */
@property (nonatomic,strong) NSMutableArray *rankArr;


/** 判断文本框是否可编辑 */
@property (nonatomic,assign) BOOL textEnable;


/** 接收并保存VIP等级 */
@property (nonatomic,strong) VIPLevelModel *VIPLevel;
/** 发送VIP等级 */
@property (nonatomic,strong) VIPLevelModel *VIP;


/** 折扣数组 */
@property (nonatomic,strong) NSMutableArray *discountArr;



@end

@implementation MembersTVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = BGcolor;

    [self loadVIPInfo];
    
    self.VIP = [[VIPLevelModel alloc] init];
    
    [self addRightBar];
    
    [self addheaderView];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)loadVIPInfo
{
    NSString *url = [NSString stringWithFormat:@"%@find/vip/level/info",uRL];
    
    YYLog(@"url--%@",url);
    [SVProgressHUD showWithStatus:@"数据加载中,请稍后!"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [HttpTool get:url parmas:nil success:^(id json) {
        [SVProgressHUD dismiss];
        YYLog(@"json--%@",json);
        self.VIPLevel = [VIPLevelModel mj_objectWithKeyValues:json[@"body"]];
        
    } failure:^(NSError *error) {
        YYLog(@"error---%@",error);
        [SVProgressHUD dismiss];
    }];
}


-(void)setVIPLevel:(VIPLevelModel *)VIPLevel
{
    _VIPLevel = VIPLevel;
    //通过模型赋值
    NSArray *Arr = [NSArray arrayWithObjects:VIPLevel.vip1,VIPLevel.vip2,VIPLevel.vip3,VIPLevel.vip4,VIPLevel.vip5, nil];
    
    for (NSInteger i = 0; i < self.discountArr.count; i++) {
        UITextField *textField = self.discountArr[i];
        textField.text = Arr[i];
    }
    
    self.VIP = VIPLevel;
}



- (void)addRightBar
{
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
//    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"完成" forState:UIControlStateSelected];
    [button addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)rightClick:(UIButton *)button
{
    button.selected = !button.selected;
    self.textEnable = button.selected;
    
//    YYLog(@"textEnable--%d",self.textEnable);
    
    for (UITextField *input in self.discountArr)
    {
        input.enabled  = self.textEnable;
    }

    if (self.textEnable)//显示完成，在编辑状态
    {
        UITextField *input = self.discountArr[0];
        [input becomeFirstResponder];
    }else
    {
        [self.view endEditing:YES];
        
        [self updataVIPInfo];
    }
}



-(void)updataVIPInfo
{
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"discount1"] = self.VIP.vip1;
    parmas[@"discount2"] = self.VIP.vip2;
    parmas[@"discount3"] = self.VIP.vip3;
    parmas[@"discount4"] = self.VIP.vip4;
    parmas[@"discount5"] = self.VIP.vip5;

    YYLog(@"parmas---%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@update/vip/level/info",uRL];
    [HttpTool get:url parmas:parmas success:^(id json) {
        YYLog(@"更新优惠信息json%@",json);
    } failure:^(NSError *error) {
        YYLog(@"更新优惠信息error%@",error);
    }];

}




//添加顶部
- (void)addheaderView
{
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 44)
                      ];
//    header.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:header];
    
    UILabel * rank = [[UILabel alloc] init];
    rank.height = 30;
    rank.width = KScreenWidth * 0.4;
    rank.y = 14;
    rank.x = 78;
    rank.text = @"会员等级";
    rank.font = Font17;
    rank.textAlignment = NSTextAlignmentLeft;
    [header addSubview:rank];
    
    
    UILabel * discount = [[UILabel alloc] init];
    discount.height = 30;
    discount.width = KScreenWidth * 0.4;
    discount.y = rank.y;
    discount.x = KScreenWidth - 92 - discount.width;
    discount.text = @"折扣      ";
    discount.font = rank.font;
    discount.textAlignment = NSTextAlignmentRight;
    [header addSubview:discount];
    

    
    
    //会员等级列表
    self.rankArr = [NSMutableArray array];
    NSArray *rankArr =@[@"Lv.1",@"Lv.2",@"Lv.3",@"Lv.4",@"Lv.5"];
    double rankOY = CGRectGetMaxY(header.frame) + 33;
    
    for (NSInteger i = 0; i < rankArr.count; i++)
    {
        UILabel *rank  = [[UILabel alloc] init];
        rank.text = rankArr[i];
        rank.x = 0;
        rank.width = KScreenWidth * 0.5;
        rank.height = 17;
        rank.y = rankOY + i * 49.5;
        rank.font = Font17;
        rank.textAlignment = NSTextAlignmentCenter;
        [self.rankArr addObject:rank];
        YYLog(@"%lu",(unsigned long)self.rankArr.count);
        [self.view addSubview:rank];
    }
    
    //折扣输入框列表
    NSArray *discountA = @[@"100",@"100",@"100",@"100",@"100"];
    CGFloat inputW = 45;
    
    self.discountArr = [NSMutableArray array];
    for (NSInteger i = 1; i <= discountA.count; i++)
    {
        UITextField *input = [[UITextField alloc] init];
        input.enabled = self.textEnable;
//        input.backgroundColor = [UIColor orangeColor];
//        input.x = inputX;
        input.y = rankOY  + (i - 1) * 45;
        input.width = inputW;
        input.height = 35;
        input.x = KScreenWidth - 92 - input.width;
        input.tag = i;
        input.font = Font17;
        input.keyboardType = UIKeyboardTypeNumberPad;
        input.delegate = self;
        input.textAlignment = NSTextAlignmentCenter;
        [self.discountArr addObject:input];
        input.placeholder = @"请输入信息";
        input.backgroundColor = [UIColor whiteColor];
        YYLog(@"self.discountArr.count-%lu",(unsigned long)self.discountArr.count);
        input.text = discountA[i-1];
        [self.view addSubview:input];
        
        //设置右边的百分号
        CGFloat  lableX = CGRectGetMaxX(input.frame) + 3;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(lableX, input.y, 30, 30)];
        lable.text = @"%";
        [self.view addSubview:lable];
    }
}

//退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark======文本框输入的文字处理事件=====

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    YYLog(@"textField.text%@--%ld",textField.text,(long)textField.tag);
    
    
    switch (textField.tag) {
        case 1:
            self.VIP.vip1 = textField.text;
            break;
        case 2:
            self.VIP.vip2 = textField.text;
            break;
        case 3:
            self.VIP.vip3 = textField.text;
            break;
        case 4:
            self.VIP.vip4 = textField.text;
            break;
        case 5:
            self.VIP.vip5 = textField.text;
            break;
            
        default:
            break;
    }
    
    YYLog(@"self.VIP=--%@",self.VIP);
    
}

@end
