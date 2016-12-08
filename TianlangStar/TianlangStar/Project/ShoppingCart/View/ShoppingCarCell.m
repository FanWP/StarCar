//
//  ShoppingCarCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "ProductModel.h"

@interface ShoppingCarCell ()




/** 商品名称 */
@property (nonatomic,weak) UILabel *productname;
/** 星币 */
@property (nonatomic,weak) UILabel *star;

/** 商品的个数 */
@property (nonatomic,weak) UILabel *count;


@end

@implementation ShoppingCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        //添加灰色线条
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 7)];
        line.backgroundColor = BGcolor;
        [self.contentView addSubview: line];
        //设置按钮
        UIButton *selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 170  *0.5 + 7, 40, 40)];
        [selectBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
         [selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        self.selectBtn = selectBtn;
        [self.contentView addSubview:selectBtn];
        
        //图像
        UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(selectBtn.frame) + 5, 15, 105, 70)];
//        images.backgroundColor = [UIColor orangeColor];
        self.images = images;
        [self.contentView addSubview:images];
        
        selectBtn.centerY = images.centerY;

        
        //星币
        UILabel *star = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - 34 - 60, 70, 60, 11)];
        star.centerY = images.centerY;
        star.font = Font11;
        star.textColor = [UIColor redColor];
        star.textAlignment = NSTextAlignmentRight;
//        star.backgroundColor = [UIColor orangeColor];
        self.star = star;
        [self.contentView addSubview:star];
        
        //箭头
        UIImageView *arrows = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrows"]];
        arrows.x = KScreenWidth - 16 - arrows.width;
        arrows.centerY = images.centerY;
        [self.contentView addSubview:arrows];
        
        
        //商品名称
        CGFloat productnameW = KScreenWidth - CGRectGetMaxX(images.frame) - 12 - star.width - 34;
        UILabel *productname = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(images.frame) + 12, 16, productnameW, 60)];
        self.productname = productname;
        productname.font = Font12;
        productname.textColor = lableTextcolor;
        productname.numberOfLines = 0;
//        productname.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:productname];
        
        
        //商品的数量
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(star.x, CGRectGetMaxY(images.frame) - 26 + 7, star.width, 11)];
        count.font = Font11;
        count.textColor = lableTextcolor;
        count.textAlignment = NSTextAlignmentRight;
        self.count = count;
        [self.contentView addSubview:count];
        
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}



-(void)setProductModel:(ProductModel *)productModel
{
    _productModel = productModel;
    
    [self.images sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,productModel.images]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    self.productname.text = productModel.buytype == 1 ? productModel.productname :productModel.services;
    self.star.text = productModel.price;
//    self.productname.text = @"我的商品我的商235623品我23462的商品";
//    self.star.text = @"1000星币";
    
    //设置是否选中
    self.selectBtn.selected = productModel.btnSelected;
    
    self.count.text = [NSString stringWithFormat:@"×%ld",(long)productModel.count];
}



+ (instancetype)cellWithtableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}



@end
