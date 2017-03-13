//
//  AppDelegate+JPush.m
//  JPush
//
//  Created by 王陕 on 16/11/17.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import <UserNotifications/UserNotifications.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ParkTool.h"
#import "DataBase.h"
#import "Message.h"

//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;


void JPushSystemSoundFinishedPlayingCallback(SystemSoundID sound_id, void* user_data)
{
    AudioServicesDisposeSystemSoundID(sound_id);
}


@implementation AppDelegate (JPush)

- (void)JPushApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apsForProduction:(BOOL)isProduction
               otherConfig:(NSDictionary *)otherConfig {
    
    
    // 初始化sdk
    [JPUSHService setupWithOption:launchOptions appKey:appkey
                          channel:@"App Store"
                 apsForProduction:isProduction];
    
    // 获取registrationID
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSLog(@"resCode : %d,registrationID: %@",resCode,registrationID);
        //存储registrationID
        [ParkTool saveJpushRegistationID:registrationID];
    }];
    
    //注册apns远程推送
    [self registerRemoteNotification];
    
}





/** 注册APNs远程推送 */
- (void)registerRemoteNotification{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
}


/** APNs 注册成功回调, 返回deviceToken */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"注册apns成功");
    
    //将deviceToken 传给JPush SDK
    [JPUSHService registerDeviceToken:deviceToken];
}

/** 注册APNs失败 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"注册apns失败 Error: %@", error);
}




/***************             APNs离线推送回调方法         ******************/
#pragma mark - 处理APNs通知回调方法
#pragma mark  JPUSHRegisterDelegate



#pragma mark - 处理
static long msgID = 0;
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    
    [self showNotification:notification];
    
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {// 判断为远程通知
        
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
        [JPUSHService handleRemoteNotification:userInfo];
        
        
    }
    else {// 判断为本地通知
        
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    
    
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    
    NSNumber *_j_msgid = notification.request.content.userInfo[@"_j_msgid"];
    if ([_j_msgid longValue] != msgID) {
        
        
        msgID = [_j_msgid longValue];
        Message *msg = [[Message alloc] init];
        msg.Msg = content.body;
        msg.userId = @1;
        DataBase *dbManager = [DataBase sharedManager];
        [dbManager insertMsg:msg];
        
    }
    
    
    
}



// iOS 10 Support
// 通知的点击事件
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler(UNNotificationPresentationOptionAlert);  // 系统要求执行这个方法
    
    
//    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
    
    
    NSNumber *_j_msgid = userInfo[@"_j_msgid"];
    
    if ([_j_msgid longValue] != msgID) {
        
        msgID = [_j_msgid longValue];
        Message *msg = [[Message alloc] init];
        msg.Msg = content.body;
        msg.userId = @1;
        DataBase *dbManager = [DataBase sharedManager];
        [dbManager insertMsg:msg];
        
    }
    
//        Message *msg = [[Message alloc] initWithJsonString:userInfo[@"aps"][@"alert"]];
    
//    }
    
    
    
    //跳转到消息页面
    MessageViewController *infoVC = [[MessageViewController alloc] init];
    infoVC.title = @"消息中心";
    infoVC.hidesBottomBarWhenPushed = YES;
    if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav= (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:infoVC animated:YES];
    }else{
        
        MainTabViewController *mainVC = (MainTabViewController *)self.window.rootViewController;
        UINavigationController *nav= (UINavigationController *)mainVC.selectedViewController;
        if (![nav.childViewControllers.lastObject isKindOfClass:[MessageViewController class]]) {
//            [nav popViewControllerAnimated:NO];
            [nav pushViewController:infoVC animated:YES];
        }else{
            [nav popViewControllerAnimated:NO];
            [nav pushViewController:infoVC animated:NO];
        }
        
    }
    
    
}


