//
//  WaitHandleOrderCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "WaitHandleOrderCell.h"
#import "OrderModel.h"


@interface WaitHandleOrderCell ()


/** 用户名 */
@property (nonatomic,weak) UILabel *username;

/** 交易状态 */
@property (nonatomic,weak) UILabel *saletype;

/** 交易金额 */
@property (nonatomic,weak) UILabel *star;


@end


@implementation WaitHandleOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


//初始化数据
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //间距
        CGFloat margin = 25;
//        UILabel 的宽度
        CGFloat width = (KScreenWidth - 2 *margin) / 3;
        CGFloat height = 30;
        
        for (NSInteger i = 0; i < 3; i++)
        {
            UILabel *lable = [[UILabel alloc] init];
            lable.height = height;
            lable.width = width;
            lable.x = margin + i * width;
            lable.y = 7;
            lable.font = Font14;
//            lable.backgroundColor = [UIColor orangeColor];
            
            //设置赋值
            switch (i) {
                case 0://用户名
                {
                    self.username = lable;
                    lable.textAlignment = NSTextAlignmentLeft;
                    break;
                }
                case 1://交易状态
                {
                    self.saletype = lable;
                    lable.textAlignment = NSTextAlignmentCenter;
                    lable.textColor = [UIColor redColor];
                    break;
                }
                case 2:// 交易金额
                {
                    self.star = lable;
                    lable.textAlignment = NSTextAlignmentRight;
                    break;
                }
                default:
                    break;
            }
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            [self.contentView addSubview:lable];
        }
 
    }

    return self;
}


//模型赋值
-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    self.username.text = orderModel.membername;
    self.saletype.text = @"交易中";
    if (orderModel.purchasetype == 2) {
        self.star.text = [NSString stringWithFormat:@"+%@积分",orderModel.price];
    }else
    {
        self.star.text = [NSString stringWithFormat:@"+%@星币",orderModel.price];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
