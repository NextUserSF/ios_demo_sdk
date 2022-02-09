#import <UIKit/UIKit.h>
@import Firebase;
@import NextUser;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate, FIRMessagingDelegate>
@property (strong, nonatomic) UIWindow *window;
@end
