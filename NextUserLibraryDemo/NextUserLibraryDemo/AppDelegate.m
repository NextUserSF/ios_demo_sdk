#import "AppDelegate.h"


@implementation AppDelegate

/// <#Description#>
/// @param application <#application description#>
/// @param launchOptions <#launchOptions description#>
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NextUser tracker] initializeWithApplication:application withLaunchOptions:launchOptions];
    
//    //configure firebase
    [FIRApp configure];
    [FIRMessaging messaging].delegate = self;

    //if your app is registering for notifications
   [UNUserNotificationCenter currentNotificationCenter].delegate = self;
   UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
   UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
   [[UNUserNotificationCenter currentNotificationCenter]
   requestAuthorizationWithOptions:authOptions
   completionHandler:^(BOOL granted, NSError * _Nullable error) {
       NSLog(@"Couldd not register for notifications: %@", error);
     }];
    [application registerForRemoteNotifications];
    
    //if not Nextuser will register for notifications
    //[[NextUser notifications] requestNotificationsPermissions];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"Received remote notification/message with completion handler: %@", userInfo);
    [[NextUser notifications] didReceiveRemoteNotification: userInfo withCompletion:^(BOOL success, NSError * error) {
        if (success) {
            completionHandler(UIBackgroundFetchResultNewData);
        } else {
            completionHandler(UIBackgroundFetchResultFailed);
        }
    }] ;
}
    

// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
  NSDictionary *userInfo = notification.request.content.userInfo;

    [[NextUser notifications] didReceiveRemoteNotification: userInfo];
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert);
}

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    [[NextUser notifications] submitFCMRegistrationToken:fcmToken withCompletion:^(BOOL success, NSError * error){
        NSLog(@"didReceiveRegistrationToken with success: %@ and error: %@", success ? @"YES" : @"NO", error);
    }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[NextUser notifications] unregisterFCMRegistrationToken];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler __IOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __TVOS_PROHIBITED
{
    [[NextUser notifications] didReceiveNotificationResponse:response];
    completionHandler();
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
