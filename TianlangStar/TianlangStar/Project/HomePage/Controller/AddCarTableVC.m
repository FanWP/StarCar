//
//  AddCarTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/15.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AddCarTableVC.h"
#import "LabelTextFieldCell.h"
#import "CarModel.h"
#import "PictureCell.h"

@interface AddCarTableVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) LabelTextFieldCell *cell;
@property (nonatomic,strong) NSArray *leftLabelArray;
@property (nonatomic,strong) NSArray *rightPlaceholder;

@property (nonatomic,strong) CarModel *carModel;

@property (nonatomic,strong) UIView *finishView;
@property (nonatomic,strong) UIButton *finishButton;

@property (nonatomic,strong) NSMutableArray *textFieldArray;

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIImage *carImage;

@property (nonatomic,assign) CarInfoType carInfoType;

/** 购买日期 --时间戳 */
@property (nonatomic,strong) UIDatePicker *buytimeData;

@property (nonatomic,copy) NSString *buytime;

@end

@implementation AddCarTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    http://192.168.10.114:8080/carservice/carinforegistservlet
    
    
    self.title = @"添加爱车";
    
    [self addDatePIcker];
}



- (CarModel *)carModel
{
    if (!_carModel)
    {
        _carModel = [[CarModel alloc] init];
    }
    
    return _carModel;
}



- (NSArray *)leftLabelArray
{
    if (!_leftLabelArray)
    {
        _leftLabelArray = @[@"车辆类型",@"品牌",@"型号",@"车牌号",@"购买年份",@"车架号",@"发动机号"];
    }
    
    return _leftLabelArray;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self creatFinishView];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.finishView removeFromSuperview];
}



- (void)creatFinishView
{
    CGFloat finishViewY = KScreenHeight - Klength44;
    self.finishView = [[UIView alloc] initWithFrame:CGRectMake(0, finishViewY, KScreenWidth, Klength44)];
    self.finishView.backgroundColor = [UIColor blueColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self.finishView];
    
    self.finishButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.finishButton.frame = CGRectMake(0, 0, KScreenWidth, Klength44);
    [self.finishButton setTitle:@"完成" forState:(UIControlStateNormal)];
    [self.finishButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.finishButton addTarget:self action:@selector(finishAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.finishView addSubview:self.finishButton];
}



- (void)finishAction
{
    [self.view endEditing:YES];
    
    NSString *url = [NSString stringWithFormat:@"%@upload/carinforegistservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    
    if ([UserInfo sharedUserInfo].userType == 1)
    {
        parameters[@"userid"] = [NSString stringWithFormat:@"%ld",self.userid];
        
        YYLog(@"self.userid === %ld",self.userid);
    }
    
    parameters[@"cartype"] = self.carModel.cartype;
    parameters[@"brand"] = self.carModel.brand;
    parameters[@"model"] = self.carModel.model;
    parameters[@"carid"] = self.carModel.carid;
    parameters[@"buytime"] = self.carModel.buytime;
    parameters[@"frameid"] = self.carModel.frameid;
    parameters[@"engineid"] = self.carModel.engineid;

    YYLog(@"添加爱车的参数%@",parameters);
    
    if (self.carModel.cartype == nil || self.carModel.brand == nil || self.carModel.model == nil || self.carModel.carid == nil || self.carModel.buytime == nil || self.carModel.frameid == nil || self.carModel.engineid == nil)
    {
        [[AlertView sharedAlertView] addAfterAlertMessage:@"请完整填写车辆信息" title:@"提示"];
    }
    else
    {
        [[AFHTTPSessionManager manager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
             NSData *data = UIImageJPEGRepresentation(self.carImage, 0.5);
             
             if (data != nil)
             {
                 [formData appendPartWithFileData:data name:@"picture" fileName:@"img.jpg" mimeType:@"image/jpeg"];
             }
             
         } progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             YYLog(@"添加爱车返回：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 [[AlertView sharedAlertView] addAfterAlertMessage:@"添加爱车成功" title:@"提示"];
                 
                 //调用代理
                 if ([self.delegate respondsToSelector:@selector(addCarInfoSuccess)])
                 {
                     [self.delegate addCarInfoSuccess];
                 }
                 [self.navigationController popViewControllerAnimated:YES];
                 
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             YYLog(@"添加爱车错误：%@",error);
         }];
    }
}



/**
 *  添加时间选择器
 */
-(void)addDatePIcker
{
    //日期选择器
    //iphone6/6s
    UIDatePicker *startDatePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,KScreenHeight ,KScreenWidth, 162)];
    
    startDatePicker.datePickerMode=UIDatePickerModeDate;
    startDatePicker.date=[NSDate date];
    self.buytimeData.hidden = NO;
    self.buytimeData = startDatePicker;
    

    [self.buytimeData addTarget:self action:@selector(selecStarttDate) forControlEvents:UIControlEventValueChanged];
}



