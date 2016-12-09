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

/** 备注 */
@property (nonatomic,weak) UILabel *remark;





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
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(productname.frame) + 13, productname.width, 17)];
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
        UILabel *specifications = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(productmodel.frame) + 10, productname.width, 14)];
        specifications.textColor = lableTextcolor;
        specifications.font = Font14;
        self.specifications = specifications;
        [self.contentView addSubview:specifications];
        
        //适用车型
        UILabel *applycar = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(specifications.frame) + 10, productname.width, 14)];
        applycar.textColor = lableTextcolor;
        applycar.font = Font14;
        self.applycar = applycar;
        [self.contentView addSubview:applycar];
        
        //供应商
        UILabel *vendors = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(applycar.frame) + 10, productname.width, 14)];
        vendors.textColor = lableTextcolor;
        vendors.font = Font14;
        self.vendors = specifications;
        [self.contentView addSubview:vendors];
        
        //简介
        UILabel *introduction = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(applycar.frame) + 10, productname.width - 32, 14)];
        introduction.textColor = lableTextcolor;
        introduction.numberOfLines = 0;
        introduction.font = Font14;
        self.introduction = introduction;
        [self.contentView addSubview:introduction];
        
        //备注
        UILabel *remark = [[UILabel alloc] initWithFrame:CGRectMake(Kleft, CGRectGetMaxY(applycar.frame) + 10, productname.width, 14)];
        remark.textColor = lableTextcolor;
        remark.font = Font14;
        self.remark = remark;
        remark.numberOfLines = 0;
        [self.contentView addSubview:remark];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    self.productmodel.text = [NSString stringWithFormat:@"类型/型号：%@",model.productmodel];
    self.specifications.text = [NSString stringWithFormat:@"规格：%@",model.specifications];
    self.applycar.text = [NSString stringWithFormat:@"适用车型：%@",model.applycar];
    self.vendors.text = [NSString stringWithFormat:@"供应商：%@",model.vendors];
    self.remark.text = [NSString stringWithFormat:@"备注：%@",model.remark];
    self.introduction.text = [NSString stringWithFormat:@"简介：%@",model.introduction];
    
    self.introduction.height = model.introductionH - 182;
    self.remark.y = model.introductionH - 24;
}



@end
