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

/** 商品图片 */
@property (nonatomic,strong) UIImageView *productImg;
/** 商品名称 */
@property (nonatomic,weak) UILabel *scoreprice;
/** 商品名称 */
@property (nonatomic,weak) UILabel *productname;
/** 商品描述 */
@property (nonatomic,weak) UILabel *introduction;



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
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 7)];
        line.backgroundColor = BGcolor;
        [self.contentView addSubview:line];
        
        
        //图片
        UIImageView *productImg = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 137, 100)];
//        productImg.contentMode = UIViewContentModeScaleAspectFill;
//        productImg.layer.masksToBounds = YES;
        self.productImg = productImg;
        [self.contentView addSubview:productImg];
        
        //商品名称
        UILabel *productname = [[UILabel alloc] init];
        productname.x = CGRectGetMaxX(productImg.frame) + 8;
        productname.y = 15;
        productname.height = 12;
        productname.width = KScreenWidth * 0.5;
        productname.font = Font14;
        self.productname = productname;
        [self.contentView addSubview:productname];
        
        //商品描述
        UILabel *introduction = [[UILabel alloc] init];
        introduction.x = productname.x;
        introduction.height = productImg.height - 80;
        introduction.width = KScreenWidth * 0.5;
//        introduction.y = CGRectGetMaxY(productname.frame) + 8;
        introduction.centerY = productImg.centerY;
        introduction.numberOfLines = 0;
        introduction.font = Font12;
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
        scoreprice.font = Font13;
        scoreprice.textColor = [UIColor redColor];
        self.scoreprice = scoreprice;
        [self.contentView addSubview:scoreprice];

        //设置箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellEditingStyleNone;
 
    }
    return self;
}



//赋值
-(void)setModel:(ProductModel *)model
{
    _model = model;
    
    NSArray *imagesArray = [model.images componentsSeparatedByString:@","];
    NSString *pic = [NSString stringWithFormat:@"%@%@",picURL,imagesArray.firstObject];
    NSURL *url = [NSURL URLWithString:pic];
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    self.productname.text = model.productname;
    self.introduction.text = model.introduction;
    self.scoreprice.text = [NSString stringWithFormat:@"%@积分",model.scoreprice];
    //    self.productname.text = @"机油";
//    self.introduction.text = @"gdougqwurguowrugoworgqrwobuowrqiofie fpiewuogiu  pwegip  epgi    ipg 2ipigpweirgwroquguorqeuogqwourguoqw";
//    self.scoreprice.text = @"1500积分";


}



@end
