//
//  CarDetailInfoTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/16.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CarDetailInfoTableVC.h"

#import "PictureCell.h"
#import "LabelTextFieldCell.h"

@interface CarDetailInfoTableVC ()

@end

@implementation CarDetailInfoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchCarDetailInfoData];
    
}


- (void)fetchCarDetailInfoData
{
    NSString *url = [NSString stringWithFormat:@"%@getallcarinfoservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;

    [HttpTool post:url parmas:parameters success:^(id json)
    {
        YYLog(@"爱车详情返回：%@",json);
        
    } failure:^(NSError *error)
    {
        YYLog(@"爱车详情请求错误：%@",error);
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 0.3 * KScreenHeight + 2 * Klength5;
    }

    return 40;
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
        
        return cell;

    }
    else if (indexPath.section == 1)
    {
        static NSString *identifier1 = @"cell1";
        
        LabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        if (cell == nil)
        {
            
            cell = [[LabelTextFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
            
        }
        
        return cell;

    }
    else
    {
        static NSString *identifier2 = @"cell2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier2];
            
        }

        return cell;
    }
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
