//
//  ProductPublishTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/18.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ProductPublishTableVC.h"

#import "LabelTextFieldCell.h"
#import "LabelTFLabelCell.h"
#import "AddImagesCollectionVC.h"

#import "ProductModel.h"
#import "ServiceModel.h"
#import "CarModel.h"

#import "UIView+MyExtension.h"
#import "Common.h"
#import "UIViewController+Default.h"
//添加附件
#import "SectionModel.h"
#import "HouseImageHeaderView.h"
#import "HouseImageCell.h"
#import "WUAlbum.h"
#import "UIImage+Aspect.h"
#import "UIImage+FixOrientation.h"

NSString *const commissionImageViewCellIdentifier = @"HouseImageViewCellIdentifier";
NSString *const commissionImageViewHeaderIdentifier = @"HouseImageViewHeaderIdentifier";


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



@interface ProductPublishTableVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HouseImageCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,WUAlbumDelegate,WUImageBrowseViewDelegate,UIViewControllerPreviewingDelegate,UITextFieldDelegate>

//添加附件
@property (strong, nonatomic) UIView *bottomView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray<SectionModel*> *dataArray;
@property(nonatomic,assign) NSInteger currentSection;       //当前操作的组
@property(nonatomic,strong) UIImage *plusImage;

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
@property (nonatomic,strong) UIDatePicker *warrantyPicker;

/** 接收购买时间的字符串 */
@property (nonatomic,copy) NSString *buytime;
@property (nonatomic,copy) NSString *warranty;

/** 商品数组 */
@property (nonatomic,strong) NSArray *leftBaseLabelArray;

/** 服务数组 */
@property (nonatomic,strong) NSArray *leftSeviceLabelArray;

/** 二手车数组 */
@property (nonatomic,strong) NSArray *leftSecondcarLabelArray;

@property (nonatomic,strong) UISegmentedControl *segment;

@property (nonatomic,strong) SectionModel *s0;

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong) HouseImageCell *cell;

@property (nonatomic,strong) NSMutableArray *headerImagesArray;

@end


@implementation ProductPublishTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _leftBaseLabelArray = @[@"商品名称",@"商品类型",@"商品规格",@"适用车型",@"供应商",@"入库数量",@"进价(元)",@"售价(星币)",@"售价(积分)",@"简介",@"备注"];
    
    _leftSeviceLabelArray = @[@"服务项目",@"服务类型",@"服务内容",@"保修期限",@"预计耗时(h)",@"售价(星币)",@"售价(积分)"];
    
    _leftSecondcarLabelArray = @[@"品牌",@"报价",@"型号",@"车型",@"行驶里程",@"购买年份",@"车牌号",@"原车主",@"车架号",@"发动机号",@"使用性质",@"车辆简介"];
    
    _headerImagesArray = [NSMutableArray array];
    
    
//    [self rightItem];// 入库按钮
    
    [self addDatePIcker];
    
    [self creatAddImagesView];// 添加图片的headerView
    
    [self creatTitleView];// 导航栏的选择title
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}




- (void)creatTitleView
{
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"商品",@"服务",@"二手车"]];
    self.segment.frame = CGRectMake(0, 0, 150, 30);
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:(UIControlEventValueChanged)];
    self.segment.apportionsSegmentWidthsByContent = YES;
    
    self.segment.tintColor = [UIColor whiteColor];
    
    NSDictionary *normalDic = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *selectedDic = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.segment setTitleTextAttributes:normalDic forState:(UIControlStateNormal)];
    [self.segment setTitleTextAttributes:selectedDic forState:(UIControlStateSelected)];
    
    self.segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.segment;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"入库" style:(UIBarButtonItemStylePlain) target:self action:@selector(productPutinStorage)];
}



- (void)creatAddImagesView
{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth / 3 + 20)];
//    if (self.s0.mutableCells.count > 3)
//    {
//        _bottomView.height = 2 * (KScreenWidth / 3) + 20;
//    }
//    if (self.s0.mutableCells.count > 6)
//    {
//        _bottomView.height = 3 * (KScreenWidth / 3) + 20;
//    }
    [self createData];
    [self.bottomView addSubview:self.collectionView];
    self.tableView.tableHeaderView = self.bottomView;
}