//iOS10
- (void)showNotification:(UNNotification *)notification {
    
    
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    
    UNNotificationRequest *request1 = notification.request; // 收到推送的请求
    UNNotificationContent *content1 = request1.content; // 收到推送的消息内容
    
    NSNumber *badge = content1.badge;  // 推送消息的角标
    NSString *body = content1.body;    // 推送消息体
    UNNotificationSound *sound = content1.sound;  // 推送消息的声音
    NSString *subtitle = content1.subtitle;  // 推送消息的副标题
    NSString *title = content1.title;  // 推送消息的标题
    
    
    
    
    
    JPushNotificationContent *content = [[JPushNotificationContent alloc] init];
    content.body = body;
    content.badge = @1;
    content.action = @"action";
    JPushNotificationTrigger *trigger = [[JPushNotificationTrigger alloc] init];
    

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        trigger.timeInterval = [[NSDate date] timeIntervalSinceNow]; // iOS10以上有效
    }
    else {
        trigger.fireDate = [NSDate date]; // iOS10以下有效
    }
    JPushNotificationRequest *request = [[JPushNotificationRequest alloc] init];
    request.content = content;
    request.trigger = trigger;
    request.requestIdentifier = @"test";
    request.completionHandler = ^(id result) {
        NSLog(@"%@", result); // iOS10以上成功则result为UNNotificationRequest对象，失败则result为nil;iOS10以下成功result为UILocalNotification对象，失败则result为nil
        
    };
    [JPUSHService addNotification:request];

    [self playSoundAndVibration];
}




#pragma mark - 处理
// iOS 7 Support
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"iOS7及以上系统，收到通知:%@", userInfo);
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
//    [self playSoundAndVibration];
    
    
    //发送本地推送
    UILocalNotification *notification1 = [[UILocalNotification alloc] init];
    notification1.fireDate = [NSDate date]; //触发通知的时间
    notification1.userInfo = userInfo;
    
    notification1.alertAction = NSLocalizedString(@"open", @"Open");
    notification1.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification1.soundName = UILocalNotificationDefaultSoundName;
    }
    
    
    NSDictionary   *aps = [userInfo valueForKey:@"aps"];
    NSString   *content = [aps valueForKey:@"alert"];//推送显示的内容
    NSLog(@"收到通知:%@", content);
    
    
    
    Message *msg = [[Message alloc] init];
    msg.Msg = content;
    msg.userId = @1;
//    msg.FunctionId = @1;
    DataBase *dbManager = [DataBase sharedManager];
    [dbManager insertMsg:msg];
    
    
    
    //跳转到消息页面
    MessageViewController *infoVC = [[MessageViewController alloc] init];
    infoVC.title = @"消息中心";
    infoVC.hidesBottomBarWhenPushed = YES;
    if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav= (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:infoVC animated:YES];
    }else{
        
        MainTabViewController *mainVC = (MainTabViewController *)self.window.rootViewController;
        UINavigationController *nav= (UINavigationController *)mainVC.selectedViewController;
        if (![nav.childViewControllers.lastObject isKindOfClass:[MessageViewController class]]) {
            //            [nav popViewControllerAnimated:NO];
            [nav pushViewController:infoVC animated:YES];
        }else{
            [nav popViewControllerAnimated:NO];
            [nav pushViewController:infoVC animated:NO];
        }
        
    }
    
    
    
}

//iOS 7-
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    [self playSoundAndVibration];
    
    
}




// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

/***************             本地推送回调方法         ******************/
#pragma mark - 处理本地推送回调方法
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    NSLog(@"本地推送: %@", notification);
    NSLog(@"消息内容: %@", notification.alertBody);
    
    
//    NSDictionary   *aps = [userInfo valueForKey:@"aps"];
//    NSString   *content = [aps valueForKey:@"alert"];//推送显示的内容
//    NSLog(@"收到通知:%@", content);
    
    
    
    Message *msg = [[Message alloc] init];
    msg.Msg = notification.alertBody;
    msg.userId = @1;
    DataBase *dbManager = [DataBase sharedManager];
    [dbManager insertMsg:msg];
    
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
    
#if !TARGET_IPHONE_SIMULATOR
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    switch (state) {
        case UIApplicationStateActive:
            [self playSoundAndVibration];
            break;
        case UIApplicationStateInactive:
            [self playSoundAndVibration];
            break;
        case UIApplicationStateBackground:
            [self showNotificationWithLocalNotification:notification];
            
            break;
        default:
            break;
    }
