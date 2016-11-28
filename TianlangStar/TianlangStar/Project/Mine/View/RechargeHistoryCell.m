//
//  RechargeHistoryCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/22.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "RechargeHistoryCell.h"
#import "VirtualcenterModel.h"

@implementation RechargeHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        //年月日
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 95, 30)];
        self.time = time;
//        time.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:time];
        
        //时分秒
        UILabel *lastTime = [[UILabel alloc] initWithFrame:CGRectMake(time.x, CGRectGetMaxY(time.frame) + 10, 90, 30)];
//        lastTime.backgroundColor = [UIColor redColor];
        self.lasettime = lastTime;
        [self.contentView addSubview:lastTime];
        
        //金额
        UILabel *rechargLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(time.frame) + 20, 0, 145, 30)];
//        rechargLB.backgroundColor = [UIColor grayColor];
        self.rechargLB = rechargLB;
        [self.contentView addSubview:rechargLB];
        
    }

    return self;
}


-(void)setModel:(VirtualcenterModel *)model
{
    _model = model;
    NSString *str = model.lastTime;
    NSString *time = [str substringToIndex:10];
    NSString *lasttime = [str substringFromIndex:10];
    
    self.time.text = time;
    self.rechargLB.text = [NSString stringWithFormat:@"充值%@星币",model.price];
    self.lasettime.text = lasttime;
    
//    YYLog(@"%@",model.lastTime);
//    YYLog(@"model.price--%@",model.price);
//    YYLog(@"model.price--%@",str);


}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    RechargeHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[RechargeHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
