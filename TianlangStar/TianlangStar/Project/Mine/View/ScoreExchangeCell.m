//
//  ScoreExchangeCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ScoreExchangeCell.h"
#import "ProductModel.h"

@interface ScoreExchangeCell ()


/** 商品名称 */
@property (nonatomic,weak) UILabel *scoreprice;
/** 商品名称 */
@property (nonatomic,weak) UILabel *productname;
/** 商品描述 */
@property (nonatomic,weak) UILabel *introduction;

/** 商品图片 */
@property (nonatomic,strong) UIImageView *productImg;

@end


@implementation ScoreExchangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    ScoreExchangeCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[ScoreExchangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //图片
        UIImageView *productImg = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 137, 105)];
        self.productImg = productImg;
        [self.contentView addSubview:productImg];
        
        //商品名称
        UILabel *productname = [[UILabel alloc] init];
        productname.x = CGRectGetMaxX(productImg.frame) + 8;
        productname.y = 15;
        productname.height = 12;
        productname.width = KScreenWidth * 0.5;
        productname.font = Font12;
        self.productname = productname;
        [self.contentView addSubview:productname];
        
        //商品描述
        UILabel *introduction = [[UILabel alloc] init];
        introduction.x = productname.x;
        introduction.y = CGRectGetMaxY(productname.frame) + 8;
        introduction.height = productImg.height - 20;
        introduction.width = KScreenWidth * 0.5;
        introduction.numberOfLines = 0;
        introduction.font = Font10;
//        introduction.backgroundColor = [UIColor orangeColor];
        introduction.textColor = lableTextcolor;
        self.introduction = introduction;
        [self.contentView addSubview:introduction];
        
        
        //积分价格
        UILabel *scoreprice = [[UILabel alloc] init];
        scoreprice.x = productname.x;
        scoreprice.y = 136 - 22 - 7 - 4;
        scoreprice.height = 11;
        scoreprice.width = KScreenWidth * 0.5;
        scoreprice.font = Font11;
        scoreprice.textColor = [UIColor redColor];
        self.scoreprice = scoreprice;
        [self.contentView addSubview:scoreprice];

        //设置箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
    }
    return self;

}



//赋值
-(void)setModel:(ProductModel *)model
{
    _model = model;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,model.images]] placeholderImage:[UIImage imageNamed:@"lunbo2"]];
    
    self.productname.text = model.productname;
    self.introduction.text = model.introduction;
    self.scoreprice.text = [NSString stringWithFormat:@"%@积分",model.scoreprice];
    //    self.productname.text = @"机油";
//    self.introduction.text = @"gdougqwurguowrugoworgqrwobuowrqiofie fpiewuogiu  pwegip  epgi    ipg 2ipigpweirgwroquguorqeuogqwourguoqw";
//    self.scoreprice.text = @"1500积分";


}

-(void)setFrame:(CGRect)frame
{

    frame.size.height -= 7;
    [super setFrame:frame];

}


@end
