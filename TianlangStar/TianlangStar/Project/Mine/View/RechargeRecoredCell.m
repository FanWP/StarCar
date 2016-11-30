//
//  RechargeRecoredCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "RechargeRecoredCell.h"
#import "VirtualcenterModel.h"

@implementation RechargeRecoredCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        //设置lable
        UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(36, 0, KScreenWidth, 54)];
        left.centerY = self.centerY;
        left.font = Font12;
        left.textColor = lableTextcolor;
        self.leftlable = left;
        [self.contentView addSubview:left];
        
        //设置lable
        UILabel *right = [[UILabel alloc] init];
        self.rightlable = right;
        right.width = KScreenWidth * 0.5;
        right.height = 54;
        right.centerY = self.centerY;
        right.x = KScreenWidth - 60 - right.width;
        self.rightlable = right;
        right.textAlignment = NSTextAlignmentRight;
        right.font = Font12;
        right.textColor = lableTextcolor;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:right];
    }

    return self;
}


-(void)setRechargedModel:(VirtualcenterModel *)rechargedModel
{
    _rechargedModel = rechargedModel;
    self.leftlable.text = rechargedModel.lastTime;
    self.rightlable.text = [NSString stringWithFormat:@"充值%@星币",rechargedModel.price];

//    self.leftlable.text = @"2016-22-10 12:09:34";
//    self.rightlable.text = @"充值1000星币";
    

}


+(instancetype)cellWithTableview:(UITableView *)tableView
{
    NSString *ID = @"cell";
    
    RechargeRecoredCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[RechargeRecoredCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 7;
    
    [super setFrame:frame];

}


@end
