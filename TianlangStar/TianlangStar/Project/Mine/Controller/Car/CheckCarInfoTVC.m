//
//  CheckCarInfoTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/17.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CheckCarInfoTVC.h"
#import "PictureCell.h"
#import "LabelTextFieldCell.h"
#import "CarModel.h"
#import "BossInsuranceManagement.h"
#import "UserInsurecemangement.h"

/** 车辆信息录入和添加 */
typedef enum : NSUInteger {
    cartype = 0,
    brand,
    model,
    carid,
    buytime,
    frameid,
    engineid
} CarInfoType;

@interface CheckCarInfoTVC ()<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>


/** 左边的标题栏 */
@property (nonatomic,strong) NSArray *leftLabelArray;

/** 站位数组 */
@property (nonatomic,strong) NSArray *rightPlaceholder;

/** 上传的图片 */
@property (nonatomic,strong) UIImage *carImage;

/** 枚举 */
@property (nonatomic,assign) CarInfoType carInfoType;


/** 设置用户是否可以编辑 */
@property (nonatomic,assign) BOOL inputEnble;

/** 日期选择器 */
@property (nonatomic,strong) UIDatePicker *buytimeData;

/** 右上角的保存和点按钮 */
@property (nonatomic,strong) UIButton *rightBarBtn;


/** 遮盖 */
@property (nonatomic,weak) UIView *coverView;


@end

@implementation CheckCarInfoTVC

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    [self addRightBar];
    
    [self addDatePIcker];
    
    [self addCoverView];
    
    self.title = @"他的爱车";

}


-(void)addCoverView
{
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 800)];
    cover.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth -90, 0, 80, 80)];
    rightView.backgroundColor = [UIColor whiteColor];
    [cover addSubview:rightView];
    
    UIButton *modificationBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
    [modificationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [modificationBtn setTitle:@"修改" forState:UIControlStateNormal ];
    [modificationBtn addTarget:self action:@selector(modificationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:modificationBtn];
    
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 50)];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal ];
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
     [rightView addSubview:deleteBtn];
    
    self.coverView = cover;
    UIGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch)];
    [cover addGestureRecognizer:touch];
    
    [self.view addSubview:cover];
    cover.hidden = YES;
}

//点击蒙版消除
-(void)touch
{
    self.coverView.hidden = YES;
}



#pragma mark===== 修改，删除按钮的点击事件=======
//修改按钮的点击事件
-(void)modificationBtnClick
{
    self.inputEnble = YES;
    self.rightBarBtn.selected = YES;

    //刷新数据
    [self.tableView reloadData];
    
    self.coverView.hidden = YES;
}

