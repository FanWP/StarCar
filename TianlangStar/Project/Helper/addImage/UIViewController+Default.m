//
//  UIViewController+Default.m
//  kztool
//
//  Created by 武探 on 16/6/21.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import "UIViewController+Default.h"
#import <objc/message.h>
static BOOL canSetBackButtonTitle;

@implementation UIViewController (Default)

+(void)load {
    canSetBackButtonTitle = [self isVariableWithClass:[UINavigationItem class] varName:@"backButtonTitle"];
}

-(void)defaultViewStyle {
    self.view.backgroundColor = [UIColor whiteColor];
    
    if(canSetBackButtonTitle) {
        if(self.tabBarController == nil) {
            [self.navigationItem setValue:@"" forKey:@"backButtonTitle"];
            
        } else {
            [self.tabBarController.navigationItem setValue:@"" forKey:@"backButtonTitle"];
        }
    }
}

+ (BOOL) isVariableWithClass:(Class) myClass varName:(NSString *)name{	unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

static char const userInfoKey = '\0';

-(void)setUserInfo:(NSObject*)userInfo {
    objc_setAssociatedObject(self, &userInfoKey, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSObject*)userInfo {
    return objc_getAssociatedObject(self, &userInfoKey);
}

@end