#endif
    
    [self playSoundAndVibration];
    [self showNotificationWithLocalNotification:notification];
}






// iOS7
- (void)showNotificationWithLocalNotification:(UILocalNotification *)notification {
    
    
    
    
    
    
    
    
//    EMPushOptions *options = [[EMClient sharedClient] pushOptions];
//    options.displayStyle = EMPushDisplayStyleMessageSummary;
//    
//    //发送本地推送
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    notification.fireDate = [NSDate date]; //触发通知的时间
//    
//    if (options.displayStyle == EMPushDisplayStyleMessageSummary) {
//        EMMessageBody *messageBody = message.body;
//        NSString *messageStr = nil;
//        switch (messageBody.type) {
//            case EMMessageBodyTypeText:
//            {
//                messageStr = ((EMTextMessageBody *)messageBody).text;
//            }
//                break;
//            case EMMessageBodyTypeImage:
//            {
//                messageStr = NSLocalizedString(@"message.image", @"Image");
//            }
//                break;
//            case EMMessageBodyTypeLocation:
//            {
//                messageStr = NSLocalizedString(@"message.location", @"Location");
//            }
//                break;
//            case EMMessageBodyTypeVoice:
//            {
//                messageStr = NSLocalizedString(@"message.voice", @"Voice");
//            }
//                break;
//            case EMMessageBodyTypeVideo:{
//                messageStr = NSLocalizedString(@"message.video", @"Video");
//            }
//                break;
//            default:
//                break;
//        }
//        NSData *data = [messageStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        notification.alertBody = [NSString stringWithFormat:@"%@",  dict[@"content"]];
//    }
//    else{
//        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
//    }
//    
//#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
//    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
//    
//    notification.alertAction = NSLocalizedString(@"open", @"Open");
//    notification.timeZone = [NSTimeZone defaultTimeZone];
//    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
//    if (timeInterval < kDefaultPlaySoundInterval) {
//        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
//    } else {
//        notification.soundName = UILocalNotificationDefaultSoundName;
//        //        self.lastPlaySoundDate = [NSDate date];
//    }
//    
//    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//    [userInfo setObject:[NSNumber numberWithInt:message.chatType] forKey:kMessageType];
//    [userInfo setObject:message.conversationId forKey:kConversationChatter];
//    notification.userInfo = userInfo;
//    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
    
    
    
    NSLog(@"%@", notification);
    
    NSLog(@"发送通知，智慧园区");
    
}


- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    //收到消息时,播放音频
    [self playNewMessageSound];
    //收到消息时,震动
    [self playVibration];
    
}


//播放声音
- (void)playNewMessageSound {
    
    // Path for the audio file
//    NSURL *bundlePath = [[NSBundle mainBundle] URLForResource:@"EaseUIResource" withExtension:@"bundle"];
//    NSURL *audioPath = [[NSBundle bundleWithURL:bundlePath] URLForResource:@"in" withExtension:@"caf"];
    
    NSURL *audioPath1 = [NSURL URLWithString:@"/System/Library/Audio/UISounds/ReceivedMessage.caf"];
    NSURL *audioPath = [NSURL fileURLWithPath:@"/System/Library/Audio/UISounds/sms-received5.caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(audioPath), &soundID);
    // Register the sound completion callback.
    AudioServicesAddSystemSoundCompletion(soundID,
                                          NULL, // uses the main run loop
                                          NULL, // uses kCFRunLoopDefaultMode
                                          JPushSystemSoundFinishedPlayingCallback, // the name of our custom callback function
                                          NULL // for user data, but we don't need to do that in this case, so we just pass NULL
                                          );
    
    AudioServicesPlaySystemSound(soundID);
}
//震动
- (void)playVibration
{
    // Register the sound completion callback.
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate,
                                          NULL, // uses the main run loop
                                          NULL, // uses kCFRunLoopDefaultMode
                                          JPushSystemSoundFinishedPlayingCallback, // the name of our custom callback function
                                          NULL // for user data, but we don't need to do that in this case, so we just pass NULL
                                          );
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}




@end
