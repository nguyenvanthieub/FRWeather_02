//
//  AppDelegate.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@import GoogleMaps;
#import "NotificationService.h"
#import "LoginViewController.h"
#import "HomeViewController.h"

#define GOOGLE_MAP_KEY @"AIzaSyD-zpLTnDQhWsjWnUdjUv3bMHi_wVeBulg"


@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginVC = [st instantiateViewControllerWithIdentifier:@"LoginViewController"];
    HomeViewController *homeVC = [st instantiateViewControllerWithIdentifier:@"HomeViewController"];
    UINavigationController *nav;
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    if ([FBSDKAccessToken currentAccessToken]) {
        nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    } else {
        nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    }
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [GMSServices provideAPIKey:GOOGLE_MAP_KEY];
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    [NotificationService initOneSignal:launchOptions];
   
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation];
    return handled;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    NSDictionary *aps = userInfo[@"aps"];
    if (aps) {
        if (application.applicationState == UIApplicationStateBackground) {
            if (aps[@"content-available"]) {
                int contentValue = [aps[@"content-available"] intValue];
                if (contentValue == 1) {
                    [self application:application performFetchWithCompletionHandler:^(UIBackgroundFetchResult result) {
                        completionHandler(result);
                    }];
                }
            }
        }
    }
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [NotificationService pushLocalNotification:^(UIBackgroundFetchResult result) {
        completionHandler(result);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
