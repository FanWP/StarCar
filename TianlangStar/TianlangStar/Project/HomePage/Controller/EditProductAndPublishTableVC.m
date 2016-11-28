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
#import "ServiceModel.h"
#import "CarModel.h"

/** 二手车入库 */
typedef enum : NSUInteger {
    brand = 0,
    carPrice,
    model,
    cartype,
    mileage,
    buytime,
    number,
    person,
    frameid,
    engineid,
    property,
    carDescription
} SecondCarPublish;


@interface EditProductAndPublishTableVC ()

/** 商品、服务、二手车 model */
@property (nonatomic,strong) ProductModel *productModel;
@property (nonatomic,strong) ServiceModel *serviceModel;
@property (nonatomic,strong) CarModel *carModel;

/** 商品、服务、二手车 枚举 */
@property (nonatomic,assign) ProductPublish productPublish;
@property (nonatomic,assign) ServicePublish servicePublish;
@property (nonatomic,assign) SecondCarPublish secondCarPublish;

// 入库图片的数组
@property (nonatomic,strong) NSMutableArray *imagesArray;

/** 时间选择器 */
@property (nonatomic,strong) UIDatePicker *buytimePicker;

/** 接收购买时间的字符串 */
@property (nonatomic,copy) NSString *buytime;

/** 商品数组 */
@property (nonatomic,strong) NSArray *leftBaseLabelArray;

/** 服务数组 */
@property (nonatomic,strong) NSArray *leftSeviceLabelArray;

/** 二手车数组 */
@property (nonatomic,strong) NSArray *leftSecondcarLabelArray;

@property (nonatomic,strong) UISegmentedControl *segment;


@property (nonatomic,strong) UIImage *image;


@end

@implementation EditProductAndPublishTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改商品信息";

    [self rightItem];// 入库按钮
    
    [self creatTitleView];
    
    [self creatAddImagesView];// 添加图片的headerView
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)creatTitleView
{
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"商品",@"服务",@"二手车"]];
    self.segment.frame = CGRectMake(0, 10, 120, 30);
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:(UIControlEventValueChanged)];
    self.segment.apportionsSegmentWidthsByContent = YES;
    
    self.segment.selectedSegmentIndex = 1;
    self.navigationItem.titleView = self.segment;
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



- (void)segmentChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex)
    {
        case 0:
            YYLog(@"商品");
            break;
        case 1:
            YYLog(@"服务");
            break;
        case 2:
            YYLog(@"二手车");
            break;
            
        default:
            break;
    }
}



- (void)rightItem
{
    [self.view endEditing:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"入库" style:(UIBarButtonItemStylePlain) target:self action:@selector(productPutinStorage)];
    
    switch (self.segment.selectedSegmentIndex)
    {
        case 0:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"入库" style:(UIBarButtonItemStylePlain) target:self action:@selector(productPutinStorage)];
            break;
        case 1:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"入库" style:(UIBarButtonItemStylePlain) target:self action:@selector(servicePutinStorage)];
            break;
        case 2:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"入库" style:(UIBarButtonItemStylePlain) target:self action:@selector(secondCarPutinStorage)];
            break;
            
        default:
            break;
    }
    
}



#pragma mark - 商品入库
- (void)productPutinStorage
{
    [self.view endEditing:YES];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"type"]  = @"1";
    parmas[@"productname"] = self.productModel.productname;
    parmas[@"productmodel"] = self.productModel.productmodel;
    parmas[@"specifications"] = self.productModel.specifications;
    parmas[@"applycar"] = self.productModel.applycar;
    parmas[@"vendors"] = self.productModel.vendors;
    parmas[@"inventory"] = self.productModel.inventory;
    parmas[@"purchaseprice"] = self.productModel.purchaseprice;
    parmas[@"price"] = self.productModel.price;
    parmas[@"scoreprice"] = self.productModel.scoreprice;
    parmas[@"introduction"] = self.productModel.introduction;
    parmas[@"remark"] = self.productModel.remark;
    
    YYLog(@"商品入库参数parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@upload/releasecommodityservlet",URL];
    
    [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"商品入库返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             [[AlertView sharedAlertView] addAfterAlertMessage:@"商品入库成功" title:@"提示"];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"商品入库错误：%@",error);
     }];
}



#pragma mark - 服务入库
- (void)servicePutinStorage
{
    [self.view endEditing:YES];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"type"]  = @"2";
    parmas[@"services"] = self.serviceModel.services;
    parmas[@"servicetype"] = self.serviceModel.servicetype;
    parmas[@"content"] = self.serviceModel.content;
    parmas[@"warranty"] = self.serviceModel.warranty;
    parmas[@"manhours"] = self.serviceModel.manhours;
    parmas[@"price"] = self.serviceModel.price;
    parmas[@"scoreprice"] = self.serviceModel.scoreprice;
    
    YYLog(@"服务入库参数parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@upload/releasecommodityservlet",URL];
    
    [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         
     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"服务入库返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             [[AlertView sharedAlertView] addAfterAlertMessage:@"服务入库成功" title:@"提示"];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"服务入库错误：%@",error);
         
     }];
}



