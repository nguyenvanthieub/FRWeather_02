//
//  APIWeather.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "APIWeather.h"

@implementation APIWeather


- (void)getDataWeather:(NSString *)url complete:(void(^)(WeatherModel *weather))completeBlock{
    
    [NetworkService getData: url
                       parameter: nil
                        complete: ^(NSDictionary *data, NSError *error) {
                            
                            WeatherModel *weather = [[WeatherModel alloc]init:data];
                            completeBlock(weather);
                        }];
}

- (void)getDataForecast:(NSString *)url complete:(void(^)(ForecastModel *forecast))completeBlock {
    [NetworkService getData:url
                       parameter:nil
                        complete:^(NSDictionary *data, NSError *error) {
                            
                            ForecastModel *forecast = [[ForecastModel alloc]init:data];
                            completeBlock(forecast);
                        }];
}

@end
