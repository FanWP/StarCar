//
//  CarInfoChangeVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CarInfoChangeVC.h"
#import "CarInputCell.h"
#import "CarModel.h"

#import "PictureCell.h"


@interface CarInfoChangeVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


/** 单元格左侧的描述 */
@property (nonatomic,strong) NSArray *rightArr;

/** 提交按钮 */
@property (nonatomic,strong) UIButton *handButton;

/** 较强险提醒日期 --时间戳 */
@property (nonatomic,strong) UIDatePicker *insuranceidData;

/** 商业险提醒日期 --时间戳*/
@property (nonatomic,strong) UIDatePicker *commercialtimeData;

///** 车辆的购买日期日期 */
//@property (nonatomic,copy) NSString *buytime;
//
///** 较强险的提醒日期 */
//@property (nonatomic,copy) NSString *insuranceid;
///** 较强险的提醒日期 */
//@property (nonatomic,copy) NSString *commercialtime;


/** 记录输入框的内容 */
@property (nonatomic,strong) NSMutableArray *textArr;


/** 记录用户年月入日期选择器 */
@property (nonatomic,assign) CarInfo selectData;

@property (nonatomic,strong) UIImage *carImage;


@end

@implementation CarInfoChangeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"车辆信息修改";

    [self addFooter];
    [self addDatePIcker];
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
    NSString * time=[outputFormatter stringFromDate:self.insuranceidData.date];
    //更改输入框的数据
//    self.textArr[_selectData] = time;
    [self.textArr replaceObjectAtIndex:_selectData withObject:time];
    
    //记录数据
    switch (self.selectData)
    {
        case buytime://购买日期
        {
            self.carInfo.buytime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
        case insurancetime://较强险
        {
            self.carInfo.insurancetime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
        case commercialtime://商业险
        {
            self.carInfo.commercialtime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
            
        default:
            break;
    }

    //回到主线程刷新数据，刷新对应的单元格
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        [self.tableView reloadData];
        //单个单元格刷新
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.selectData inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:(UITableViewRowAnimationNone)];
    });
}



-(NSMutableArray *)textArr
{
    if (!_textArr)
    {
        //购买时间
        NSString *buytime = [self.carInfo.insurancetime getTime];
        //较强险
        NSString *insurancetime = [self.carInfo.insurancetime getTime];
        //商业险
        NSString *commercialtime = [self.carInfo.commercialtime getTime];
        
        NSArray *arr = @[self.carInfo.carid,self.carInfo.brand,self.carInfo.model,self.carInfo.cartype,self.carInfo.frameid,self.carInfo.engineid,buytime,self.carInfo.insuranceid,insurancetime,commercialtime];
        _textArr = [NSMutableArray arrayWithArray:arr];
    }
    return _textArr;
}



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
    UIView *handView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,KScreenWidth, 84)];
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
    
    [handView addSubview:self.handButton];
    self.tableView.tableFooterView = handView;
}