//修改按钮的点击事件---删除车辆
-(void)deleteBtnClick
{
    self.coverView.hidden = YES;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认删除爱车？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
        parmas[@"id"] = self.carModel.ID;
        
        
        NSString *oldheaderpic = nil;
        //传入为空的话
        if (self.carModel.picture.length != 0 || self.carModel.picture != nil)
        {
            NSRange rangge = [self.carModel.picture rangeOfString:@"picture"];
            
            if (rangge.length !=0)
            {
                oldheaderpic = [self.carModel.picture substringFromIndex:rangge.location];
            }
        };
        parmas[@"oldheaderpic"] = oldheaderpic;

        YYLog(@"parmas--删除车辆%@",parmas);
        
        NSString *url = [NSString stringWithFormat:@"%@deletecarinfoservlet",URL];
        
        [HttpTool post:url parmas:parmas success:^(id json) {
            YYLog(@"%@",json);
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            
            //刷新数据
            [self.accountMTVC setupCarInfoData];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            YYLog(@"%@",error);
        }];

        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)addRightBar
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    self.rightBarBtn = button;
    [button setTitle:@"..." forState:UIControlStateNormal];
    [button setTitle:@"保存" forState:UIControlStateSelected];
    [button addTarget:self action:@selector(rightBarClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)rightBarClick:(UIButton *)button
{
    [self.view endEditing:YES];
    if (button.selected)//是显示完成
    {
        self.rightBarBtn.selected = NO;
        [self updataUserInfo];
    }else
    {
        self.coverView.hidden = NO;
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
    self.buytimeData = startDatePicker;
    self.buytimeData.hidden = NO;
    
    //计算当前时间
    NSDate *nowdate = [NSDate date];
    //限制起始时间为当前时间
    self.buytimeData.maximumDate = nowdate;
    
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




- (NSArray *)leftLabelArray
{
    if (!_leftLabelArray)
    {
        _leftLabelArray = @[@"车辆类型",@"品牌",@"型号",@"车牌号",@"购买年份",@"车架号",@"发动机号"];
    }
    
    return _leftLabelArray;
}



- (NSArray *)rightPlaceholder
{
    if (!_rightPlaceholder)
    {
        _rightPlaceholder = @[@"请输入车辆类型",@"请输入品牌",@"型号",@"请输入车牌号",@"请输入购买年份",@"请输入车架号",@"请输入发动机号码"];
    }
    
    return _rightPlaceholder;
}


#pragma mark=====更新数据请求=======================
//更新数据的请求
-(void)updataUserInfo
{
    [self.view endEditing:YES];
    
    NSString *url = [NSString stringWithFormat:@"%@upload/updatecarinfoservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"id"] = self.carModel.ID;
    parameters[@"userid"] = self.carModel.userid;
    parameters[@"carid"] = self.carModel.carid;
    parameters[@"brand"] = self.carModel.brand;
    parameters[@"model"] = self.carModel.model;
    parameters[@"cartype"] = self.carModel.cartype;
    parameters[@"frameid"] = self.carModel.frameid;
    parameters[@"engineid"] = self.carModel.engineid;
    parameters[@"buytime"] = self.carModel.buytime;
    
    YYLog(@"修改爱车的参数%@",parameters);
    
    /*
     String sessionId 用户登录标记
     String id 车辆信息的标识
     String userid 用户身份
     String carid 车牌号
     String brand 品牌
     String model 型号
     String cartype 车型
     String usertype 使用性质（客运、货运等）
     String frameid 车架号
     String engineid 发动机号
     Long buytime 购买时间
     String picture车辆照片
     Double travelmileage 行驶里程（公里）
     String insuranceid 保险信息
     Long insurancetime 交强险到期提醒
     Long commercialtime 商业险到期提醒

     */
    
//    if (self.carModel.cartype == nil || self.carModel.brand == nil || self.carModel.model == nil || self.carModel.carid == nil || self.carModel.buytime == nil || self.carModel.frameid == nil || self.carModel.engineid == nil)
//        {
//            [[AlertView sharedAlertView] addAfterAlertMessage:@"请完整填写车辆信息" title:@"提示"];
//            return;
//        }
    
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         NSData *data = UIImageJPEGRepresentation(self.carImage, 0.5);
         
         if (data != nil)
         {
             NSString *oldheaderpic = nil;
             //传入为空的话
             if (self.carModel.picture.length != 0 || self.carModel.picture != nil)
             {
                 NSRange rangge = [self.carModel.picture rangeOfString:@"picture"];
                 
                 if (rangge.length !=0)
                 {
                     oldheaderpic = [self.carModel.picture substringFromIndex:rangge.location];
                 }
                 parameters[@"oldheaderpic"] = oldheaderpic;
             }
             
             [formData appendPartWithFileData:data name:@"picture" fileName:@"img.jpg" mimeType:@"image/jpeg"];
         }
         
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"修改爱车返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             [SVProgressHUD showSuccessWithStatus:@"修改成功！"];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"添加爱车错误：%@",error);
     }];
    
    
    YYLog(@"parameters----%@",parameters);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 2)
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

        if (indexPath.section == 0)
        {
            return 0.3 * KScreenHeight + 2 * Klength5;
        }else
        {
 
    return 40;
        }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *identifier0 = @"cell0";
        
        PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if (cell == nil)
        {
            cell = [[PictureCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier0];
        }
        if (self.carImage)
        {
            cell.pictureView.image = self.carImage;
        }
        else
        {
            [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:self.carModel.picture] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        }
        return cell;
    }else if (indexPath.section == 1)
    {
        static NSString *identifier1 = @"cell1";
        
        LabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        if (cell == nil)
        {
            cell = [[LabelTextFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
        }
        
        cell.leftLabel.text = _leftLabelArray[indexPath.row];
        cell.rightTF.placeholder = _rightPlaceholder[indexPath.row];
        cell.rightTF.delegate = self;
        
        self.carInfoType = indexPath.row;
        cell.rightTF.tag = self.carInfoType;
        cell.rightTF.textAlignment = NSTextAlignmentRight;
        
        
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
                cell.rightTF.text = [self.carModel.buytime getTime];
                break;
            case frameid:
                cell.rightTF.text = self.carModel.frameid;
                break;
            case engineid:
                cell.rightTF.text = self.carModel.engineid;
                break;
                
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightTF.enabled = self.inputEnble;
        return cell;
    }else//保单管理
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"保单管理";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    }




#pragma mark=====textField 的代理事件处理=============
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == buytime)
    {
        textField.inputView = self.buytimeData;
        self.carInfoType = textField.tag;
        textField.text = @"请选择日期";
    }
    else
    {
        [self.buytimeData removeFromSuperview];
    }
    
    return YES;
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
//        case buytime:
//            self.carModel.buytime = textField.text;
//            break;
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (!self.inputEnble) return;
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
    
    if (indexPath.section == 2)
    {
        UserInfo *userInfo = [UserInfo sharedUserInfo];
        if (userInfo.userType == 1 || userInfo.userType == 0)
        {
            BossInsuranceManagement *vc = [[BossInsuranceManagement alloc] initWithStyle:UITableViewStyleGrouped];
            vc.carID = self.carModel.cid;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            UserInsurecemangement *vc = [[UserInsurecemangement alloc] initWithStyle:UITableViewStyleGrouped];
            vc.carID = self.carModel.ID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
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
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    [self.tableView reloadData];
    //    });
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


