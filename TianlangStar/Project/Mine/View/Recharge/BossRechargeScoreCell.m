//
//  BossRechargeStarOrScoreCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/12/28.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BossRechargeScoreCell.h"


@interface BossRechargeScoreCell ()

/** 年月日 */
@property (nonatomic,weak) UILabel *dateLable;

/** 时间 */
@property (nonatomic,weak) UILabel *timeLable;

/** 积分数量 */
@property (nonatomic,weak) UILabel *scoreLable;

/** 用户名 */
@property (nonatomic,weak) UILabel *usernameLable;




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

        NSArray *arr = @[@"2018-12-34",@"12:34:20",@"80808908098",@"李四"];
        
        CGFloat count = 4;
        CGFloat width = KScreenWidth / 3;
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
                    
                    
                default:
                    break;
            }
            
            
            [self.contentView addSubview:label];
        }
        
        
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


@end
