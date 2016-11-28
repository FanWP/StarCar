//
//  AddCarInfo.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/4.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AddCarInfo.h"
#import "CarInputCell.h"
#import "CarModel.h"
#import "PictureCell.h"
#import "LabelTextFieldCell.h"

typedef enum : NSUInteger {
    carid = 0,
    brand,
    model,
    cartype,
    frameid,
    engineid,
    buytime,
    insuranceid,
    insurancetime,
    commercialtime
} CheckinCar;

@interface AddCarInfo ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 单元格左侧的描述 */
@property (nonatomic,strong) NSArray *rightArr;


/** 提交按钮 */
@property (nonatomic,strong) UIButton *handButton;


/** 较强险提醒日期 --时间戳 */
@property (nonatomic,strong) UIDatePicker *insuranceidData;

/** 车辆的购买日期日期 */
@property (nonatomic,copy) NSString *buytime;
/** 较强险的提醒日期 */
@property (nonatomic,copy) NSString *insuranceid;
/** 较强险的提醒日期 */
@property (nonatomic,copy) NSString *commercialtime;


/** 记录输入框的内容 */
//@property (nonatomic,strong) NSMutableArray *textArr;


/** 记录用户年月入日期选择器 */
@property (nonatomic,assign) CheckinCar checkinCar;

@property (nonatomic,strong) UIImage *carImage;

@property (nonatomic,strong) NSArray *leftLabelArray;

@property (nonatomic,strong) LabelTextFieldCell *cell;

@property (nonatomic,strong) CarModel *carModel;

@end

@implementation AddCarInfo

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addFooter];
    
    [self addDatePIcker];
}



- (NSArray *)leftLabelArray
{
    if (!_leftLabelArray)
    {
        _leftLabelArray = @[@"车牌号",@"品牌",@"型号",@"车型",@"车架号",@"发动机号",@"购买年份",@"保险信息",@"较强险提醒日期",@"商业险提醒日期"];
    }
    
    return _leftLabelArray;
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
    self.insuranceidData.hidden = NO;
    self.insuranceidData = startDatePicker;
    
    [self.insuranceidData addTarget:self action:@selector(selecStarttDate) forControlEvents:UIControlEventValueChanged];
}

