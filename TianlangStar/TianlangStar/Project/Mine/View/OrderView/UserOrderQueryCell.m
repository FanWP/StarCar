//
//  UserOrderQueryCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "UserOrderQueryCell.h"
#import "OrderModel.h"




@interface UserOrderQueryCell ()

/** 商品的图片images */
@property (nonatomic,weak) UIImageView *images;

/** 商品名称 */
@property (nonatomic,weak) UILabel *productname;

/** 商品价格 */
@property (nonatomic,weak) UILabel *price;

/** 商品的个数 */
@property (nonatomic,weak) UILabel *count;

/** 商品名称 */
@property (nonatomic,weak) UILabel *date;

/** 商品名称 */
@property (nonatomic,weak) UILabel *confirm;

@end



@implementation UserOrderQueryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        //商品图片
        CGFloat margin = 20;
        UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 30, 100, 100)];
        self.images = images;
        [self.contentView addSubview:images];
        
        //商品名称
        UILabel *productname = [[UILabel alloc] init];
        productname.height = 30;
        productname.width = KScreenWidth -images.width - 2 * margin -100;
        productname.x = CGRectGetMaxX(images.frame) + 10;
        productname.centerY = images.centerY;
        productname.font = Font14;
//        productname.backgroundColor = [UIColor greenColor];
        self.productname = productname;
        [self.contentView addSubview:productname];
        
        //商品价格
        UILabel *price = [[UILabel alloc] init];
        price.height = 30;
        price.width = 100;
        price.x = CGRectGetMaxX(productname.frame);
        price.y = 30;
//        price.backgroundColor = [UIColor orangeColor];
        self.price = price;
        [self.contentView addSubview:price];
        
        //购买商品的个数
        UILabel *count = [[UILabel alloc] init];
        count.height = price.height;
        count.width = 100;
        count.x = price.x;
        count.y = price.y + 40;
//        count.backgroundColor = [UIColor redColor];
        self.count = count;
        [self.contentView addSubview:count];
        
        
        //设置分割线
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(images.frame) + 10, KScreenWidth, 1)];
        view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [self.contentView addSubview:view];
        
        //购买商品时间
        UILabel *date = [[UILabel alloc] init];
        date.height = price.height;
        date.width = 200;
        date.x = images.x;
        date.y = CGRectGetMaxY(images.frame) + margin;
//        date.backgroundColor = [UIColor orangeColor];
        self.date = date;
        self.date.font = Font14;
        [self.contentView addSubview:date];
        
        
        
        //购买商品的交易状态
        UILabel *confirm = [[UILabel alloc] init];
        confirm.height = price.height;
        confirm.width = 100;
        confirm.x = KScreenWidth - 110;
        confirm.y = date.y;
        confirm.textColor = [UIColor redColor];
    
        self.confirm = confirm;
        [self.contentView addSubview:confirm];
    }
    return self;
}


//设置模型数据------  赋值
-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    [self.images sd_setImageWithURL:[NSURL URLWithString:orderModel.picture] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.productname.text = orderModel.productname;
    self.price.text = [NSString stringWithFormat:@"%@星币",orderModel.price];
    self.count.text = [NSString stringWithFormat:@"* %@",orderModel.count];
    self.date.text = orderModel.lasttime;
    self.confirm.text = @"交易成功";
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static  NSString *ID = @"cell";
    
    UserOrderQueryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UserOrderQueryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
//
//
//-(void)setFrame:(CGRect)frame
//{
//    frame.size.height -= 10;
//
//
//}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



@end
