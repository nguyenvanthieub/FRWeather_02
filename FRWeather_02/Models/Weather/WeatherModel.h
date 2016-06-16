//
//  Weather.h
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property (strong, nonatomic) NSString *weatherId;
@property (strong, nonatomic) NSString *weatherName;
@property (strong, nonatomic) NSString *weatherDescription;
@property (strong, nonatomic) NSString *weatherIcon;

@property (strong, nonatomic) NSString *temp;
@property (strong, nonatomic) NSString *temp_min;
@property (strong, nonatomic) NSString *temp_max;
@property (strong, nonatomic) NSString *humidity;

@property (strong, nonatomic) NSString *windSpeed;
@property (strong, nonatomic) NSString *windDeg;

@property (strong, nonatomic) NSString *nameCity;

@property (strong, nonatomic) NSString *timeDay;
@property (strong, nonatomic) NSString *timeHour;

-(instancetype)init : (NSDictionary *)jsonData;

@end
