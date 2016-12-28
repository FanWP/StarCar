//
//  ChekinCarInfoTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/16.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ChekinCarInfoTableVC.h"

#import "LabelTextFieldCell.h"

@interface ChekinCarInfoTableVC ()

@property (nonatomic,strong) NSArray *leftLabelArray;

@end

@implementation ChekinCarInfoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.rowHeight = 40;
    
}


- (NSArray *)leftLabelArray
{
    if (!_leftLabelArray)
    {
        _leftLabelArray = @[@"车牌号",@"品牌",@"型号",@"车型",@"车架号",@"发动机号",@"购买年份",@"保险信息",@"较强险提醒日期",@"商业险提醒日期"];
    }
    
    return _leftLabelArray;
}



- (void)creatHandinView
{
    CGFloat footerViewY = KScreenHeight - 50;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, footerViewY, KScreenWidth, Klength44)];
    
    CGFloat handinButtonWidth = 120;
    CGFloat handinButtonX = (KScreenWidth / 2) - (handinButtonWidth / 2);
    UIButton *handinButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    handinButton.frame = CGRectMake(handinButtonX, 0, handinButtonWidth, Klength44);
    [handinButton setTitle:@"提交" forState:(UIControlStateNormal)];
    [handinButton addTarget:self action:@selector(handinAction) forControlEvents:(UIControlEventTouchUpInside)];
    [footerView addSubview:handinButton];
    
    self.tableView.tableFooterView = footerView;
}



- (void)handinAction
{
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftLabelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    LabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[LabelTextFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    cell.leftLabel.text = _leftLabelArray[indexPath.row];
    
    return cell;
}




@end