- (void)segmentChange:(UISegmentedControl *)segment
{
    [self addDatePIcker];
    
    switch (segment.selectedSegmentIndex)
    {
        case 0:
        {
            YYLog(@"商品");
            [_bottomView removeFromSuperview];
            [self creatAddImagesView];// 添加图片的headerView
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"入库" style:(UIBarButtonItemStylePlain) target:self action:@selector(productPutinStorage)];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
            break;
        case 1:
        {
            YYLog(@"服务");
            [_bottomView removeFromSuperview];
            [self creatAddImagesView];// 添加图片的headerView
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"入库" style:(UIBarButtonItemStylePlain) target:self action:@selector(servicePutinStorage)];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
            break;
        case 2:
        {
            YYLog(@"二手车");
            [_bottomView removeFromSuperview];
            [self creatAddImagesView];// 添加图片的headerView
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"入库" style:(UIBarButtonItemStylePlain) target:self action:@selector(secondCarPutinStorage)];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
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
    
    if ([UserInfo sharedUserInfo].RSAsessionId != nil || [[UserInfo sharedUserInfo].RSAsessionId length] != 0 || self.productModel.productname != nil || [self.productModel.productname length] != 0 || self.productModel.productmodel != nil || [self.productModel.productmodel length] != 0 || self.productModel.specifications != nil || [self.productModel.specifications length] != 0 || self.productModel.applycar != nil || [self.productModel.applycar length] != 0 || self.productModel.vendors != nil || [self.productModel.vendors length] != 0 || self.productModel.inventory != nil || [self.productModel.inventory length] != 0 || self.productModel.purchaseprice != nil || self.productModel.purchaseprice != 0 || self.productModel.price != nil || [self.productModel.price length] != 0 || self.productModel.scoreprice != nil || [self.productModel.scoreprice length] != 0 || self.productModel.introduction != nil || [self.productModel.introduction length]!= 0)
    {
        NSString *url = [NSString stringWithFormat:@"%@upload/releasecommodityservlet",URL];
        
        [SVProgressHUD showWithStatus:@"正在入库"];
        
        [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
             _headerImagesArray = [NSMutableArray arrayWithArray:[self getImagesWithSection:0]];

             if(_headerImagesArray && _headerImagesArray.count > 0) {
                 for (id item in _headerImagesArray) {
                     NSData *data;
                     if([self isAsset:item]) {
                         data = [item dataWithCompressionQualityDefault];
                     } else {
                         data = UIImageJPEGRepresentation(item, 1);
                     }
                     
                     if (data != nil)
                     {
                         if (data.length > 300 * 1024) {
                             UIImage *newImg = [UIImage imageWithData:data];
                             data = [UIImage reSizeImageData:newImg maxImageSize:420 maxSizeWithKB:300];
                         }
                         [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
                     }
                 }
             }
             

             
         } progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             YYLog(@"商品入库返回：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 [[AlertView sharedAlertView] addAfterAlertMessage:@"商品入库成功" title:@"提示"];
                 
                 [_bottomView removeFromSuperview];
                 
                 [self creatAddImagesView];
                 
                 self.productModel = nil;
                 
                 [self.tableView reloadData];
                 
             }
             
             [SVProgressHUD dismiss];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             YYLog(@"商品入库错误：%@",error);
             
             [SVProgressHUD dismiss];
         }];
    }
    else
    {
        [[AlertView sharedAlertView] addAfterAlertMessage:@"请完整输入商品信息" title:@"提示"];
    }
}



