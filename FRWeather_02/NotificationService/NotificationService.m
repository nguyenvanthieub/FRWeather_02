//
//  NotificationService.m
//  FRWeather_02
//
//  Created by framgia on 6/29/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "NotificationService.h"
#import "APIWeather.h"
#import "Common.h"
#import "WeatherModel.h"
#import "NetworkService.h"
#import "OneSignal/OneSignal.h"


#define ONESIGNAL_KEY @"307830d9-dfe7-4ba0-aa5b-be5bf805e9bd"

@implementation NotificationService

+ (void)initOneSignal:(NSDictionary *)options {
    OneSignal *oneSignal = [[OneSignal alloc] initWithLaunchOptions:options appId:ONESIGNAL_KEY handleNotification:nil];
    [oneSignal enableInAppAlertNotification:NO];
}

+ (void)pushLocalNotification:(void (^)(UIBackgroundFetchResult))completionHandler {
    APIWeather *apiWeather = [APIWeather new];
    Position *position = [Common getCurrentPosition];
    [apiWeather getDataForecast:URL_FORECAST_DAY andPosition:position isForecast:TRUE complete:^(ForecastModel *forecast) {
        if (forecast) {
            WeatherModel *weatherTomorrow = [forecast.weathers objectAtIndex:1];
            NSString *message = [NSString stringWithFormat:@"Main: %@, description: %@",weatherTomorrow.weatherName,weatherTomorrow.weatherDescription];
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0]; //Enter the time here in seconds.
            localNotification.alertBody= message;
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            localNotification.repeatInterval= NSCalendarUnitDay;
            localNotification.soundName= UILocalNotificationDefaultSoundName;
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            completionHandler(UIBackgroundFetchResultNewData);
        } else {
            completionHandler(UIBackgroundFetchResultFailed);
        }
    }];
}

@end
