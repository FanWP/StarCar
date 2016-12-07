//
//  BuyingSuccessCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/6.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BuyingSuccessCell.h"
#import "BuyingSuccessDetailmodel.h"

@interface BuyingSuccessCell ()



/** 订单号 */
@property (nonatomic,weak) UILabel *saleId;

/** 折扣价格 */
@property (nonatomic,weak) UILabel *discountPrice;

/** 价格 */
@property (nonatomic,weak) UILabel *price;
/** 数量 */
@property (nonatomic,weak) UILabel *count;
/** 折扣 */
@property (nonatomic,weak) UILabel *discount;

@property (nonatomic,weak) UILabel *currenttime;
/** 时间 */
@property (nonatomic,weak) UILabel *productname;
/** 收款方 */
@property (nonatomic,weak) UILabel *payee;

/** 付款价格 */
@property (nonatomic,weak) UILabel *realPrice;

@end

@implementation BuyingSuccessCell

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
    
    BuyingSuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[BuyingSuccessCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    

    return cell;

}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //商品名称
        //左侧的数据
        NSArray *Arr= @[@"商品名称",@"交易单号",@"商品原价",@"实付金额"];
        
        CGFloat lableH = 50;
        
        for (NSInteger i = 0; i < Arr.count; i++)
        {
            UILabel *lable = [[UILabel alloc] init];
            
            lable.x = 16;
            lable.width = KScreenWidth * 0.45;
            lable.height = lableH;
            lable.y = i * lable.height;
            lable.font = Font17;
            lable.text = Arr[i];
            
            //加灰色线条
            if (i > 0) {
                
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(16, i *lable.height, KScreenWidth - 32, 1)];
                line.backgroundColor = BGcolor;
                [self.contentView addSubview:line];
            }
            [self.contentView addSubview:lable];
        }

        //右边的数据
        for (NSInteger i = 0; i < 4; i++)
        {
            UILabel *lable = [[UILabel alloc] init];
            lable.width = KScreenWidth * 0.55;
            lable.height = lableH;
            lable.x = KScreenWidth - 20 - lable.width;
            lable.y = i * lable.height;
            lable.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:lable];
            
            //赋值
            switch (i)
            {
                case 0:
                    self.productname = lable;
                    break;
                case 1:
                    self.saleId = lable;
                    break;
                case 2:
                    self.price = lable;
                    break;
                case 3:
                    self.realPrice = lable;
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}


-(void)setModel:(BuyingSuccessDetailmodel *)model
{
    _model = model;
    
    self.productname.text = model.productname;
    self.saleId.text = model.saleId;
    self.price.text = [NSString stringWithFormat:@"%@星币",model.price];
    self.realPrice.text = [NSString stringWithFormat:@"%ld星币",(long)model.realPrice];
}


-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 7;
    frame.origin.y += 7;
    [super setFrame:frame];

}

@end
