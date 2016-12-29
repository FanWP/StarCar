//
//  EditProductAndPublishTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/27.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "EditProductAndPublishTableVC.h"

#import "LabelTextFieldCell.h"
#import "LabelTFLabelCell.h"
#import "AddImagesCollectionVC.h"

#import "ProductModel.h"

#import "StorageManagementModel.h"


@interface EditProductAndPublishTableVC ()<UITextFieldDelegate>

/** 商品 model */
@property (nonatomic,strong) ProductModel *productModel;

/** 商品 枚举 */
@property (nonatomic,assign) ProductPublish productPublish;

// 入库图片的数组
@property (nonatomic,strong) NSMutableArray *imagesArray;

/** 时间选择器 */
@property (nonatomic,strong) UIDatePicker *shelvestimePicker;

@property (nonatomic,copy) NSString *shelvestime;

/** 商品数组 */
@property (nonatomic,strong) NSArray *leftLabelArray;

@property (nonatomic,strong) UIImage *image;

/** 标记输入框是否可用 */
@property (nonatomic,assign) BOOL inputEnble;

@property (nonatomic,strong) UIButton *rightButton;


@end

@implementation EditProductAndPublishTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改商品信息";
    
    self.inputEnble = NO;

    [self rightItem];// 入库按钮
    
    [self creatAddImagesView];// 添加图片的headerView
    
    [self addDatePIcker];
    
    _leftLabelArray = @[@"商品名称",@"商品类型",@"商品规格",@"适用车型",@"供应商",@"入库时间",@"入库数量",@"进价(元)",@"售价(星币)",@"售价(积分)",@"简介",@"备注"];
    
    YYLog(@"仓库管理传来的模型id:%@",_storageManagementModel.ID);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)creatAddImagesView
{
//    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth / 3 + 20)];
//    if (self.s0.mutableCells.count > 3)
//    {
//        _bottomView.height = 2 * (KScreenWidth / 3) + 20;
//    }
//    if (self.s0.mutableCells.count > 6)
//    {
//        _bottomView.height = 3 * (KScreenWidth / 3) + 20;
//    }
//    [self createData];
//    [self.bottomView addSubview:self.collectionView];
//    self.tableView.tableHeaderView = self.bottomView;
}




- (void)rightItem
{
    self.rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightButton.frame = CGRectMake(0, 0, 60, 30);
    
    [self.rightButton setTitle:@"编辑" forState:(UIControlStateNormal)];
    [self.rightButton setTitle:@"保存" forState:(UIControlStateSelected)];
    
    [self.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
}



- (void)rightButtonAction:(UIButton *)button
{
    [self.view endEditing:YES];
    
    self.inputEnble = !button.selected;
    
    button.selected = !button.selected;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.tableView reloadData];
        
    });
    
    if (self.inputEnble == NO)
    {
        [self productPutinStorage];
    }
    
}





- (void)editProductAction
{
    [self.view endEditing:NO];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStylePlain) target:self action:@selector(productPutinStorage)];
}




#pragma mark - 商品入库
- (void)productPutinStorage
{
    [self.view endEditing:YES];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"type"]  = @"1";
    parmas[@"productname"] = self.storageManagementModel.productname;
    parmas[@"productmodel"] = self.storageManagementModel.productmodel;
    parmas[@"specifications"] = self.storageManagementModel.specifications;
    parmas[@"applycar"] = self.storageManagementModel.applycar;
    parmas[@"vendors"] = self.storageManagementModel.vendors;
    parmas[@"shelvestime"] = self.productModel.shelvestime;
    parmas[@"inventory"] = self.storageManagementModel.inventory;
    parmas[@"purchaseprice"] = self.storageManagementModel.purchaseprice;
    parmas[@"price"] = self.storageManagementModel.price;
    parmas[@"scoreprice"] = self.storageManagementModel.scoreprice;
    parmas[@"introduction"] = self.storageManagementModel.introduction;
    parmas[@"remark"] = self.storageManagementModel.remark;
    parmas[@"id"] = self.storageManagementModel.ID;
    
    YYLog(@"修改商品入库参数parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@upload/updatecommondityservlet",URL];
    
    [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"修改商品入库返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             [[AlertView sharedAlertView] addAfterAlertMessage:@"修改商品入库成功" title:@"提示"];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"修改商品入库错误：%@",error);
     }];
}



/**
 *  添加时间选择器
 */
-(void)addDatePIcker
{
    //日期选择器
    //iphone6/6s
    UIDatePicker *startDatePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,KScreenHeight ,KScreenWidth, 162)];
    
    startDatePicker.datePickerMode = UIDatePickerModeDate;
    startDatePicker.date=[NSDate date];
    self.shelvestimePicker.hidden = NO;
    self.shelvestimePicker = startDatePicker;
    
    
    [self.shelvestimePicker addTarget:self action:@selector(selecStarttDate) forControlEvents:UIControlEventValueChanged];
}



