//
//  Common.h
//  FRWeather_02
//
//  Created by framgia on 6/16/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface Common : NSObject
+ (NSString *)convertIntervalToDay:(double )interval;
+ (NSString *)convertStringToHour:(NSString *)timeString;
+ (void)saveListCity:(NSMutableArray *)weatherCityArray;
+ (NSArray *)getListCity;
+ (Position *)getCurrentPosition;
+ (void)setCurrentPosition:(Position *)position;
@end
