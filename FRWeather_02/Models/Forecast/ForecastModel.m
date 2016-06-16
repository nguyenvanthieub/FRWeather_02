//
//  Forecase.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "ForecastModel.h"
#import "Common.h"

@implementation ForecastModel

-(instancetype)init:(NSDictionary *)jsonDataForecast {
    self = [super init];
    if (self != nil) {
        
        ForecastModel *forecast = self;
        
        self.weathers = [NSMutableArray new];
        
        NSArray *arrWeather = [jsonDataForecast objectForKey:@"list"];
        
        for (int i = 0; i < arrWeather.count; i++) {
            WeatherModel *weather = [WeatherModel new];
            
            NSDictionary *item = arrWeather[i];
            
            NSDictionary *dicWeather = [[item objectForKey:@"weather"]objectAtIndex:0];
            weather.weatherName = [dicWeather objectForKey:@"main"];
            weather.weatherDescription = [dicWeather objectForKey:@"description"];
            weather.weatherIcon = [dicWeather objectForKey:@"icon"];
            
            NSDictionary *dicTemp = [item objectForKey:@"temp"];
            int temp = [[[dicTemp objectForKey:@"day"] stringValue] intValue];
            weather.temp = [NSString stringWithFormat:@"%d",temp];
            int temp_min = [[[dicTemp objectForKey:@"min"] stringValue] intValue];
            weather.temp_min = [NSString stringWithFormat:@"%d",temp_min];
            int temp_max = [[[dicTemp objectForKey:@"max"] stringValue]intValue];
            weather.temp_max = [NSString stringWithFormat:@"%d",temp_max];
            
            NSTimeInterval interval = [[item objectForKey:@"dt"] doubleValue];
            weather.timeDay = [Common convertIntervalToDay:interval];
            
            NSString *timeHour = [item objectForKey:@"dt_txt"];
            if (timeHour) {
                weather.timeHour = [Common convertStringToHour:timeHour];
            }
            
            NSDictionary *dicMain = [item objectForKey:@"main"];
            if (dicMain) {
                temp = [[[dicMain objectForKey:@"temp"] stringValue] intValue];
                weather.temp = [NSString stringWithFormat:@"%d",temp];
            }
            
            [forecast.weathers addObject:weather];
        }
    }
    
    return self;
}

@end