#pragma mark - 服务入库
- (void)servicePutinStorage
{
    [self.view endEditing:YES];
    
    [SVProgressHUD showWithStatus:@"正在入库"];
    
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
    
    
    
    if ([UserInfo sharedUserInfo].RSAsessionId != nil || [[UserInfo sharedUserInfo].RSAsessionId length] != 0 || self.serviceModel.services != nil || self.serviceModel.services != 0 || self.serviceModel.servicetype != nil || [self.serviceModel.servicetype length] != 0 || self.serviceModel.content != nil || [self.serviceModel.content length] != 0 || self.serviceModel.warranty != nil || [self.serviceModel.warranty length] != 0 || self.serviceModel.manhours != nil || [self.serviceModel.manhours length] != 0 || self.serviceModel.price != nil || [self.serviceModel.price length] != 0 || self.serviceModel.scoreprice != nil || [self.serviceModel.scoreprice length] != 0)
    {
        
        
        [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
             _headerImagesArray = [NSMutableArray arrayWithArray:[self getImagesWithSection:0]];
             
             if(_headerImagesArray && _headerImagesArray.count > 0) {
                 for (id item in _headerImagesArray) {
                     NSData *data;
                     if([self isAsset:item]) {
                         data = [item dataWithCompressionQualityDefault];
                     } else {
                         data = UIImageJPEGRepresentation(item, 1);
                     }
                     
                     if (data != nil)
                     {
                         if (data.length > 300 * 1024) {
                             UIImage *newImg = [UIImage imageWithData:data];
                             data = [UIImage reSizeImageData:newImg maxImageSize:420 maxSizeWithKB:300];
                         }
                         [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
                     }
                 }
             }
             
         } progress:^(NSProgress * _Nonnull uploadProgress)
         {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             YYLog(@"服务入库返回：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 [[AlertView sharedAlertView] addAfterAlertMessage:@"服务入库成功" title:@"提示"];
                 
                 [_bottomView removeFromSuperview];
                 
                 [self creatAddImagesView];
                 
                 self.serviceModel = nil;
                 
                 self.warranty = @"";
                 
                 [self.tableView reloadData];
                 
             }
             
             [SVProgressHUD dismiss];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             YYLog(@"服务入库错误：%@",error);
             
             [SVProgressHUD dismiss];
             
         }];
    }
    else
    {
        [[AlertView sharedAlertView] addAfterAlertMessage:@"请完整输入服务信息" title:@"提示"];
    }
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
    
    if ([UserInfo sharedUserInfo].RSAsessionId != nil || [[UserInfo sharedUserInfo].RSAsessionId length] != 0 || self.carModel.brand != nil || [self.carModel.brand length] != 0 || self.carModel.price != nil || [self.carModel.price length] != 0 || self.carModel.model != nil || [self.carModel.model length] != 0 || self.carModel.cartype != nil || [self.carModel.cartype length] != 0 || self.carModel.mileage != nil || [self.carModel.mileage length] != 0 || self.carModel.buytime != nil || [self.carModel.buytime length] != 0 || self.carModel.number != nil || [self.carModel.number length] || self.carModel.person != nil || [self.carModel.person length] != 0 || self.carModel.frameid != nil || [self.carModel.frameid length] != 0 || self.carModel.engineid != nil || [self.carModel.engineid length] != 0 || self.carModel.property != nil || [self.carModel.property length] != 0 || [self.carModel.carDescription length] != 0)
    {
        [SVProgressHUD showWithStatus:@"正在入库"];
        
        [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
             _headerImagesArray = [NSMutableArray arrayWithArray:[self getImagesWithSection:0]];
             
             if(_headerImagesArray && _headerImagesArray.count > 0) {
                 for (id item in _headerImagesArray) {
                     NSData *data;
                     if([self isAsset:item]) {
                         data = [item dataWithCompressionQualityDefault];
                     } else {
                         data = UIImageJPEGRepresentation(item, 1);
                     }
                     
                     if (data != nil)
                     {
                         if (data.length > 300 * 1024) {
                             UIImage *newImg = [UIImage imageWithData:data];
                             data = [UIImage reSizeImageData:newImg maxImageSize:420 maxSizeWithKB:300];
                         }
                         [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
                     }
                 }
             }
             
         } progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             YYLog(@"二手车入库返回：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 [[AlertView sharedAlertView] addAfterAlertMessage:@"二手车入库成功" title:@"提示"];
                 
                 [_bottomView removeFromSuperview];
                 
                 [self creatAddImagesView];
                 
                 self.carModel = nil;
                 
                 self.buytime = @"";
                 
                 [self.tableView reloadData];
             }
             
             [SVProgressHUD dismiss];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             YYLog(@"二手车入库错误：%@",error);
             
             [SVProgressHUD dismiss];
             
         }];
    }
    else
    {
        [[AlertView sharedAlertView] addAfterAlertMessage:@"请完整输入二手车信息" title:@"提示"];
    }
}



/**
 *  添加时间选择器
 */