#pragma mark - 二手车入库
- (void)secondCarPutinStorage
{
    [self.view endEditing:YES];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"type"]  = @"3";
    parmas[@"brand"] = self.carModel.brand;
    parmas[@"price"] = self.carModel.price;
    parmas[@"model"] = self.carModel.model;
    parmas[@"cartype"] = self.carModel.cartype;
    parmas[@"mileage"] = self.carModel.mileage;
    parmas[@"buytime"] = self.carModel.buytime;
    parmas[@"number"] = self.carModel.number;
    parmas[@"person"] = self.carModel.person;
    parmas[@"frameid"] = self.carModel.frameid;
    parmas[@"engineid"] = self.carModel.engineid;
    parmas[@"property"] = self.carModel.property;
    parmas[@"description"] = self.carModel.carDescription;
    
    YYLog(@"二手车入库参数parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@upload/releasecommodityservlet",URL];
    
    [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"二手车入库返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             [[AlertView sharedAlertView] addAfterAlertMessage:@"二手车入库成功" title:@"提示"];
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"二手车入库错误：%@",error);
         
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
    self.buytimePicker.hidden = NO;
    self.buytimePicker = startDatePicker;
    
    
    [self.buytimePicker addTarget:self action:@selector(selecStarttDate) forControlEvents:UIControlEventValueChanged];
}



