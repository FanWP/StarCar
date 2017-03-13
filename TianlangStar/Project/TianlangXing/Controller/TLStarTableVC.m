//
//  TLStarTableVC.m
//  TianlangStar
//
//  Created by Beibei on 17/1/16.
//  Copyright © 2017年 yysj. All rights reserved.
//

#import "TLStarTableVC.h"
#import "TLPictureCell.h"

#import "TLStarModel.h"

#import "TLStarDetailVC.h"

@interface TLStarTableVC ()

@property (nonatomic,strong) NSArray *tlInfoArray;
@property (nonatomic,strong) TLStarModel *tLStarModel;

@end

@implementation TLStarTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tlInfoArray = [NSArray array];
    _tLStarModel = [[TLStarModel alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.rowHeight = (KScreenHeight - 64 - 44) / 3;
    
    [self dataTLStar];
}

- (void)dataTLStar
{
//    unlogin/find/company/description/list
    
    NSString *urlString = [NSString stringWithFormat:@"%@unlogin/find/company/description/list",URL];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"天狼星返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            if (responseObject[@"body"] != nil)
            {
                _tlInfoArray = [TLStarModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
                
                [self.tableView reloadData];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"天狼星错误：%@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tlInfoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    TLPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[TLPictureCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    _tLStarModel = _tlInfoArray[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:_tLStarModel.faceImage];
    
    [cell.pictureView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"lunbo1"]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tLStarModel = _tlInfoArray[indexPath.row];
    
    TLStarDetailVC *tLStarDetailVC = [[TLStarDetailVC alloc] init];
    tLStarDetailVC.url = _tLStarModel.detailUrl;
    [self.navigationController pushViewController:tLStarDetailVC animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
