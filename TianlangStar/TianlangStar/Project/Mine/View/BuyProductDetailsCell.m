//
//  BuyProductDetailsCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/30.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BuyProductDetailsCell.h"
#import "ProductModel.h"


@interface BuyProductDetailsCell ()

/** 商品名称 */
@property (nonatomic,weak) UILabel *productname;

/** 类别型号 */
@property (nonatomic,weak) UILabel *productmodel;

/** 规格 */
@property (nonatomic,weak) UILabel *specifications;

/** 价格 */
@property (nonatomic,weak) UILabel *price;

/** 适用车型 */
@property (nonatomic,weak) UILabel *applycar;

/** 供应商 */
@property (nonatomic,weak) UILabel *vendors;

/** 简介 */
@property (nonatomic,weak) UILabel *introduction;






@end
@implementation BuyProductDetailsCell

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
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {

        CGFloat Kleft = 16;
        
        //商品名称
        UILabel *productname = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, 15, KScreenWidth, 17)];
        productname.font = Font17;
        self.productname = productname;
        [self.contentView addSubview:productname];
        
        //星币或者积分
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, 45, productname.width, 17)];
        price.textColor = [UIColor redColor];
        price.font = Font17;
        self.price = price;
        [self.contentView addSubview:price];
        
        //类型/型号
        UILabel *productmodel = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(price.frame) + 14, productname.width, 14)];
        productmodel.textColor = lableTextcolor;
        productmodel.font = Font14;
        self.productmodel = productmodel;
        [self.contentView addSubview:productmodel];
        
        //规格
        UILabel *specifications = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(productmodel.frame) + 10, productname.width, 17)];
        specifications.textColor = lableTextcolor;
        specifications.font = Font14;
        self.specifications = specifications;
        [self.contentView addSubview:specifications];
        
        //适用车型
        UILabel *applycar = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(specifications.frame) + 14, productname.width, 14)];
        applycar.textColor = lableTextcolor;
        applycar.font = Font14;
        self.applycar = applycar;
        [self.contentView addSubview:applycar];
        
        //供应商
        UILabel *vendors = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(applycar.frame) + 10, productname.width, 17)];
        vendors.textColor = lableTextcolor;
        vendors.font = Font14;
        self.vendors = specifications;
        [self.contentView addSubview:vendors];
        
        //简介
        UILabel *introduction = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(applycar.frame) + 10, productname.width - 32, 17)];
        introduction.textColor = lableTextcolor;
        introduction.numberOfLines = 0;
        introduction.font = Font14;
        self.introduction = introduction;
        [self.contentView addSubview:introduction];
    }

    return self;
}




+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    BuyProductDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[BuyProductDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(void)setModel:(ProductModel *)model
{
    _model = model;
    
    self.productname.text = model.productname;
    self.price.text = [NSString stringWithFormat:@"%@星币",model.price];
    self.productmodel.text = model.productmodel;
    self.specifications.text = model.specifications;
    self.applycar.text = model.applycar;
    self.vendors.text = model.vendors;
    self.introduction.text = model.introduction;
    self.introduction.height = model.introductionH - 158;
}



@end
