//
//  CarInputCell.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/4.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CarInputCell.h"

@interface CarInputCell ()



@end

@implementation CarInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}




-(UITextField *)textField
{
    if (_textField == nil)
    {
        _textField = [[UITextField alloc] init];
        _textField.frame = CGRectMake(0, 0, 160, 35);
        _textField.backgroundColor = [UIColor clearColor];
        _textField.backgroundColor =[UIColor colorWithWhite:1 alpha:0];
        self.textField.borderStyle = TFborderStyle;
//        self.textField.placeholder = @"请输入验证码";
        self.textField.font = Font14;
        
//        self.textField.secureTextEntry= YES;
        self.textField.textColor = [UIColor grayColor];
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _textField;
}


// 设置右边视图
- (void)setUpAccessoryView
{
        self.accessoryView = self.textField;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
         self.textLabel.font = Font16;
        [self setUpAccessoryView];
        
    }

    return self;
}



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    CarInputCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[CarInputCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
