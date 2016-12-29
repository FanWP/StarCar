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
        
//        YYLog(@"KScreenWidth---:%f",KScreenWidth);
        
        CGFloat maginX = 16;
        
        if (KScreenWidth == 320)//5S
        {
            maginX = 8;
            
        }
        
        
        //年月日
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(maginX, 5, 70, 30)];
        self.time = time;
        time.font = Font12;
        time.textColor = lableTextcolor;
        //        time.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:time];
        
        //时分秒
        UILabel *lastTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(time.frame) , 5 , 80, 30)];
        //        lastTime.backgroundColor = [UIColor redColor];
        lastTime.font = Font12;
        lastTime.textColor = lableTextcolor;
        self.lasettime = lastTime;
        [self.contentView addSubview:lastTime];
        
        //金额
        UILabel *rechargLB = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - 110 - 110 - 5, 5, 110, 30)];
        rechargLB.font = Font12;
        rechargLB.textColor = lableTextcolor;
        //        rechargLB.backgroundColor = [UIColor grayColor];
        self.rechargLB = rechargLB;
        [self.contentView addSubview:rechargLB];
    }
    
    return self;
}


-(void)setModel:(VirtualcenterModel *)model
{
    _model = model;
    NSString *str = model.lasttime;
    NSString *time = [str substringToIndex:10];
    NSString *lasttime = [str substringFromIndex:10];
    
    self.time.text = time;
    NSString *rechargeType = self.rechareType == 1 ? @"星币" : @"积分";
    self.rechargLB.text = [NSString stringWithFormat:@"充值%@%@",model.price,rechargeType];
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


-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 4;
    [super setFrame:frame];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
