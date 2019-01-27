//
//  AppDelegate.m
//  JRChatTest
//
//  Created by ma qianli on 2019/1/25.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "AppDelegate.h"
#import <SobotKit/SobotKit.h>
#import <UserNotifications/UserNotifications.h>
//系统版本是否大于等于v
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()<UNUserNotificationCenterDelegate>
    
@property(nonatomic, strong) NSDictionary *launchNotification;

@end

@implementation AppDelegate

-(void)initZC{
    //根据此设置调用的推送证书
    [[ZCLibClient getZCLibClient] setIsDebugMode:YES];
    // 错误日志收集
    [ZCLibClient setZCLibUncaughtExceptionHandler];
    
    // 添加用户画像
    // [[ZCLibClient getZCLibClient] initSobotSDK:@"请输入你的appkey"];
    [[ZCLibClient getZCLibClient] initSobotSDK:@"2c571948e96247fead08f23b6bb01c92"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self registerUserNotificationSettings];
    
    [self initZC];
    
    //程序未启动时，收到远程推送,保存下来，在应用进入前台后可以处理。
    _launchNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    return YES;
}

// This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
//NS_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}
    
-(void)registerUserNotificationSettings{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须设置代理，不然无法监听通知的接收与点击
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 点击允许
                [[UIApplication sharedApplication] registerForRemoteNotifications];NSLog(@"注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
            } else {
                // 点击不允许
                NSLog(@"注册失败");
            }
        }];
    } else {
        // Fallback on earlier versions
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}
    
    
/*
处理推送必须是通过点击通知进入，收到通知，点应用进入不会触发通知处理的方法。

程序未启动，收到通知，系统展示通知栏，点击进入：
此时程序启动，会响应- (BOOL)application:(UIApplication )application didFinishLaunchingWithOptions:(NSDictionary )launchOptions 方法，在该方法中，可以通过[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];拿到未启动时收到的推送信息，之后怎么处理，就按需求来了。
程序已启动，在后台，收到通知，系统展示通知栏，点击进入：
此时程序会响应- (void)application:(UIApplication )application didReceiveRemoteNotification:(NSDictionary )userInfo方法，userInfo就是需要信息内容。
程序已启动，在前台，收到通知，系统不展示通知栏：
此时程序会响应- (void)application:(UIApplication )application didReceiveRemoteNotification:(NSDictionary )userInfo方法，userInfo就是需要信息内容。
可以看到程序在启动的情况下，不管在前台还是后台，都会进入到- (void)application:(UIApplication )application didReceiveRemoteNotification:(NSDictionary )userInfo方法中，区别只是系统会不会进行通知栏弹窗，如果想要前台弹窗，就需要自己去做效果了。
另外可以通过application.applicationState != UIApplicationStateActive来判断当前app前后台的状态，进而分别处理。
*/
//10.0之前使用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
}

// iOS 10收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request;  // 收到推送的请求
    UNNotificationContent *content = request.content;       // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;     // 推送消息的声音
    NSString *subtitle = content.subtitle;          // 推送消息的副标题
    NSString *title = content.title;                // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
    }else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置，Alert可以设定前台展示通知栏。
}
    
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"---Token--%@", deviceToken);
    [[ZCLibClient getZCLibClient] setToken: deviceToken];
}
    
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
