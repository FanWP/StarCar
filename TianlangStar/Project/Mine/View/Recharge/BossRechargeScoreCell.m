//
//  BossRechargeStarOrScoreCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BossRechargeScoreCell.h"
#import "VirtualcenterModel.h"


@interface BossRechargeScoreCell ()

/** <#Class#> */
@property (nonatomic,strong) NSMutableArray *rechargeArrLB;

/** 年月日 */
@property (nonatomic,weak) UILabel *dateLable;

/** 时间 */
@property (nonatomic,weak) UILabel *timeLable;

/** 积分数量 */
@property (nonatomic,weak) UILabel *scoreLable;

/** 用户名 */
@property (nonatomic,weak) UILabel *usernameLable;

/** 用户名 */
@property (nonatomic,weak) UILabel *payTypeLable;




@end

@implementation BossRechargeScoreCell

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

        NSArray *arr = @[@"2018-12-34",@"12:34:20",@"80808908098",@"李四",@"现金"];
        
        self.rechargeArrLB  = [NSMutableArray array];
        
        for (NSInteger i = 0; i < 5; i++) {
            UILabel *lable = [[UILabel alloc] init];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = Font14;
            lable.text = arr[i];
            [self.rechargeArrLB addObject:lable];
            [self.contentView addSubview:lable];
        }
        
        /*
        CGFloat count = 5;
        if (self.rechargeType == 2) {//积分
            count = 4;
        }
        CGFloat width = KScreenWidth / (count - 1);
        for (NSInteger i = 0; i < count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.x = (i - 1) * width;
            label.y =  10;
            label.width = width;
            label.height = 40;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = Font14;
            label.text = arr[i];
  
            switch (i) {
                case 0:
                {
                    self.dateLable = label;
                
                    break;
                }
                case 1:
                {
                    self.dateLable.frame = label.frame;
                    self.dateLable.y -= 10;
                    
                    self.timeLable = label;
                    self.timeLable.y += 10;
                    break;
                }
                case 2:
                {
                    self.scoreLable = label;
                    break;
                }
                case 3:
                {
                    self.usernameLable = label;
                    
                    break;
                }
                case 4:
                {
                    self.payTypeLable = label;
                    
                    break;
                }
                    
                    
                default:
                    break;
            }
            
            
            [self.contentView addSubview:label];
        }
        */
        
        /*
        @property (nonatomic,weak) UILabel *dateLable;
        @property (nonatomic,weak) UILabel *timeLable;
        @property (nonatomic,weak) UILabel *scoreLable;
        @property (nonatomic,weak) UILabel *usernameLable;
        */
        
        
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    BossRechargeScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[BossRechargeScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setRechargeType:(NSInteger)rechargeType
{
    _rechargeType = rechargeType;
    
    //判断rechargeType并赋值设置尺寸
    
    
    CGFloat count = 5;
    CGFloat margin = 10;
    
    if (rechargeType == 2) {//积分
        count = 4;
        margin = 0;
    }
    CGFloat width = (KScreenWidth - margin) / (count - 1);
    
    for (NSInteger i = 0; i < self.rechargeArrLB.count; i++) {
        UILabel *lable = self.rechargeArrLB[i];
        lable.x = (i - 1) * width + margin;
        lable.y =  10;
        lable.width = width;
        lable.height = 40;

        switch (i) {
            case 0:
            {
                self.dateLable = lable;
                break;
            }
            case 1:
            {
                self.dateLable.frame = lable.frame;
                self.dateLable.y -= 10;
                self.timeLable = lable;
                self.timeLable.y += 10;
                break;
            }
            case 2:
            {
                self.scoreLable = lable;
                break;
            }
            case 3:
            {
                self.usernameLable = lable;
                break;
            }
            case 4:
            {
                self.payTypeLable = lable;
                break;
            }

            default:
                break;
        }

    }

}


-(void)setVirtualcenterModel:(VirtualcenterModel *)virtualcenterModel
{
    _virtualcenterModel = virtualcenterModel;
    _dateLable.text = [virtualcenterModel.lasttime substringToIndex:10];
    _timeLable.text = [virtualcenterModel.lasttime substringFromIndex:10];
    _scoreLable.text = [NSString stringWithFormat:@"%@星币",virtualcenterModel.price];
    
//        _scoreLable.text = @"t9w0eryi";
    _usernameLable.text = virtualcenterModel.membername;

}

@end
