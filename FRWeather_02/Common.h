//
//  Common.h
//  FRWeather_02
//
//  Created by framgia on 6/16/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject
+ (NSString *)convertIntervalToDay:(double )interval;
+ (NSString *)convertStringToHour:(NSString *)timeString;
@end