- (void)handAction:(UIButton *)button
{
    [self.view endEditing:YES];
    
    if (self.carInfo.carid == nil        || self.carInfo.carid.length == 0   ||
        self.carInfo.brand == nil        || self.carInfo.brand.length == 0   ||
        self.carInfo.model == nil        || self.carInfo.model.length == 0   ||
        self.carInfo.cartype == nil      || self.carInfo.cartype.length == 0 ||
        self.carInfo.frameid == nil      || self.carInfo.frameid.length == 0 ||
        self.carInfo.engineid == nil     || self.carInfo.engineid.length == 0   ||
        self.carInfo.buytime == nil      || self.carInfo.buytime.length == 0   ||
        self.carInfo.insuranceid == nil  || self.carInfo.insuranceid.length == 0 ||
        self.carInfo.insurancetime == nil || self.carInfo.insurancetime.length == 0||
        self.carInfo.commercialtime == nil || self.carInfo.commercialtime.length == 0
        )
    {
        [[AlertView sharedAlertView] addAlertMessage:@"输入框有空，请核对" title:@"提示"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    params[@"id"] = self.carInfo.ID;
    params[@"userid"] = [UserInfo sharedUserInfo].userID;
    params[@"carid"] = self.carInfo.carid;
    params[@"brand"] = self.carInfo.brand;
    params[@"model"] = self.carInfo.model;
    params[@"cartype"] = self.carInfo.cartype;
    params[@"frameid"] = self.carInfo.frameid;
    params[@"engineid"] = self.carInfo.engineid;
    params[@"buytime"] = self.carInfo.buytime;
    params[@"insuranceid"] = self.carInfo.insuranceid;
    params[@"insurancetime"] = self.carInfo.insurancetime;
    params[@"commercialtime"] = self.carInfo.commercialtime;
    
    
    NSString *url = [NSString stringWithFormat:@"%@upload/updatecarinfoservlet",URL];
    YYLog(@"params----%@",params);
    
    [[AFHTTPSessionManager manager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        NSString *oldheaderpic = nil;
        
        if (self.carInfo.picture.length != 0 || self.carInfo.picture != nil)
        {
            NSRange range = [self.carInfo.picture rangeOfString:@"picture"];
            
            if (range.length != 0)
            {
                oldheaderpic = [self.carInfo.picture substringFromIndex:range.location];
            }
        }
        
        YYLog(@"oldheaderpic===%@",oldheaderpic);
        
        params[@"oldheaderpic"] = oldheaderpic;
        
        NSData *data = UIImageJPEGRepresentation(self.carImage, 0.5);
        
        if (data != nil)
        {
            [formData appendPartWithFileData:data name:@"picture" fileName:@"img.jpg" mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"修改车辆信息返回：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"修改车辆信息错误：%@",error);
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
        return self.rightArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 0.3 * KScreenHeight + 2 * Klength5;
    }
    else
    {
        return 40;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *identifier = @"cell";
        
        PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[PictureCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        
        if (self.carImage)
        {
            cell.pictureView.image = self.carImage;
        }
        else
        {
            NSString *pic = [NSString stringWithFormat:@"%@",self.carInfo.picture];
            [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:pic]];
        }
        
        return cell;
    }
    else
    {
        CarInputCell *cell = [CarInputCell cellWithTableView:tableView];
        
        NSString *name = self.rightArr[indexPath.row];
        NSString *nameInput = self.textArr[indexPath.row];
        cell.textField.text = nameInput;
        
        cell.textLabel.text = name;
        
        self.selectData = indexPath.row;
        cell.textField.tag = self.selectData;
        cell.textField.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
        
        return cell;
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
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [self.tableView reloadData];
    });
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}



#pragma mark====设置textField的代理事件的处理并传值

//保存用户输入的信息
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == buytime || textField.tag == insurancetime || textField.tag == commercialtime) return;
        self.textArr[textField.tag] = textField.text;
    
    switch (textField.tag) {
        case carid:
            self.carInfo.carid = textField.text;
            break;
        case brand:
            self.carInfo.brand = textField.text;
            break;
        case model:
            self.carInfo.model = textField.text;
            break;
        case cartype:
            self.carInfo.cartype = textField.text;
            break;
        case frameid:
            self.carInfo.frameid = textField.text;
            break;
        case engineid:
            self.carInfo.engineid = textField.text;
            break;
        case insuranceid:
            self.carInfo.insuranceid = textField.text;
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
            self.selectData = textField.tag;
            textField.text = @"请选择日期";
        }
        else
        {
//            if (textField.tag == buytime)
//            {
//                textField.text = self.buytime;
//            }
//            else if (textField.tag == insurancetime)
//            {
//                textField.text = self.insuranceid;
//            }
//            else
//            {
//                textField.text = self.commercialtime;
//            }
        }
    }else
    {
        [self.insuranceidData removeFromSuperview];
    }
    return YES;
}



@end