- (void)addDatePIcker
{
    //日期选择器
    //iphone6/6s
    UIDatePicker *startDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,KScreenHeight ,KScreenWidth, 162)];
    
    startDatePicker.datePickerMode = UIDatePickerModeDate;
    startDatePicker.date = [NSDate date];
    self.buytimePicker.hidden = NO;
    self.buytimePicker = startDatePicker;
    
    self.warrantyPicker.hidden = NO;
    self.warrantyPicker = startDatePicker;
    
    [self.buytimePicker addTarget:self action:@selector(selecStartDate) forControlEvents:UIControlEventValueChanged];
    [self.warrantyPicker addTarget:self action:@selector(selecStartDate) forControlEvents:(UIControlEventValueChanged)];
}



/** 时间选择器的点击事件--较强险提醒日期 */
- (void)selecStartDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    switch (self.secondCarPublish)
    {
        case buytime://购买日期
        {
            self.buytime = [outputFormatter stringFromDate:self.buytimePicker.date];
            self.carModel.buytime = [NSString stringWithFormat:@"%ld", (long)[self.buytimePicker.date timeIntervalSince1970]];
            break;
        }
            
        default:
            break;
    }
    switch (self.servicePublish)
    {
        case warranty://购买日期
        {
            self.warranty = [outputFormatter stringFromDate:self.warrantyPicker.date];
            self.serviceModel.warranty = [NSString stringWithFormat:@"%ld", (long)[self.warrantyPicker.date timeIntervalSince1970]];
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
//    switch (self.segment.selectedSegmentIndex) {
//        case 0:
//        {
//            
//            if (indexPath.row == self.leftBaseLabelArray.count - 2 || indexPath.row == self.leftBaseLabelArray.count - 1)
//            {
//                return 110;
//            }
//        }
//            break;
//        case 2:
//        {
//            if (indexPath.row == self.leftSecondcarLabelArray.count)
//            {
//                return 110;
//            }
//        }
//            break;
//            
//        default:
//            break;
//    }
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
                cell.rightTF.adjustsFontSizeToFitWidth = YES;
                cell.rightTF.minimumFontSize = 10;
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
                {
                    if (self.warranty)
                    {
                        cell.rightTF.text = self.warranty;
                    }
                }
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
            if (indexPath.row == self.leftSecondcarLabelArray.count - 1)
            {
                cell.rightTF.adjustsFontSizeToFitWidth = YES;
                cell.rightTF.minimumFontSize = 10;
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
    
    switch (self.segment.selectedSegmentIndex)
    {
        case 1:
        {
            if (textField.tag == warranty)
            {
                if (![textField.text isEqualToString:@"请选择日期"])
                {
                    textField.inputView = self.warrantyPicker;
                    self.servicePublish = textField.tag;
                    textField.text = @"请选择日期";
                }
                else
                {
                    textField.text = self.warranty;
                }
            }
            else
            {
                [self.warrantyPicker removeFromSuperview];
            }
        }
            break;
        case 2:
        {
            if (textField.tag == buytime)
            {
                if (![textField.text isEqualToString:@"请选择日期"])
                {
                    textField.inputView = self.buytimePicker;
                    self.secondCarPublish = textField.tag;
                    textField.text = @"请选择日期";
                }
                else
                {
                    textField.text = self.buytime;
                }
            }
            else
            {
                [self.buytimePicker removeFromSuperview];
            }

        }
            break;
            
        default:
            break;
    }
    
    return YES;
}



#pragma mark--添加附件
- (void)createData {
    
    _plusImage = [UIImage imageNamed:@"add"];
    
    self.s0 = [SectionModel sectionModelWith:@"" cells:nil];
    self.s0.mutableCells = [NSMutableArray array];
    
    [self.s0.mutableCells addObject:_plusImage];
    
    _dataArray = @[self.s0];
}
#pragma 附件
- (UICollectionView *)collectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat width = (self.view.width - 30) / 3;
    layout.itemSize = CGSizeMake(width, width);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.bottomView.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = YES;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor grayColor];
    [_collectionView registerClass:[HouseImageCell class] forCellWithReuseIdentifier:commissionImageViewCellIdentifier];
    
    if(SystemVersion >= 9.0) {
        UILongPressGestureRecognizer *collectionViewLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewLongPress:)];
        [_collectionView addGestureRecognizer:collectionViewLongPress];
        
        [self registerForPreviewingWithDelegate:self sourceView:_collectionView];
    }
    
    return _collectionView;
}
//重排图片
-(void)collectionViewLongPress:(UILongPressGestureRecognizer*)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *selectedIndexPath = [_collectionView indexPathForItemAtPoint:[gesture locationInView:_collectionView]];
            if(selectedIndexPath) {
                [_collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            [_collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [_collectionView endInteractiveMovement];
        }
            break;
        default: {
            [_collectionView cancelInteractiveMovement];
        }
            break;
    }
}
#pragma -mark 3D-Touch peek

