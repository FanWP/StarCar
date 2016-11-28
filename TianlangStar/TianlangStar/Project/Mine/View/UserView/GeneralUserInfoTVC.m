//
//  generalUserInfoTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/15.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "GeneralUserInfoTVC.h"
#import "InputCell.h"
#import "UserModel.h"
#import "UserHeaderImageCell.h"
#import "CarModel.h"
#import "AddCarTableVC.h"
#import "CheckCarInfoTVC.h"

@interface GeneralUserInfoTVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AddCarTableVCDlelegate>

/** 单元格的数组 */
@property (nonatomic,strong) NSArray *leftArr;

/** 用户类型的枚举 */
@property (nonatomic,assign) UserInfoType userInfoType;

/** 头像 */
@property (nonatomic,strong) UIImage *headerImg;


/** 获取服务器返回的当前用户对应的所有车辆信息 */
@property (nonatomic,strong) NSArray *carInfoArr;



/** 标记输入框是否可用 */
@property (nonatomic,assign) BOOL inputEnble;

/** 遮盖 */
@property (nonatomic,weak) UIView *coverView;

/** 性别选择器的容器 */
@property (nonatomic,weak) UIView *contentView;


/** 性别选中 */
@property (nonatomic,strong) UIButton *seletedSexButton;


/** 用户模型数据 */
@property (nonatomic,strong) UserModel *userModel;


@end

@implementation GeneralUserInfoTVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inputEnble = NO;
    
    self.title =@"会员管理";
    
    YYLog(@"userModel----%@",self.userModel);
    [self loadUserInfo];
    
    [self setupControl];
    
    [self addRightBar];
    
    /** 获取当前用户名下对应的车辆 */
    [self setupCarInfoData];
    
    
}


/** 获取当前用户名下对应的车辆 */
-(void)setupCarInfoData
{
    
    /*getusercarinfoservlet*/
    NSString *url = [NSString stringWithFormat:@"%@getallcarinfoservlet",URL];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"id"] = self.userModel.ID;
    YYLog(@"parmas----%@",parmas);
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"获取车辆----%@",json);
         self.carInfoArr = [CarModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         [self.tableView reloadData];
         
     } failure:^(NSError *error)
     {
         YYLog(@"error---%@",error);
     }];
}



//获取用户的数据信息
#pragma mark---------初始化数据===============
-(void)loadUserInfo
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    parmas[@"sessionId"] = userInfo.RSAsessionId;
    //    parmas[@"userid"] = userInfo.userID;
    
    NSString *url = [NSString stringWithFormat:@"%@getuserinfoserlvet",URL];
    
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         self.userModel = [UserModel mj_objectWithKeyValues:json[@"obj"]];
         YYLog(@"%@",json);
         
         [self.tableView reloadData];
         
     } failure:^(NSError *error)
     {
         YYLog(@"%@",error);
     }];
}



