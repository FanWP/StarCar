//
//  OkOrderVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BossOkdetailOrderVC.h"
#import "OrderModel.h"

@interface BossOkdetailOrderVC ()


/** 用户名 */
@property (nonatomic,weak) UILabel *username;


/** 确认按钮 */
@property (nonatomic,weak) UIButton *okBtn;




@end

@implementation BossOkdetailOrderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"确认订单";
    self.view.backgroundColor = BGcolor;
    
    [self setupControls];
}


-(void)setupControls
{
    
//    UIView *contentView = [UIView alloc];
    
    //设置数据
    NSArray *Arr= @[@"用户名:",@"手机号:",@"商品名称:",@"交易时间:",@"交易单号:",@"交易金额:"];
    
    //设置左边的Lable
    CGFloat margin = 30;
    CGFloat startY = 80;
    for (NSInteger i = 0; i < Arr.count; i++)
    {
        //设置左边的标签数据
        UILabel *lable = [[UILabel alloc] init];
        lable.width = 75;
        lable.height = 45;
        lable.x = margin;
        lable.y = startY + i * lable.height;
        lable.textAlignment = NSTextAlignmentLeft;
        lable.font = Font14;
        lable.text = Arr[i];
//                lable.backgroundColor = [UIColor redColor];
        [self.view addSubview:lable];
        
        //设置右边的数据
        UILabel *rightlable = [[UILabel alloc] init];
        rightlable.width = KScreenWidth - CGRectGetMaxX(lable.frame) - margin;
        rightlable.height = 45;
        rightlable.x = CGRectGetMaxX(lable.frame) + 5;
        rightlable.y = startY + i * lable.height;
        rightlable.textAlignment = NSTextAlignmentRight;
        rightlable.font = Font14;
//        rightlable.text = @"796234796";
//        rightlable.backgroundColor = [UIColor redColor];
        
        //设置数据
        switch (i) {
            case 0:
                rightlable.text = self.orderModel.membername;
                break;
            case 1:
                rightlable.text = self.orderModel.username;
                break;
            case 2:
                rightlable.text = self.orderModel.productname;
                break;
            case 3:
                rightlable.text = self.orderModel.date;
                break;
            case 4:
                rightlable.text = self.orderModel.saleid;
                break;
            case 5:
                rightlable.text = self.orderModel.price;
                break;
                
            default:
                break;
        }
        
        
        [self.view addSubview:rightlable];
    }
    
    
    //设置顶部的确认取消按钮
    CGFloat height = 50;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - height, KScreenWidth, height)];
    [self.view addSubview:bottomView];
    CGFloat Width = (KScreenWidth - 1) /2;
    UIButton *cancelbutton = [[UIButton alloc] init];
    cancelbutton.x = 0;
    cancelbutton.y = 0;
    cancelbutton.width = Width;
    cancelbutton.height = height;
    [cancelbutton setTitle:@"取消确认" forState:UIControlStateNormal];
    [cancelbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelbutton.backgroundColor = [UIColor whiteColor];
    cancelbutton.layer.cornerRadius = BtncornerRadius;
    cancelbutton.layer.masksToBounds = YES;
    [cancelbutton addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelbutton];
    
    //确认订单
    UIButton *okbutton = [[UIButton alloc] init];
    okbutton.x = Width + 1;
    okbutton.y = 0;
    okbutton.width = Width;
    okbutton.height = height;
    [okbutton setTitle:@"确认订单" forState:UIControlStateNormal];
    okbutton.backgroundColor = XLXcolor(25, 125, 290);
    okbutton.layer.cornerRadius = BtncornerRadius;
    okbutton.layer.masksToBounds = YES;
    self.okBtn = okbutton;
    [okbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okbutton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [okbutton addTarget:self action:@selector(okbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:okbutton];
}


//取消确认点击事件的处理
-(void)cancelBtnClick
{
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"id"] = self.orderModel.ID;
    
    NSString *url = [NSString stringWithFormat:@"%@cannelorderservlet",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json) {
        [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
        [self.navigationController popViewControllerAnimated:YES];
        YYLog(@"json---%@",json);
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        YYLog(@"error---%@",error);
    }];
}


//取消确认点击事件的处理
-(void)okbuttonClick
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"id"] = self.orderModel.ID;

    
    
    NSString *url = [NSString stringWithFormat:@"%@confirmorderservlet",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json) {
        
        [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
        self.okBtn.enabled = NO;
        
        [self.navigationController popViewControllerAnimated:YES];
        YYLog(@"json---%@",json);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        YYLog(@"error---%@",error);
    }];

}




@end
