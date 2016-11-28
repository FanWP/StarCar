//
//  AdminInfoTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/15.
//  Copyright © 2016年 yysj. All rights reserved.
//
#import "UserHeaderImageCell.h"
#import "AdminInfoTVC.h"
#import "UserModel.h"
#import "InputCell.h"



@interface AdminInfoTVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 左边的lable */
@property (nonatomic,strong) NSArray *leftArr;

/** 头像 */
@property (nonatomic,strong) UIImage *headerImg;

/** 接收到的用户信息 */
@property (nonatomic,strong) UserModel *userModel;


/** 用户类型选中的枚举 */
@property (nonatomic,assign) UserInfoType userInfoType;

/** 标记输入框是否可用 */
@property (nonatomic,assign) BOOL inputEnble;

/** 遮盖 */
@property (nonatomic,weak) UIView *coverView;

/** 性别选择器的容器 */
@property (nonatomic,weak) UIView *contentView;


/** 性别选中 */
@property (nonatomic,strong) UIButton *seletedSexButton;

@end

@implementation AdminInfoTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.inputEnble = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self loadUserInfo];
    
    [self setupControl];
    
    [self addRightBar];
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
}


-(void)addRightBar
{
    
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


#pragma mark=====更新数据请求=======================
//更新数据的请求
-(void)updataUserInfo
{
    //手机号
    if (![self.userModel.username isMobileNumber])
    {
        [[AlertView sharedAlertView] addAlertMessage:@"手机号输入有误，请核对！" title:@"提示"];
        return;
    }
    
    //身份证
    if (![self.userModel.identity isIdentityCardNo])
    {
        [[AlertView sharedAlertView] addAlertMessage:@"身份证号输入有误，请核对！" title:@"提示"];
        return;
    }
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    
    parmas[@"membername"] = self.userModel.membername;
    parmas[@"sex"] = @(self.userModel.sex);
    parmas[@"username"] = self.userModel.telephone;
    parmas[@"identity"] = self.userModel.identity;
    parmas[@"address"] = self.userModel.address;
    
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
             
         } progress:^(NSProgress * _Nonnull uploadProgress)
        {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
        {
             YYLog(@"responseObject---%@",responseObject);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             YYLog(@"error---%@",error);
         }];
    }
    else
    {
//        NSString *url = [NSString stringWithFormat:@"%@updateowninfoservlet",URL];
        
        NSString *url = [NSString stringWithFormat:@"%@upload/updateuserinfoservlet",URL];
        [HttpTool post:url parmas:parmas success:^(id json)
         {
            YYLog(@"json---%@",json);
        } failure:^(NSError *error)
        {
            YYLog(@"error--%@",error);
        }];
    }
    
}


-(UserModel *)userModel
{
    if (!_userModel)
    {
        _userModel = [[UserModel alloc] init];
    }
    return _userModel;
}

//获取用户的数据信息
#pragma mark======获取当前用户数据===================
-(void)loadUserInfo
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    parmas[@"sessionId"] = userInfo.RSAsessionId;
    
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


-(NSArray *)leftArr
{
    if (!_leftArr)
    {
        _leftArr = @[@"姓名",@"性别",@"手机号",@"身份证",@"住址"];
    }
    return _leftArr;
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
    NSInteger count = 1;
    
    if (section == 1) {
        count = self.leftArr.count;
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
            [cell.headerPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@,%@",picURL,self.userModel.headimage]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        }
        
        return cell;
        
    }else
    {
        InputCell *cell = [InputCell cellWithTableView:tableView];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.textField.delegate = self;
        cell.textField.x  = 100;
        cell.textField.placeholder = @"请输入";
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
            case sex://性别
            {
                NSString *sexstr = nil;
                self.userModel.sex == 1 ? (sexstr = @"男") : (sexstr = @"女");
                cell.textField.text = sexstr;
                break;
            }
            case telephone://手机号
            {
                cell.textField.text = self.userModel.username;
//                cell.textField.keyboardType = UIKeyboardTypePhonePad;
                break;
            }
            case identity://身份证
            {
                cell.textField.text = self.userModel.identity;
//                cell.textField.keyboardType = UIKeyboardTypePhonePad;
                break;
            }
            case address://地址
                cell.textField.text = self.userModel.address;
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
        return 100;
    }else
    {
        return 40;
    }
}




-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        self.coverView.hidden = NO;
        self.contentView.hidden = NO;
        self.tableView.tableFooterView.hidden = YES;
        return;
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



#pragma mark========textField的代理方法================
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    switch (textField.tag)
    {
        case membername:
            self.userModel.membername = textField.text;
            break;
            //        case sex:
            //            self.userModel.sex = textField.text;
            //            break;
        case telephone:
            self.userModel.username = textField.text;
            break;
        case identity:
            self.userModel.identity = textField.text;
            break;
        case address:
            self.userModel.address = textField.text;
            break;
            
        default:
            break;
    }
}


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







@end
