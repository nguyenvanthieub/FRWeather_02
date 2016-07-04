//
//  Common.m
//  FRWeather_02
//
//  Created by framgia on 6/16/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (NSString *)convertIntervalToDay:(double )interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dayFormat = [[NSDateFormatter alloc]init];
    [dayFormat setDateFormat:@"EEEE"];
    return [dayFormat stringFromDate:date];
}

+ (NSString *)convertStringToHour:(NSString *)timeString {
    NSDateFormatter *dayFormat = [[NSDateFormatter alloc]init];
    [dayFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *dateHour = [dayFormat dateFromString:timeString];
    [dayFormat setDateFormat:@"HH"];
    return [dayFormat stringFromDate:dateHour];
}

+ (void)saveListCity:(NSMutableArray *)weatherCityArray {
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:weatherCityArray];
    [userDefault setObject:myEncodedObject forKey:[NSString stringWithFormat:@"listCity"]];
}

+ (NSArray *)getListCity {
    NSArray *decodedArray = [NSArray new];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *decodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"listCity"]];
    decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: decodedObject];
    return decodedArray;
}

+ (Position *)getCurrentPosition {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    double lat = [userDefault doubleForKey:@"currentLat"];
    double lon = [userDefault doubleForKey:@"currentLon"];
    //default hanoi
    if (lat == 0.0 && lon == 0.0) {
        lat = 21.0245;
        lon = 105.84117;
    }
    Position *position = [Position new];
    position.lat = lat;
    position.lon = lon;
    return position;
}

+ (void)setCurrentPosition:(Position *)city {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setDouble:city.lat forKey:@"currentLat"];
    [userDefault setDouble:city.lon forKey:@"currentLon"];
    [userDefault synchronize];
}

@end
