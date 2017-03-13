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

/** 订单号 */
@property (nonatomic,weak) UILabel *orderNumberLabel;

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
        CGFloat margin = 16;
        UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 14, 105, 70)];
        images.contentMode = UIViewContentModeScaleAspectFill;
        images.layer.masksToBounds = YES;
        self.images = images;
        [self.contentView addSubview:images];
        
        
        //订单号
        UILabel *orderNunLabel = [[UILabel alloc] init];
        orderNunLabel.height = 10;
        orderNunLabel.width = KScreenWidth - 2 * margin;
        orderNunLabel.x = images.x;
//        orderNunLabel.y = images.y + images.height;
        orderNunLabel.y = CGRectGetMaxY(images.frame) + 5;
        orderNunLabel.font = Font12;
        orderNunLabel.numberOfLines = 0;
        //        productname.backgroundColor = [UIColor greenColor];
        self.orderNumberLabel = orderNunLabel;
        [self.contentView addSubview:orderNunLabel];
        
        
        //商品名称
        UILabel *productname = [[UILabel alloc] init];
        productname.height = images.height;
        productname.width = KScreenWidth -images.width - 2 * margin -100;
        productname.x = CGRectGetMaxX(images.frame) + 12;
        productname.centerY = images.centerY;
        productname.font = Font12;
        productname.numberOfLines = 0;
//        productname.backgroundColor = [UIColor greenColor];
        self.productname = productname;
        [self.contentView addSubview:productname];
        
        
        //商品价格
        UILabel *price = [[UILabel alloc] init];
        price.height = 30;
        price.width = 100;
        price.x = KScreenWidth - 34 - price.width;
        price.y = productname.y;
        price.font = Font11;
        price.textAlignment = NSTextAlignmentRight;
        price.textColor = [UIColor redColor];
//        price.backgroundColor = [UIColor orangeColor];
        self.price = price;
        [self.contentView addSubview:price];
        
        //购买商品的个数
        UILabel *count = [[UILabel alloc] init];
        count.height = price.height;
        count.width = 100;
        count.x = price.x;
        count.y = CGRectGetMaxY(price.frame) + 14;
        count.font = Font11;
        count.textAlignment = NSTextAlignmentRight;
//        count.backgroundColor = [UIColor redColor];
        self.count = count;
        [self.contentView addSubview:count];
        
        
        //设置分割线
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(images.frame) + 10 + 10, KScreenWidth - 32, 1)];
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
        self.date.font = Font11;
        [self.contentView addSubview:date];
        
        
        
        //购买商品的交易状态
        UILabel *confirm = [[UILabel alloc] init];
        confirm.height = price.height;
        confirm.width = 100;
        confirm.x = KScreenWidth - confirm.width - 34;
        confirm.y = date.y;
        confirm.textColor = [UIColor redColor];
        confirm.font = Font12;
        confirm.textAlignment = NSTextAlignmentRight;
        self.confirm = confirm;
        [self.contentView addSubview:confirm];
        
        
        //设置箭头
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrows"]];
        img.x = KScreenWidth - 16 - img.width;
        img.centerY = images.centerY;
        [self.contentView addSubview:img];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}


//设置模型数据------  赋值
-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    NSArray *arr = [orderModel.images componentsSeparatedByString:@","];
    
    NSString *imgURl = [arr firstObject];
    
    [self.images sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,imgURl]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.productname.text = orderModel.productname;
    
//    NSString *url = [NSString stringWithFormat:@"%@%@",picURL,orderModel.images];
    
    self.count.text = [NSString stringWithFormat:@"x %@",orderModel.count];
    self.date.text = orderModel.lasttime;
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单号：%@",orderModel.saleid];
    
    //订单状态
    if (orderModel.confirm == 0)
    {
        self.confirm.text = @"交易中";
    }else
    {
        self.confirm.text = @"交易成功";
    }
    //购买类型
    if (orderModel.purchasetype == 1) {//虚拟币
        self.price.text = [NSString stringWithFormat:@"%.0f星币",orderModel.real_price];
    }else if (orderModel.purchasetype == 2){//积分
        self.price.text = [NSString stringWithFormat:@"%@积分",orderModel.purchaseprice];
    }
//    self.price.text = [NSString stringWithFormat:@"%.0f星币",orderModel.real_price];
    

    
    
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


-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 7;
    frame.origin.y += 7;

    [super setFrame:frame];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



@end
