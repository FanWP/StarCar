//
//  UserScoreExchangeCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "UserScoreExchangeCell.h"
#import "ProductModel.h"


@interface UserScoreExchangeCell ()


/** 商品名称 */
@property (nonatomic,weak) UILabel *productname;

/** 图片 */
@property (nonatomic,weak) UIImageView *images;

/** 价格 */
@property (nonatomic,weak) UILabel *price;

/** 适用车型 */
@property (nonatomic,weak) UILabel *time;


@end

@implementation UserScoreExchangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //商品图片
        UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake(16, 7, 105, 70)];
        self.images = images;
        images.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:images];
        
        //商品名称
        
        CGFloat priceW = 80;
        CGFloat productnameX = CGRectGetMaxX(images.frame) + 12;
        CGFloat productnameW = KScreenWidth - productnameX - priceW - 34;
        
        UILabel *productname = [[UILabel alloc] initWithFrame:CGRectMake(productnameX, 20, productnameW, 300)];
        productname.numberOfLines = 0;
        productname.font = Font12;
        productname.textColor = lableTextcolor;
        self.productname = productname;
        [self.contentView addSubview:productname];
        
        
        //积分
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(productname.frame) + 12, 20, priceW, 30)];
        price.centerY = images.centerY;
        price.font = Font12;
        price.textColor = lableRedTextcolor;
        self.price = price;
//        price.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:price];
        
        //箭头
        UIImageView *arrows = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrows"]];
        arrows.x = KScreenWidth - 16 - arrows.width;
        arrows.centerY = images.centerY;
        [self.contentView addSubview:arrows];
        
        //分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(images.frame) + 7, KScreenWidth - 26, 1)];
        line.backgroundColor = BGcolor;
        [self.contentView addSubview:line];
        
        //时间
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(34, CGRectGetMaxY(line.frame), KScreenWidth - 68, 25)];
        time.textAlignment = NSTextAlignmentRight;
        time.font = Font11;
        time.textColor = lableTextcolor;
        self.time = time;

        [self.contentView addSubview:time];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }

    return self;
}


-(void)setModel:(ProductModel *)model
{
    _model = model;
    
    self.price.text = [NSString stringWithFormat:@"%@积分",model.scoreprice];
    self.productname.text = model.productname;
    self.time.text = [model.lasttime getDetailCurrentTime];
    [self.images sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,model.images]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    YYLog(@"model.images--%@",[NSString stringWithFormat:@"%@%@",picURL,model.images]);
    
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    UserScoreExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UserScoreExchangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 7;
    frame.origin.y += 7;
    [super setFrame:frame];

}


@end
