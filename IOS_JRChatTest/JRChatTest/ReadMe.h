//
//  ReadMe.h
//  JRChatTest
//
//  Created by ma qianli on 2019/1/26.
//  Copyright © 2019 ma qianli. All rights reserved.
//

由于iOS不断更新，推送相关的配置方法也不断变化，iOS8，iOS 10分别更新了一些方法，废弃了一系列方法

[8_0, 10_0)
 // This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
 //NS_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
 - (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
 
 UIUserNotificationType
 
 UIUserNotificationSettings
 
 - (void)registerUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
 
 
[10_0, ]
iOS 10推荐的推送处理方式：
优点：

通知处理代码可以从AppDelegate中剥离。
通知的注册，设置，处理更加结构化，更易于模块化开发。
UserNotification支持自定义通知音效和启动图。
UserNotification支持向通知内容中添加媒体附件，例如音频，视频。
UserNotification支持开发者定义多套通知模板。
UserNotification支持完全自定义的通知界面。
UserNotification支持自定义通知中的用户交互按钮。
通知的触发更加容易管理。

