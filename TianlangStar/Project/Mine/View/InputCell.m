//
//  InputCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "InputCell.h"

@implementation InputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    InputCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[InputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.x = 30;
        lable.y = 10;
        lable.width = 80;
        lable.height = 30;
        self.leftLB = lable;
        [self.contentView addSubview:lable];
        

        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(KScreenWidth * 0.3, 10, KScreenWidth - CGRectGetMaxX(lable.frame) - 10, 35);
        textField.backgroundColor = [UIColor clearColor];
        textField.backgroundColor =[UIColor colorWithWhite:1 alpha:0];
        self.textField = textField;
        //        self.textField.borderStyle = TFborderStyle;
        //        self.textField.placeholder = @"请输入验证码";
        self.textField.font = Font14;
        
        //        self.textField.secureTextEntry= YES;
        self.textField.textColor = [UIColor grayColor];
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:textField];
        
    }

    return self;
}


@end
