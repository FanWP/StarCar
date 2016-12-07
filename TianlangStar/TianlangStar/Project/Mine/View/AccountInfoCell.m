//
//  AccountInfoCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AccountInfoCell.h"
#import "UserModel.h"

@implementation AccountInfoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSMutableArray *titleArr = [NSMutableArray array];
        CGFloat width = KScreenWidth / 3;
        
        for (NSInteger i = 0; i < 4 ; i++)
        {
            UILabel *lable = [[UILabel alloc] init];
            lable.x = width * i;
            lable.y = 0;
            lable.width = width;
            lable.height = 44;
            lable.font = Font14;
            lable.textAlignment = NSTextAlignmentCenter;
            
            //做位置的微调
            switch (i)
            {
                case 0://手机号
                {
                    lable.width += 20;
                    lable.x += 10;
                    self.name = lable;
                    break;
                }
                case 1://等级
                {
//                    lable.width += 20;
//                    lable.x -= 10;
                    self.viplevel = lable;
                    break;
                }
                case 2://注册时间
                {
                    //                    lable.width -= 20;
                    //
                    lable.height = 22;
                    lable.x += 15;
                    lable.y = 0;
                    self.lasttime = lable;
                    lable.font = Font10;
                    lable.textAlignment = NSTextAlignmentLeft;
                    break;
                }
                case 3://时分秒
                {
                    lable.height = 22;
                    self.time = lable;
                    lable.textAlignment = NSTextAlignmentLeft;
                    lable.y = 22;
                    lable.centerX = self.lasttime.centerX;
                    lable.font = Font10;
                    break;
                }
                    
                default:
                    break;
            }
            [titleArr addObject:lable];
            [self.contentView addSubview:lable];
        }
        
        //添加底部的灰色线条
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, KScreenWidth, 5)];
        line.backgroundColor = BGcolor;
        [self.contentView addSubview:line];
        
    }
    
    return self;
}

-(void)setUserModel:(UserModel *)userModel
{
    
    //设置数据
    _userModel = userModel;
    self.name.text = userModel.username;
    
    NSString *leval = [NSString VIPis:userModel.viplevel];
    self.viplevel.text = leval;
    self.time.text = [userModel.createtime substringFromIndex:10];
    self.lasttime.text = [userModel.createtime substringToIndex:10];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static  NSString * ID = @"cell";
    
    AccountInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[AccountInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}



- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}





@end
