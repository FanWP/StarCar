//
//  AppDelegate+JPush.h
//  JPush
//
//  Created by 王陕 on 16/11/17.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
//#import <UserNotifications/UserNotifications.h>



@interface AppDelegate (JPush)<JPUSHRegisterDelegate>

- (void)JPushApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                  appkey:(NSString *)appkey
        apsForProduction:(BOOL)isProduction
             otherConfig:(NSDictionary *)otherConfig;

@end
