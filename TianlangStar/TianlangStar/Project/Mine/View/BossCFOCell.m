//
//  BossCFOCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/24.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BossCFOCell.h"
#import "CFOModel.h"


@interface BossCFOCell ()

/** 产品名称 */
@property (nonatomic,weak) UILabel *produce;

/** 星币 */
@property (nonatomic,weak) UILabel *star;

/** 用户 */
@property (nonatomic,weak) UILabel *userName;

/** 数量 */
@property (nonatomic,weak) UILabel *count;

/** 时间 */
@property (nonatomic,weak) UILabel *time;


@end

@implementation BossCFOCell

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
        
        CGFloat marginX = 20;
        
        //产品名称
        UILabel *produce = [[UILabel alloc] init];
        produce.x = marginX;
        produce.y = 0;
        produce.width = KScreenWidth * 0.5 - 60 - 15 - 5 - marginX;
        produce.height = 80;
        produce.numberOfLines = 0;
        produce.font = Font12;
        self.produce  = produce;
        produce.textColor = [UIColor colorWithWhite:0.2 alpha:1];
//        produce.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:produce];
        
        //金额
        UILabel *star = [[UILabel alloc] init];
        star.x = KScreenWidth * 0.5 - 65;
        star.width = 60;
        star.height = 30;
        star.centerY = produce.centerY;
        star.numberOfLines = 0;
        star.font = Font12;
        star.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        self.star  = star;
        //        star.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:star];
        
        
        //数量
        UILabel *count = [[UILabel alloc] init];
        count.width = 30;
        count.height = 30;
        count.centerY = produce.centerY;
        count.centerX = KScreenWidth * 0.52;
        count.numberOfLines = 0;
        count.font = Font12;
        count.textAlignment = NSTextAlignmentCenter;
        count.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        self.count  = count;
        //        count.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:count];
        
        
        //时间
        UILabel *time = [[UILabel alloc] init];
        time.width = 80;
        time.height = 80;
        time.centerY = produce.centerY;
        time.x = CGRectGetMaxX(count.frame) + 3;
        time.numberOfLines = 0;
        time.font = Font12;
        time.textAlignment = NSTextAlignmentCenter;
        time.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        self.time  = time;
        //        time.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:time];
        
        
        //用户
        UILabel *userName = [[UILabel alloc] init];
        userName.width = KScreenWidth - CGRectGetMaxX(time.frame) - 10;
        userName.height = 30;
        userName.centerY = produce.centerY;
        userName.x = CGRectGetMaxX(time.frame) + 5;
        userName.numberOfLines = 0;
        userName.font = Font12;
        userName.textAlignment = NSTextAlignmentCenter;
        self.userName  = userName;
        userName.textColor = [UIColor colorWithWhite:0.2 alpha:1];
        //        userName.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:userName];
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    

    return self;

}

-(void)setCfoModel:(CFOModel *)cfoModel
{
    _cfoModel = cfoModel;
    self.produce.text = cfoModel.product;
    self.count.text = cfoModel.count;
    self.star.text = cfoModel.amount;
    self.time.text = cfoModel.time;
    self.userName.text = cfoModel.userName;

    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    BossCFOCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];\
    if (cell == nil)
    {
        cell = [[BossCFOCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}


-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];

}



@end