-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:location];
    if(!indexPath || indexPath.section == NSNotFound || indexPath.row == NSNotFound) {
        return nil;
    }
    
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    if([row isEqual:_plusImage]) {
        return nil;
    }
    
    self.cell = (HouseImageCell*)[_collectionView cellForItemAtIndexPath:indexPath];
    CGRect sourceRect = [self.cell convertRect:self.cell.imageView.frame toView:[previewingContext sourceView]];
    [previewingContext setSourceRect:sourceRect];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    if([row isKindOfClass:[WUAlbumAsset class]]) {
        self.image = [row imageWithSize:bounds.size];
    } else if([row isKindOfClass:[UIImage class]]) {
        self.image = row;
    } else {
        return nil;
    }
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor clearColor];
    viewController.userInfo = indexPath;
    viewController.view.bounds = self.view.bounds;
    
    CGRect imageRect = [self.image rectAspectFitRectForSize:CGSizeMake(bounds.size.width - 60, bounds.size.height - 80)];
    imageRect.origin = CGPointMake(self.view.width/2-CGRectGetWidth(imageRect)/2, self.view.height/2-CGRectGetHeight(imageRect)/2 - 64);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
    imageView.image = self.image;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 10;
    
    [viewController.view addSubview:imageView];
    
    return viewController;
}
//pop
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    NSIndexPath *indexPath = (NSIndexPath*)[viewControllerToCommit userInfo];
    _currentSection = indexPath.section;
    NSArray *images = [self getImagesWithSection:indexPath.section];
    if(images) {
        WUImageBrowseView *bv = [[WUImageBrowseView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        bv.images = images;
        bv.delegate = self;
        bv.currentPage = indexPath.row;
        [bv show:self.navigationController.view];
        //        [self setInteractivePopGestureRecognizerEnabled:NO];
    }
    
}
#pragma -mark collectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SectionModel *s = _dataArray[section];
    return s.mutableCells.count;
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    if([row isEqual:_plusImage]) {
        return NO;
    }
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [self swapData:sourceIndexPath toIndexPath:destinationIndexPath];
    
    SectionModel *s = _dataArray[destinationIndexPath.section];
    //如果目标被移动到最后一个项
    if(destinationIndexPath.row > 0 && destinationIndexPath.row == s.mutableCells.count - 1) {
        id item = s.mutableCells[s.mutableCells.count - 2];
        if([item isEqual:_plusImage]) {
            [self swapData:destinationIndexPath toIndexPath:sourceIndexPath];
            [_collectionView moveItemAtIndexPath:destinationIndexPath toIndexPath:sourceIndexPath];
        }
    }
}
/**
 *  移动数据源
 *
 *  @param sourceIndexPath      源
 *  @param destinationIndexPath 目的
 */
-(void)swapData:(NSIndexPath*)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    SectionModel *s = _dataArray[destinationIndexPath.section];
    SectionModel *sourceSection = _dataArray[sourceIndexPath.section];
    id sourceItem = sourceSection.mutableCells[sourceIndexPath.row];
    [sourceSection.mutableCells removeObject:sourceItem];
    [s.mutableCells insertObject:sourceItem atIndex:destinationIndexPath.row];
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *view;
//    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        HouseImageHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:commissionImageViewHeaderIdentifier forIndexPath:indexPath];
//        SectionModel *s = _dataArray[indexPath.section];
//        headerView.titleLabel.text = s.title;
//        headerView.titleLabel.font = UIFontLarge;
//        headerView.titleLabel.textColor = [UIColor blackColor];
//        view = headerView;
//        
//    }
//    
//    return view;
//}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HouseImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:commissionImageViewCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    if([self isAsset:row]) {
        cell.imageView.image = nil;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.layer.borderWidth = 0;
        cell.showDelete = YES;
        WUAlbumAsset *asset = (WUAlbumAsset*)row;
        __weak typeof(cell) weakCell = cell;
        CGSize size = CGSizeMake(cell.width * 2, cell.height * 2);
        [asset requestImageWithSize:size complete:^(UIImage *image) {
            if(weakCell) {
                __strong typeof(weakCell) strongCell = weakCell;
                strongCell.imageView.image = image;
            }
        }];
    } else if([row isEqual:_plusImage]) {
        cell.imageView.image = row;
        cell.imageView.layer.borderWidth = 1;
        cell.imageView.contentMode = UIViewContentModeCenter;
        cell.showDelete = NO;
    } else if([row isKindOfClass:[UIImage class]]) {
        cell.imageView.image = row;
        cell.imageView.layer.borderWidth = 0;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.showDelete = YES;
    }
    
    return cell;
}

