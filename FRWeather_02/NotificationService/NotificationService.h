//
//  NotificationService.h
//  FRWeather_02
//
//  Created by framgia on 6/29/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationService : NSObject

+ (void)initOneSignal: (NSDictionary *) options;
+ (void)pushLocalNotification:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
