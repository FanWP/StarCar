//
//  YYUITextView.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "YYUITextView.h"

@implementation YYUITextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //不要设置代理
        //        self.delegate = self;一个代理只能设置一次
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChanges) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}


- (void)textDidChanges
{
    //重绘（重新调用）
    [self setNeedsDisplay];
    
}


//lable也可以做
//画文字，每次调用都会重新再画，之前的会擦掉
-(void)drawRect:(CGRect)rect
{
    //如果有输入文字就不画占位文字
    if (self.hasText) return;
    //文字的属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    //画文字
    //    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    CGFloat X = 5;
    CGFloat Y = 8;
    CGFloat W = rect.size.width -2 * X;
    CGFloat H = rect.size.height - 2 *Y;
    CGRect placeholderrect = CGRectMake(X, Y, W,H );
    [self.placeholder drawInRect:placeholderrect withAttributes:attrs];
    
}


-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
    
}

-(void)setPlaceholder:(NSString *)placeholder
{
    
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void) setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
    
}


-(void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