/** 时间选择器的点击事件--较强险提醒日期 */
-(void)selecStarttDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    switch (self.productPublish)
    {
        case shelvestime://购买日期
        {
            self.shelvestime = [outputFormatter stringFromDate:self.shelvestimePicker.date];
            self.productModel.shelvestime = [NSString stringWithFormat:@"%ld", (long)[self.shelvestimePicker.date timeIntervalSince1970]];
            break;
        }
            
        default:
            break;
    }
    
    //回到主线程刷新数据
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
    });
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _leftLabelArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.leftLabelArray.count - 2 || indexPath.row == self.leftLabelArray.count - 1)
    {
        return 110;
    }

    return 40;
}



#pragma mark - 返回基本信息cell
- (LabelTextFieldCell *)tableView:(UITableView *)tableView baseInfoCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier0 = @"cell0";
    
    LabelTextFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        
        cell = [[LabelTextFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier0];
        
    }
    
    if (indexPath.row == self.leftLabelArray.count - 2 || indexPath.row == self.leftLabelArray.count - 1)
    {
        cell.rightTF.height = 100;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.leftLabel.text = _leftLabelArray[indexPath.row];
    
    cell.rightTF.enabled = self.inputEnble;
    
    cell.rightTF.delegate = self;
    self.productPublish = indexPath.row;
    cell.rightTF.tag = self.productPublish;

    switch (self.productPublish)
    {
        case productname:
            cell.rightTF.text = self.storageManagementModel.productname;
            break;
        case productmodel:
            cell.rightTF.text = self.storageManagementModel.productmodel;
            break;
        case specifications:
            cell.rightTF.text = self.storageManagementModel.specifications;
            break;
        case applycar:
            cell.rightTF.text = self.storageManagementModel.applycar;
            break;
        case vendors:
            cell.rightTF.text = self.storageManagementModel.vendors;
            break;
        case shelvestime:
        {
            if (self.shelvestime)
            {
                cell.rightTF.text = self.shelvestime;
            }
            else
            {
                cell.rightTF.text = self.storageManagementModel.shelvestime;
            }
        }
            break;
        case inventory:
            cell.rightTF.text = self.storageManagementModel.inventory;
            break;
        case purchaseprice:
            cell.rightTF.text = self.storageManagementModel.purchaseprice;
            break;
        case price:
            cell.rightTF.text = self.storageManagementModel.price;
            break;
        case scoreprice:
            cell.rightTF.text = self.storageManagementModel.scoreprice;
            break;
        case introduction:
            cell.rightTF.text = self.storageManagementModel.introduction;
            break;
        case remark:
            cell.rightTF.text = self.storageManagementModel.remark;
            break;
            
        default:
            break;
    }
    
    return cell;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView baseInfoCellWithIndexPath:indexPath];
}



//拖动是退出键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case productname:
            self.storageManagementModel.productname = textField.text;
            break;
        case productmodel:
            self.storageManagementModel.productmodel = textField.text;
            break;
        case specifications:
            self.storageManagementModel.specifications = textField.text;
            break;
        case applycar:
            self.storageManagementModel.applycar = textField.text;
            break;
        case vendors:
            self.storageManagementModel.vendors = textField.text;
            break;
        case inventory:
            self.storageManagementModel.inventory = textField.text;
            break;
        case purchaseprice:
            self.storageManagementModel.purchaseprice = textField.text; 
            break;
        case price:
            self.storageManagementModel.price = textField.text;
            break;
        case scoreprice:
            self.storageManagementModel.scoreprice = textField.text;
            break;
        case introduction:
            self.storageManagementModel.introduction = textField.text;
            break;
        case remark:
            self.storageManagementModel.remark = textField.text;
            break;
            
            
        default:
            break;
    }
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == shelvestime)
    {
        if (![textField.text isEqualToString:@"请选择日期"])
        {
            textField.inputView = self.shelvestimePicker;
            self.productPublish = textField.tag;
            textField.text = @"请选择日期";
        }
        else
        {
            textField.text = self.shelvestime;
        }
    }
    else
    {
        [self.shelvestimePicker removeFromSuperview];
    }
    
    return YES;
}




- (ProductModel *)productModel
{
    if (!_productModel)
    {
        _productModel = [[ProductModel alloc] init];
    }
    
    return _productModel;
}



- (NSMutableArray *)imagesArray
{
    if (!_imagesArray)
    {
        _imagesArray = [NSMutableArray array];
    }
    
    return _imagesArray;
}



@end