/**
 *  判断是否为相册资源类型
 */
- (BOOL)isAsset:(id)value {
    if([value isKindOfClass:[WUAlbumAsset class]]) {
        return YES;
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentSection = indexPath.section;
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    
    if([row isEqual:_plusImage]) {
        [WUAlbum showPickerMenu:self delegate:self];
    } else {
        
        NSArray *images = [self getImagesWithSection:_currentSection];
        if(images) {
            WUImageBrowseView *bv = [[WUImageBrowseView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            bv.images = images;
            bv.delegate = self;
            bv.currentPage = indexPath.row;
            CGRect startFrame = [cell convertRect:cell.bounds toView:self.navigationController.view];
            
            UIImage *image;
            if([self isAsset:row]) {
                image = [row imageWithSize:[[UIScreen mainScreen] bounds].size];
            } else if([row isKindOfClass:[UIImage class]]) {
                image = row;
            } else if([row isKindOfClass:[NSString class]]) {
                //http 请求
            }
            
            [bv show:self.navigationController.view startFrame:startFrame foregroundImage:image];
            //            [self setInteractivePopGestureRecognizerEnabled:NO];
        }
    }
}

/**
 *  获取选择的图片
 */
- (NSArray *)getImagesWithSection:(NSInteger)index {
    SectionModel *s = _dataArray[index];
    if(s.mutableCells.count == 0) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:s.mutableCells];
    if([s.mutableCells.lastObject isEqual:_plusImage]) {
        [array removeLastObject];
        
    }
    
    return [NSArray arrayWithArray:array];
}

/**
 *  获取所有图片
 */
- (NSArray *)getAllImages {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _dataArray.count; i++) {
        NSArray *images = [self getImagesWithSection:i];
        if(images || images.count > 0) {
            [array addObject:images];
            
        }
    }
    
    return [NSArray arrayWithArray:array];
}

#pragma -mark imageBrowseView delegate

- (CGRect)imageBrowseView:(WUImageBrowseView *)view willCloseAtIndex:(NSInteger)index {
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:_currentSection]];
    CGRect endFrame = [cell convertRect:cell.bounds toView:self.navigationController.view];
    //    [self setInteractivePopGestureRecognizerEnabled:YES];
    return endFrame;
}

#pragma -mark HouseImageCell delegate

-(void)houseImageCellWillDeleteCell:(HouseImageCell *)cell {
    cell.imageView.image = nil;
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    SectionModel *s = _dataArray[indexPath.section];
    [s.mutableCells removeObjectAtIndex:indexPath.row];
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
}

//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info[UIImagePickerControllerOriginalImage] fixOrientation];
    
    WUAlbumAsset *asset = [WUAlbum savePhotoWithImage:image];
    if(asset) {
        [self insertDataArray:@[asset] atSection:_currentSection];
    } else {
        //压缩图片
        NSData *data = [WUAlbumAsset compressionWithImage:image];
        UIImage *image = [UIImage imageWithData:data];
        [self insertDataArray:@[image] atSection:_currentSection];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  完成相册选择
 *
 *  @param assets 图片资源
 */
-(void)albumFinishedSelected:(NSArray<WUAlbumAsset *> *)assets {
    [self insertDataArray:assets atSection:_currentSection];
}

/**
 *  插入到数据集
 */
-(void)insertDataArray:(NSArray*)array atSection:(NSInteger)section {
    SectionModel *s = _dataArray[section];
    [s.mutableCells insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:(NSRange){s.mutableCells.count - 1,array.count}]];
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


















