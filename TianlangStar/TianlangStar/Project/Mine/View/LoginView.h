//
//  LoginView.h
//  TianlangStar
//
//  Created by youyousiji on 16/10/31.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LoginViewDelegate <NSObject>

@optional

-(void)loginSuccess;

@end


@interface LoginView : UIView




/** RSASessionID */
@property (nonatomic,copy) NSString *RSASessionID;


/** logView登录成功后的代理处理 */
@property (nonatomic,weak) id<LoginViewDelegate> delegate;





@end