/** 时间选择器的点击事件--较强险提醒日期 */
-(void)selecStarttDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    switch (self.productPublish)
    {
        case buytime://购买日期
        {
            self.buytime=[outputFormatter stringFromDate:self.buytimePicker.date];
            self.carModel.buytime = [NSString stringWithFormat:@"%ld", (long)[self.buytimePicker.date timeIntervalSince1970]];
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
    switch (self.segment.selectedSegmentIndex) {
        case 0:
            return _leftBaseLabelArray.count;
            break;
        case 1:
            return _leftSeviceLabelArray.count;
            break;
        case 2:
            return _leftSecondcarLabelArray.count;
            break;
            
        default:
            break;
    }
    
    return _leftBaseLabelArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.segment.selectedSegmentIndex) {
        case 0:
        {
            
            if (indexPath.row == self.leftBaseLabelArray.count - 2 || indexPath.row == self.leftBaseLabelArray.count - 1)
            {
                return 110;
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == self.leftSecondcarLabelArray.count)
            {
                return 110;
            }
        }
            break;
            
        default:
            break;
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
    
    switch (self.segment.selectedSegmentIndex) {
        case 0:
        {
            if (indexPath.row == self.leftBaseLabelArray.count - 2 || indexPath.row == self.leftBaseLabelArray.count - 1)
            {
                cell.rightTF.height = 100;
            }
            cell.leftLabel.text = _leftBaseLabelArray[indexPath.row];
            cell.rightTF.delegate = self;
            self.productPublish = indexPath.row;
            cell.rightTF.tag = self.productPublish;
            
            switch (self.productPublish)
            {
                case productname:
                    cell.rightTF.text = self.productModel.productname;
                    break;
                case productmodel:
                    cell.rightTF.text = self.productModel.productmodel;
                    break;
                case specifications:
                    cell.rightTF.text = self.productModel.specifications;
                    break;
                case applycar:
                    cell.rightTF.text = self.productModel.applycar;
                    break;
                case vendors:
                    cell.rightTF.text = self.productModel.vendors;
                    break;
                case inventory:
                    cell.rightTF.text = self.productModel.inventory;
                    break;
                case purchaseprice:
                    cell.rightTF.text = self.productModel.purchaseprice;
                    break;
                case price:
                    cell.rightTF.text = self.productModel.price;
                    break;
                case scoreprice:
                    cell.rightTF.text = self.productModel.scoreprice;
                    break;
                case introduction:
                    cell.rightTF.text = self.productModel.introduction;
                    break;
                case remark:
                    cell.rightTF.text = self.productModel.remark;
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            cell.leftLabel.text = _leftSeviceLabelArray[indexPath.row];
            cell.rightTF.delegate = self;
            self.servicePublish = indexPath.row;
            cell.rightTF.tag = self.servicePublish;
            
            switch (self.servicePublish)
            {
                case services:
                    cell.rightTF.text = self.serviceModel.services;
                    break;
                case servicetype:
                    cell.rightTF.text = self.serviceModel.servicetype;
                    break;
                case content:
                    cell.rightTF.text = self.serviceModel.content;
                    break;
                case warranty:
                    cell.rightTF.text = self.serviceModel.warranty;
                    break;
                case manhours:
                    cell.rightTF.text = self.serviceModel.manhours;
                    break;
                case servicePrice:
                    cell.rightTF.text = self.serviceModel.price;
                    break;
                case serviceScoreprice:
                    cell.rightTF.text = self.serviceModel.scoreprice;
                    break;
                    
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == self.leftSecondcarLabelArray.count)
            {
                cell.rightTF.height = 100;
            }
            cell.leftLabel.text = _leftSecondcarLabelArray[indexPath.row];
            cell.rightTF.delegate = self;
            self.secondCarPublish = indexPath.row;
            cell.rightTF.tag = self.secondCarPublish;
            
            switch (self.secondCarPublish)
            {
                case brand:
                    cell.rightTF.text = self.carModel.brand;
                    break;
                case carPrice:
                    cell.rightTF.text = self.carModel.price;
                    break;
                case model:
                    cell.rightTF.text = self.carModel.model;
                    break;
                case cartype:
                    cell.rightTF.text = self.carModel.cartype;
                    break;
                case mileage:
                    cell.rightTF.text = self.carModel.mileage;
                    break;
                case buytime:
                {
                    if (self.buytime)
                    {
                        cell.rightTF.text = self.buytime;
                    }
                }
                    break;
                case number:
                    cell.rightTF.text = self.carModel.number;
                    break;
                case person:
                    cell.rightTF.text = self.carModel.person;
                    break;
                case frameid:
                    cell.rightTF.text = self.carModel.frameid;
                    break;
                case engineid:
                    cell.rightTF.text = self.carModel.engineid;
                    break;
                case property:
                    cell.rightTF.text = self.carModel.property;
                    break;
                case carDescription:
                    cell.rightTF.text = self.carModel.carDescription;
                    break;
                    
                    
                default:
                    break;
            }
        }
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
    switch (self.segment.selectedSegmentIndex)
    {
        case 0:
        {
            switch (textField.tag)
            {
                case productname:
                    self.productModel.productname = textField.text;
                    break;
                case productmodel:
                    self.productModel.productmodel = textField.text;
                    break;
                case specifications:
                    self.productModel.specifications = textField.text;
                    break;
                case applycar:
                    self.productModel.applycar = textField.text;
                    break;
                case vendors:
                    self.productModel.vendors = textField.text;
                    break;
                case inventory:
                    self.productModel.inventory = textField.text;
                    break;
                case purchaseprice:
                    self.productModel.purchaseprice = textField.text;
                    break;
                case price:
                    self.productModel.price = textField.text;
                    break;
                case scoreprice:
                    self.productModel.scoreprice = textField.text;
                    break;
                case introduction:
                    self.productModel.introduction = textField.text;
                    break;
                case remark:
                    self.productModel.remark = textField.text;
                    break;
                    
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (textField.tag)
            {
                case services:
                    self.serviceModel.services = textField.text;
                    break;
                case servicetype:
                    self.serviceModel.servicetype = textField.text;
                    break;
                case content:
                    self.serviceModel.content = textField.text;
                    break;
                case warranty:
                    self.serviceModel.warranty = textField.text;
                    break;
                case manhours:
                    self.serviceModel.manhours = textField.text;
                    break;
                case servicePrice:
                    self.serviceModel.price = textField.text;
                    break;
                case serviceScoreprice:
                    self.serviceModel.scoreprice = textField.text;
                    break;
                    
                    
                default:
                    break;
            }
            
        }
            break;
        case 2:
        {
            switch (textField.tag)
            {
                case brand:
                    self.carModel.brand = textField.text;
                    break;
                case carPrice:
                    self.carModel.price = textField.text;
                    break;
                case model:
                    self.carModel.model = textField.text;
                    break;
                case cartype:
                    self.carModel.cartype = textField.text;
                    break;
                case mileage:
                    self.carModel.mileage = textField.text;
                    break;
                case number:
                    self.carModel.number = textField.text;
                    break;
                case person:
                    self.carModel.person = textField.text;
                    break;
                case frameid:
                    self.carModel.frameid = textField.text;
                    break;
                case engineid:
                    self.carModel.engineid = textField.text;
                    break;
                case property:
                    self.carModel.property = textField.text;
                    break;
                case carDescription:
                    self.carModel.carDescription = textField.text;
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //    if (textField.tag == buytime)
    //    {
    //        if (![textField.text isEqualToString:@"请选择日期"])
    //        {
    //            textField.inputView = self.buytimeData;
    //            self.carInfoType = textField.tag;
    //            textField.text = @"请选择日期";
    //        }
    //        else
    //        {
    //            textField.text = self.buytime;
    //        }
    //    }
    //    else
    //    {
    //        [self.buytimeData removeFromSuperview];
    //    }
    
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



- (ServiceModel *)serviceModel
{
    if (!_serviceModel)
    {
        _serviceModel = [[ServiceModel alloc] init];
    }
    
    return _serviceModel;
}



- (CarModel *)carModel
{
    if (!_carModel)
    {
        _carModel = [[CarModel alloc] init];
    }
    
    return _carModel;
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