/** 时间选择器的点击事件--较强险提醒日期 */
-(void)selecStarttDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    switch (self.carInfoType)
    {
        case buytime://购买日期
        {
            self.buytime=[outputFormatter stringFromDate:self.buytimeData.date];
            self.carModel.buytime = [NSString stringWithFormat:@"%ld", (long)[self.buytimeData.date timeIntervalSince1970]];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return self.leftLabelArray.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.carImage)
    {
        if (indexPath.section == 0)
        {
            return 0.3 * KScreenHeight + 2 * Klength5;
        }
        
        return 40;
    }
    
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 1;
    }
    else
    {
        return 15;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (self.carImage)
        {
            static NSString *identifier0 = @"cell0";
            
            PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
            
            if (cell == nil)
            {
                
                cell = [[PictureCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier0];
                
            }
            
            cell.pictureView.image = self.carImage;
            
            return cell;
        }
        else
        {
            static NSString *identifier = @"cell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (cell == nil)
            {
                
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
                
            }
            
            cell.textLabel.text = @"上传照片";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;

            return cell;
        }
    }
    else
    {
        
        static NSString *identifier1 = @"cell1";
        
        LabelTextFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil)
        {
            
            cell = [[LabelTextFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
            
        }
        
        cell.leftLabel.text = _leftLabelArray[indexPath.row];
        cell.rightTF.delegate = self;
        
        self.carInfoType = indexPath.row;
        cell.rightTF.tag = self.carInfoType;
        
        switch (self.carInfoType)
        {
            case cartype:
                cell.rightTF.text = self.carModel.cartype;
                break;
            case brand:
                cell.rightTF.text = self.carModel.brand;
                break;
            case model:
                cell.rightTF.text = self.carModel.model;
                break;
            case carid:
                cell.rightTF.text = self.carModel.carid;
                break;
            case buytime:
            {
                if (self.buytime)
                {
                    cell.rightTF.text = self.buytime;
                }
                break;
            }
            case frameid:
                cell.rightTF.text = self.carModel.frameid;
                break;
            case engineid:
                cell.rightTF.text = self.carModel.engineid;
                break;
                
            default:
                break;
        }
        
        return cell;
    }
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
        case cartype:
            self.carModel.cartype = textField.text;
            break;
        case brand:
            self.carModel.brand = textField.text;
            break;
        case model:
            self.carModel.model = textField.text;
            break;
        case carid:
            self.carModel.carid = textField.text;
            break;
        case frameid:
            self.carModel.frameid = textField.text;
            break;
        case engineid:
            self.carModel.engineid = textField.text;
            break;
            
        default:
            break;
    }
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == buytime)
    {
        if (![textField.text isEqualToString:@"请选择日期"])
        {
            textField.inputView = self.buytimeData;
            self.carInfoType = textField.tag;
            textField.text = @"请选择日期";
        }
        else
        {
            textField.text = self.buytime;
        }
    }
    else
    {
        [self.buytimeData removeFromSuperview];
    }
    
    return YES;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self.finishView removeFromSuperview];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        
        UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"从相册获取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
        {
            [self getPhotoLibraryImage];
        }];
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
        {
            [self getCameraImage];
        }];

        [[AlertView sharedAlertView] addAlertMessage:nil title:nil cancleAction:cancleAction photoLibraryAction:photoLibraryAction cameraAction:cameraAction];
    }
}



// 获取照相机图片
- (void)getCameraImage
{
    UIImagePickerController *CameraImage = [[UIImagePickerController alloc] init];
    [CameraImage setSourceType:(UIImagePickerControllerSourceTypeCamera)];
    CameraImage.delegate = self;
    [self presentViewController:CameraImage animated:YES completion:nil];
}
// 获取相册图片
- (void)getPhotoLibraryImage
{
    UIImagePickerController *imgC = [[UIImagePickerController alloc] init];
    [imgC setSourceType:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)];
    imgC.delegate = self;
    [self presentViewController:imgC animated:YES completion:nil];
    
}


// 从照片中获取调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    YYLog(@"image----%@",image);
    self.carImage = image;
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [self.tableView reloadData];
    
    });
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end














