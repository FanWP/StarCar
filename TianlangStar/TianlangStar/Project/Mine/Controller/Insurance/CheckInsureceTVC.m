//
//  CheckInsureceTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/17.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CheckInsureceTVC.h"
#import "InsuranceModel.h"
#import "UserHeaderImageCell.h"
#import "InputCell.h"
#import "PictureCell.h"
typedef enum : NSUInteger {
    expenses = 0,
    payment,
    buytime,
    policyid,
    continuetime
} InsuranceType;

@interface CheckInsureceTVC ()<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 左侧的数组信息 */
@property (nonatomic,strong) NSArray *leftArr;


/** 标记输入框是否可用 */
@property (nonatomic,assign) BOOL inputEnble;

/** 保险的图片信息 */
@property (nonatomic,strong) UIImage *headerImg;



/** 保险的枚举类型 */
@property (nonatomic,assign) InsuranceType selectedData;


/** 时间选择器 */
@property (nonatomic,strong) UIDatePicker *insuranceidData;

/** 险种的类型 */
@property (nonatomic,assign) NSInteger insuranceType;


@end

@implementation CheckInsureceTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.inputEnble = NO;
    
    [self addDatePIcker];
    
    [self addRightBar];
    
}

-(NSArray *)leftArr
{
    if (!_leftArr) {
        _leftArr = @[@"险种",@"投保公司",@"投保日期",@"投保单号",@"续保日期"];
    }
    return _leftArr;
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
    
    //计算当前时间
    //    NSDate *nowdate = [NSDate date];
    //    //    限制起始时间为当前时间
    //    self.insuranceidData.maximumDate = nowdate;
    [self.insuranceidData addTarget:self action:@selector(selecStarttDate) forControlEvents:UIControlEventValueChanged];
}


/** 时间选择器的点击事件--较强险提醒日期 */
-(void)selecStarttDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * time=[outputFormatter stringFromDate:self.insuranceidData.date];
    //    //更改输入框的数据
    //    //    self.textArr[_selectData] = time;
    //    [self.textArr replaceObjectAtIndex:_selectData withObject:time];
    
    //记录数据
    switch (self.selectedData)
    {
        case buytime://投保日期
        {
            self.insuranceModel.buytime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
        case continuetime://续保日期
        {
            self.insuranceModel.continuetime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
            
            
        default:
            break;
    }
    
    //回到主线程刷新数据，刷新对应的单元格
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
    });
}


-(void)addRightBar
{
    //只有管理员有权限
    if ([UserInfo sharedUserInfo].userType == 2) return;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"保存" forState:UIControlStateSelected];
    [button addTarget:self action:@selector(rightBarClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)rightBarClick:(UIButton *)button
{
    [self.view endEditing:YES];
    
    self.inputEnble = !button.selected;
    
    button.selected = !button.selected;
    
    //刷新数据
    [self.tableView reloadData];
    
    if (self.inputEnble == NO)//是显示完成
    {
        [self updataUserInfo];
    }
}

-(void)updataUserInfo
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    parmas[@"sessionId"] = userInfo.RSAsessionId;
    parmas[@"id"] = self.insuranceModel.ID;
    parmas[@"company"] = self.insuranceModel.company;
    parmas[@"buytime"] = self.insuranceModel.buytime;
    parmas[@"policyid"] = self.insuranceModel.policyid;
    parmas[@"continuetime"] = self.insuranceModel.continuetime;
    parmas[@"expenses"] = self.insuranceModel.expenses;
    
    YYLog(@"parmas---更新数据%@",parmas);
    NSString *url = [NSString stringWithFormat:@"%@upload/updateadmininsuranceservlet",URL];
    
    [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         NSData *data = UIImageJPEGRepresentation(self.headerImg, 0.5);
         
         if (data != nil)
         {
             parmas[@"oldheaderpic"] = self.insuranceModel.images;
             [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
         }
         
     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"修改保险信息返回返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             //             [[AlertView sharedAlertView] addAfterAlertMessage:@"添加爱车成功" title:@"提示"];
             [SVProgressHUD showSuccessWithStatus:@"修改成功"];
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"修改保险错误：%@",error);
     }];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger count = 1;
    
    if (section == 1)
    {
        count = self.leftArr.count;
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        PictureCell *cell = [[PictureCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
        
        if (self.headerImg)
        {
            cell.pictureView.image = self.headerImg;
        }
        else
        {
            [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,self.insuranceModel.images]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        }
        return cell;
    }else
    {
        InputCell *cell = [InputCell cellWithTableView:tableView];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.leftLB.width = 100;
        cell.textField.x = KScreenWidth * 0.25;
        self.selectedData = indexPath.row;
        cell.textField.tag = self.selectedData;
        cell.textField.delegate = self;
        cell.textField.textAlignment = NSTextAlignmentRight;
        cell.textField.enabled = self.inputEnble;
        //设置数据
        switch (self.selectedData)
        {
            case expenses:
                cell.leftLB.text = self.insuranceModel.insurancetype;
                cell.textField.text = self.insuranceModel.expenses;
                
                break;
            case payment:
                cell.textField.text = self.insuranceModel.company;
                break;
            case buytime:
            {
                cell.textField.text = [self.insuranceModel.buytime getTime];
                break;
            }
            case policyid:
                cell.textField.text = self.insuranceModel.policyid;
                break;
            case continuetime:
                cell.textField.text = [self.insuranceModel.continuetime getTime];
                break;
            default:
                break;
        }
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 220;
    }else
    {
        return 40;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.inputEnble )
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              [self getPhotoLibraryImage];
                          }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              [self getCameraImage];
                          }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                          {
                              YYLog(@"取消");
                          }]];
        [self presentViewController:alert animated:YES completion:nil];

        
    }

}


#pragma mark========UIImagePickerController的代理方法=====
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
    self.headerImg = image;
    YYLog(@"self.headerImg--%@",self.headerImg);
    
    //    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.tableView reloadData];
    }];
}




#pragma mark=========taxtField 的代理方法=================
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    switch (textField.tag)
    {
        case expenses:
            self.insuranceModel.expenses = textField.text;
            break;
            
        case payment:
            self.insuranceModel.payment = textField.text;
            break;
        case policyid:
            self.insuranceModel.policyid = textField.text;
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
    if (textField.tag == buytime || textField.tag ==continuetime )
    {
        textField.inputView=self.insuranceidData;
        self.selectedData = textField.tag;
        textField.placeholder = @"请选择日期";
    }else
    {
        [self.insuranceidData removeFromSuperview];
    }
    return YES;
}






@end
