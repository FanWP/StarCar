//
//  YYUITextView.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYUITextView : UITextView

/**  占位文字*/
@property(nonatomic,copy)NSString *placeholder;
/**  占位文字的颜色*/
@property(nonatomic,strong)UIColor *placeholderColor;

@end