/** 时间选择器的点击事件--较强险提醒日期 */
-(void)selecStarttDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    switch (self.checkinCar)
    {
        case buytime://购买日期
        {
            self.buytime=[outputFormatter stringFromDate:self.insuranceidData.date];
            self.carModel.buytime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
        case insurancetime://较强险
        {
            self.insuranceid=[outputFormatter stringFromDate:self.insuranceidData.date];
            self.carModel.insurancetime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
        case commercialtime://商业险
        {
            self.commercialtime=[outputFormatter stringFromDate:self.insuranceidData.date];
            self.carModel.commercialtime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
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


- (CarModel *)carModel
{
    if (!_carModel)
    {
        _carModel = [[CarModel alloc] init];
    }
    
    return _carModel;
}



//-(NSMutableArray *)textArr
//{
//    if (_textArr == nil)
//    {
//        _textArr = [NSMutableArray array];
//    }
//    return _textArr;
//}


-(NSArray *)rightArr
{
    if (_rightArr == nil)
    {
        _rightArr = @[@"车牌号",@"品牌",@"型号",@"车型",@"车架号",@"发动机号",@"购买年份",@"保险信息",@"较强险提醒日期",@"商业险提醒日期"];
    }
    
    return _rightArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)addFooter
{
    UIView *handView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 84)];
    self.handButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    CGFloat handButtonX = KScreenWidth / 2 - KScreenWidth * 0.6 / 2;
    self.handButton.frame = CGRectMake(handButtonX, 20, KScreenWidth * 0.6, 30);
    [self.handButton setTitle:@"提交" forState:(UIControlStateNormal)];
    self.handButton.backgroundColor = [UIColor orangeColor];
    [self.handButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.handButton addTarget:self action:@selector(handAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.handButton.backgroundColor = XLXcolor(44, 171, 63);
    self.handButton.layer.cornerRadius = 6;
    [self.handButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //    handView.backgroundColor = [UIColor grayColor];
    [handView addSubview:self.handButton];
    self.tableView.tableFooterView = handView;
}



//提交按钮的点击事件
- (void)handAction:(UIButton *)button
{
    [self.view endEditing:YES];

    if (self.carModel.carid == nil        || self.carModel.carid.length == 0   ||
        self.carModel.brand == nil        || self.carModel.brand.length == 0   ||
        self.carModel.model == nil        || self.carModel.model.length == 0   ||
        self.carModel.cartype == nil      || self.carModel.cartype.length == 0 ||
        self.carModel.frameid == nil      || self.carModel.frameid.length == 0 ||
        self.carModel.engineid == nil     || self.carModel.engineid.length == 0   ||
        self.carModel.buytime == nil      || self.carModel.buytime.length == 0   ||
        self.carModel.insuranceid == nil  || self.carModel.insuranceid.length == 0 ||
        self.carModel.insurancetime == nil || self.carModel.insurancetime.length == 0||
        self.carModel.commercialtime == nil || self.carModel.commercialtime.length == 0
        )
    {
        [[AlertView sharedAlertView] addAlertMessage:@"请完整填写车辆信息" title:@"提示"];
        return;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    params[@"userid"] = [UserInfo sharedUserInfo].userID;
    params[@"carid"] = self.carModel.carid;
    params[@"brand"] = self.carModel.brand;
    params[@"model"] = self.carModel.model;
    params[@"cartype"] = self.carModel.cartype;
    params[@"frameid"] = self.carModel.frameid;
    params[@"engineid"] = self.carModel.engineid;
    params[@"buytime"] = self.carModel.buytime;
    params[@"insuranceid"] = self.carModel.insuranceid;
    params[@"insurancetime"] = self.carModel.insurancetime;
    params[@"commercialtime"] = self.carModel.commercialtime;

    NSString *url = [NSString stringWithFormat:@"%@upload/carinforegistservlet",URL];
    YYLog(@"我的车辆信息登记params----%@",params);
    
    [[AFHTTPSessionManager manager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImageJPEGRepresentation(self.carImage, 0.5);
        
        if (data != nil)
        {
            [formData appendPartWithFileData:data name:@"picture" fileName:@"img.jpg" mimeType:@"image/jpeg"];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"我的车辆信息登记返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            [[AlertView sharedAlertView] addAfterAlertMessage:@"添加爱车成功" title:@"提示"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"我的车辆信息登记错误：error----%@",error);
    }];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        
        self.cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (self.cell == nil)
        {
            
            self.cell = [[LabelTextFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
            
        }
        
        self.cell.leftLabel.width = 120;
        self.cell.rightTF.x = Klength15 + self.cell.leftLabel.width + Klength10;
        self.cell.rightTF.width = KScreenWidth - 2 * Klength15 - self.cell.leftLabel.width - Klength10;
        
        self.cell.leftLabel.text = _leftLabelArray[indexPath.row];
        self.cell.rightTF.delegate = self;
        
        self.checkinCar = indexPath.row;
        self.cell.rightTF.tag = self.checkinCar;
        
        switch (self.checkinCar)
        {
            case cartype:
                self.cell.rightTF.text = self.carModel.cartype;
                break;
            case brand:
                self.cell.rightTF.text = self.carModel.brand;
                break;
            case model:
                self.cell.rightTF.text = self.carModel.model;
                break;
            case carid:
                self.cell.rightTF.text = self.carModel.carid;
                break;
            case frameid:
                self.cell.rightTF.text = self.carModel.frameid;
                break;
            case engineid:
                self.cell.rightTF.text = self.carModel.engineid;
                break;
            case insuranceid:
                self.cell.rightTF.text = self.carModel.insuranceid;
                break;
            case buytime:
            {
                if (self.buytime)
                {
                    self.cell.rightTF.text = self.buytime;
                }
                break;
            }
            case insurancetime:
            {
                if (self.insuranceid)
                {
                    self.cell.rightTF.text = self.insuranceid;
                }
                break;
            }
            case commercialtime:
            {
                if (self.commercialtime)
                {
                    self.cell.rightTF.text = self.commercialtime;
                }
                break;
            }

                
            default:
                break;
        }
        
        return self.cell;
    }

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
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



//拖动是退出键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark====设置textField的代理事件的处理并传值

//保存用户输入的信息
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    self.textArr[textField.tag] = textField.text;
    
    switch (textField.tag) {
        case carid:
            self.carModel.carid = textField.text;
            break;
        case brand:
            self.carModel.brand = textField.text;
            break;
        case model:
            self.carModel.model = textField.text;
            break;
        case cartype:
            self.carModel.cartype = textField.text;
            break;
        case frameid:
            self.carModel.frameid = textField.text;
            break;
        case engineid:
            self.carModel.engineid = textField.text;
            break;
        case insuranceid:
            self.carModel.insuranceid = textField.text;
            break;
            
        default:
            break;
    }
}
/**
 *  当输入框的文字发生改变的时候调用，弹出时间选择器--下面为了防止UItextfield弹出键盘
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == buytime || textField.tag == insurancetime || textField.tag == commercialtime)
    {
        if (![textField.text isEqualToString:@"请选择日期"])
        {
            textField.inputView=self.insuranceidData;
            self.checkinCar = textField.tag;
            textField.text = @"请选择日期";
        }
        else
        {
            if (textField.tag == buytime)
            {
                textField.text = self.buytime;
            }
            else if (textField.tag == insurancetime)
            {
                textField.text = self.insuranceid;
            }
            else
            {
                textField.text = self.commercialtime;
            }
        }
    }else
    {
        [self.insuranceidData removeFromSuperview];
    }
    return YES;
}



@end
