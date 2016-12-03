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


/** 商品图片 */
@property (nonatomic,weak) UIImageView *images;

/** 商品名称 */
@property (nonatomic,weak) UILabel *productname;
/** 星币 */
@property (nonatomic,weak) UILabel *star;


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
        
        //设置按钮
        UIButton *selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 170  *0.5 + 7, 11, 11)];
        [selectBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
         [selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        self.selectBtn = selectBtn;
        [self.contentView addSubview:selectBtn];
        
        //图像
        UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(selectBtn.frame) + 16, 15 - 7, 105, 70)];
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
        
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}



-(void)setProductModel:(ProductModel *)productModel
{
    _productModel = productModel;
    
    [self.images sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picURL,productModel.images]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    self.productname.text = productModel.productname;
    self.star.text = productModel.price;
//    self.productname.text = @"我的商品我的商235623品我23462的商品";
//    self.star.text = @"1000星币";
    
    //设置是否选中
    self.selectBtn.selected = productModel.btnSelected;
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

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 7;
    frame.origin.y += 7;
    
    
    [super setFrame:frame];


}

@end
