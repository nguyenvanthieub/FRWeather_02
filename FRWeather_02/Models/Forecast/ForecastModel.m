//
//  Forecase.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "ForecastModel.h"

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
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
            NSDateFormatter *weekDay = [[NSDateFormatter alloc]init];
            [weekDay setDateFormat:@"EEEE"];
            weather.time = [weekDay stringFromDate:date];
            
            [forecast.weathers addObject:weather];
        }
    }
    
    return self;
}


@end
