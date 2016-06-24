//
//  Weather.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

-(instancetype)init:(NSDictionary *)jsonData {
    self = [super init];
    if (self != nil) {
        WeatherModel *weather = self;
        
        NSDictionary *dicWeather = [[jsonData objectForKey:@"weather"] objectAtIndex:0];
        weather.weatherId = [dicWeather objectForKey:@"id"];
        weather.weatherName = [dicWeather objectForKey:@"main"];
        weather.weatherDescription = [dicWeather objectForKey:@"description"];
        weather.weatherIcon = [dicWeather objectForKey:@"icon"];
        
        NSDictionary *dicMain = [jsonData objectForKey:@"main"];
        int temp = [[[dicMain objectForKey:@"temp"] stringValue] intValue];
        weather.temp = [NSString stringWithFormat:@"%d",temp];
        int temp_min = [[[dicMain objectForKey:@"temp_min"] stringValue] intValue];
        weather.temp_min = [NSString stringWithFormat:@"%d",temp_min];
        int temp_max = [[[dicMain objectForKey:@"temp_max"] stringValue] intValue];
        weather.temp_max = [NSString stringWithFormat:@"%d",temp_max];
        weather.humidity = [dicMain objectForKey:@"humidity"];
        
        NSDictionary *dicWind = [jsonData objectForKey:@"wind"];
        weather.windSpeed = [dicWind objectForKey:@"speed"];
        weather.windDeg = [dicWind objectForKey:@"deg"];
        weather.nameCity = [jsonData objectForKey:@"name"];
    }
    
    return self;
}

@end