-(void)setupControl
{
    //设置遮盖
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 1024)];
    cover.backgroundColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:0.5];
    self.coverView = cover;
    self.coverView.hidden = YES;
    [self.view addSubview:self.coverView];
    
    /** 用户类型弹出框容器 */
    UIView *contentView = [[UIView alloc] init];
    contentView.height = 200;
    contentView.width = KScreenWidth * 0.8;
    contentView.centerX = KScreenWidth * 0.5;
    contentView.centerY = KScreenHeight * 0.45;
    contentView.backgroundColor = [UIColor whiteColor] ;
    self.contentView = contentView;
    contentView.hidden = YES;
    [self.view addSubview:contentView];
    
    //给弹出框添加子控件
    //性别标题
    UILabel *sexLable = [[UILabel alloc] init];
    sexLable.text = @"性别";
    sexLable.font = [UIFont systemFontOfSize:18];
    //    sexLable.backgroundColor = [UIColor orangeColor];
    sexLable.x = KScreenWidth *0.22;
    sexLable.y = 20;
    sexLable.width = 90;
    sexLable.height = 30;
    [self.contentView addSubview: sexLable];
    
    //男——>按钮
    UIButton *manBtn = [[UIButton alloc] init];
    [manBtn setTitle:@"男" forState:UIControlStateNormal];
    manBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    manBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
    manBtn.tag = 1;
    [manBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [manBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [manBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    manBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [manBtn addTarget:self action:@selector(manClick:) forControlEvents:(UIControlEventTouchUpInside)];
    manBtn.x = sexLable.x - 15;
    manBtn.y = 70;
    manBtn.width = 160;
    manBtn.height = 30;
    [self.contentView addSubview:manBtn];
    
    
    
    
    //女——>按钮
    UIButton *womanBtn = [[UIButton alloc] init];
    [womanBtn setTitle:@"女" forState:UIControlStateNormal];
    womanBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    womanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
    womanBtn.tag = 2;
    [womanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [womanBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [womanBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    womanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [womanBtn addTarget:self action:@selector(manClick:) forControlEvents:UIControlEventTouchUpInside];
    womanBtn.x = sexLable.x - 15;
    womanBtn.y = 105;
    womanBtn.width = 160;
    womanBtn.height = 30;
    [self.contentView addSubview:womanBtn];
    
    
    //判断并选中默认的性别按钮
    //默认性别为男--->1   女---->2
    if (self.userModel.sex == 1)
    {
        self.seletedSexButton = manBtn;
    }else if(self.userModel.sex == 2)
    {
        self.seletedSexButton = womanBtn;
    }
    self.seletedSexButton.selected = YES;
}


//性别选中的按钮的单击事件
-(void)manClick:(UIButton *)button
{
    self.seletedSexButton.selected = NO;
    button.selected = !button.selected;
    self.coverView.hidden = YES;
    self.contentView.hidden = YES;
    //设置并保存用户设置
    self.userModel.sex = button.tag;
    self.seletedSexButton = button;
    self.tableView.tableFooterView.hidden = NO;
    [self.tableView reloadData];
    //    [self sendAFN];
}


-(void)addRightBar
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"完成" forState:UIControlStateSelected];
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



-(NSArray *)leftArr
{
    if (!_leftArr)
    {
        _leftArr = @[@"姓名",@"性别",@"手机号",@"身份证",@"住址",@"级别",@"推荐人",@"备注"];
    }
    return _leftArr;
}








#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 1;
    
    switch (section)
    {
        case 0:
            count = 1;
            break;
        case 1:
            count = self.leftArr.count;;
            break;
        case 2:
            count = self.carInfoArr.count + 1;
            break;
            
        default:
            break;
    }
    
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UserHeaderImageCell *cell = [[UserHeaderImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.leftLable.text = @"头像";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //设置头像
        if (self.headerImg)
        {
            cell.headerPic.image = self.headerImg;
        }else
        {
            [cell.headerPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,self.userModel.headimage]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        }
        return cell;
        
    }else if (indexPath.section == 1)
    {
        
        InputCell *cell = [InputCell cellWithTableView:tableView];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.textField.delegate = self;
        cell.textField.x  = 100;
        cell.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.leftArr[indexPath.row]];
        self.userInfoType = indexPath.row;
        cell.textField.tag = self.userInfoType;
        cell.textField.enabled = self.inputEnble;
        cell.textField.textAlignment = NSTextAlignmentRight;
        
        //设置数据
        switch (self.userInfoType)
        {
            case membername://姓名
                cell.textField.text = self.userModel.membername;
                break;
            case telephone://手机号
            {
                cell.textField.text = self.userModel.username;
                cell.textField.enabled = NO;
                break;
            }
            case sex://性别
            {
                NSString *sexstr = nil;
                self.userModel.sex == 1 ? (sexstr = @"男") : (sexstr = @"女");
                cell.textField.text = sexstr;
                break;
            }
            case identity://身份证
                cell.textField.text = self.userModel.identity;
                break;
            case address://地址
                cell.textField.text = self.userModel.address;
                break;
            case viplevel://级别
            {
                NSString *vip = [NSString VIPis:self.userModel.viplevel];
                cell.textField.text = vip;
                cell.textField.enabled = NO;
                break;
            }
            case referee://推荐人
                cell.textField.text = self.userModel.referee;
                break;
            case description://备注
                cell.textField.text = self.userModel.describe;
                break;
                
                
            default:
                break;
        }
        
        return cell;
    }else//车辆信息
    {
        InputCell *cell = [InputCell cellWithTableView:tableView];
        cell.leftLB.text = @"他的爱车";
        cell.textField.x  = 100;
        cell.textField.width = KScreenWidth - CGRectGetMaxX(cell.leftLB.frame) - 20;
        cell.textField.enabled = NO;
        cell.textField.textAlignment = NSTextAlignmentRight;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == self.carInfoArr.count)
        {
            cell.leftLB.text = @"添加爱车";
        }else
        {
            CarModel *model = self.carInfoArr[indexPath.row];
            cell.textField.text = model.carid;
        }
        return cell;
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0)
    {
        return 100;
    }else
    {
        return 40;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //车辆
    if (indexPath.section == 2)
    {
        if (indexPath.row == self.carInfoArr.count)//添加爱车
        {
            AddCarTableVC *vc = [[AddCarTableVC alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else{//他的爱车
            
            CarModel *Model = self.carInfoArr[indexPath.row];
            CheckCarInfoTVC *vc = [[CheckCarInfoTVC alloc] initWithStyle:UITableViewStyleGrouped];
            vc.carModel = Model;
            vc.accountMTVC = self;
            [self.navigationController pushViewController:vc
                                                 animated:YES];
        }
    }

    
    if (!self.inputEnble) return;
    
    if (indexPath.section == 0)
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



#pragma mark======提交发送请求========
/**
 *  修改账户信息
 */
-(void)updataUserInfo
{
    
    
    //判断输入数据是否正确
    
    if (![self.userModel.identity isIdentityCardNo])
    {
        [[AlertView sharedAlertView] addAlertMessage:@"身份证输入有误，请核对" title:@"提示"];
        return;
    }
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    
    parmas[@"membername"] = self.userModel.membername;
    parmas[@"sex"] = @(self.userModel.sex);
    parmas[@"username"] = self.userModel.telephone;
    parmas[@"identity"] = self.userModel.identity;
    parmas[@"address"] = self.userModel.address;
    parmas[@"referee"] = self.userModel.referee;
    parmas[@"description"] = self.userModel.describe;
    
    YYLog(@"parmas------%@",parmas);
    
    if (self.headerImg)
    {
        parmas[@"oldheaderpic"] = self.userModel.headimage;
        NSString *url = [NSString stringWithFormat:@"%@upload/updateowninfoforheadservlet",URL];
        YYLog(@"parmas----%@",parmas);
        
        [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
             NSData *data = UIImageJPEGRepresentation(self.headerImg, 0.5);
             //拼接data
             [formData appendPartWithFileData:data name:@"headimage" fileName:@"img.jpg" mimeType:@"image/jpeg"];
             
         } progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             
             YYLog(@"responseObject---%@",responseObject);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             YYLog(@"error---%@",error);
         }];
    }
    else
    {
        NSString *url = [NSString stringWithFormat:@"%@updateowninfoservlet",URL];
        [HttpTool post:url parmas:parmas success:^(id json)
         {
             YYLog(@"json---%@",json);
         } failure:^(NSError *error)
         {
             YYLog(@"error--%@",error);
         }];
    }
}





#pragma mark=====textField 的代理时间的处理=====

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case membername:
            self.userModel.membername = textField.text;
            break;
//        case telephone:
//            self.userModel.membername = textField.text;
//            break;
        case identity:
            self.userModel.identity = textField.text;
            break;
        case address:
            self.userModel.address = textField.text;
            break;
        case referee:
            self.userModel.referee = textField.text;
            break;
        case description:
            self.userModel.describe = textField.text;
            break;
        default:
            break;
    }
}


//设置性别的输入框选择事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == sex)
    {
        self.coverView.hidden = NO;
        self.contentView.hidden = NO;
        self.tableView.tableFooterView.hidden = YES;
        return;
    }
}



#pragma mark-=========添加车辆信息成功后调用代理====
-(void)addCarInfoSuccess
{
    [self loadUserInfo];
}



    


@end
