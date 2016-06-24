//
//  APIWeather.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "APIWeather.h"

@implementation APIWeather

- (void)getDataWeather:(NSString *)url andPosition:(Position *)position complete:(void(^)(WeatherModel *weather))completeBlock {
    
    NSDictionary *param = @{ @"lat": [NSString stringWithFormat:@"%f",position.lat],
                             @"lon": [NSString stringWithFormat:@"%f",position.lon],
                             @"units" : @"metric",
                             @"appid" : APPID};
    [NetworkService getData: url
                       parameter: param
                        complete: ^(NSDictionary *data, NSError *error) {
                            
                            WeatherModel *weather = [[WeatherModel alloc]init:data];
                            completeBlock(weather);
                        }];
}

- (void)getDataForecast:(NSString *)url andPosition:(Position *)position isForecast:(BOOL)isForecast complete: (void(^)(ForecastModel *forecast))completeBlock {
    NSDictionary *param = [NSDictionary new];
    if (isForecast) {
        param = @{ @"lat": [NSString stringWithFormat:@"%f",position.lat],
                   @"lon": [NSString stringWithFormat:@"%f",position.lon],
                   @"units" : @"metric",
                   @"mode" : @"json",
                   @"cnt" : @"7",
                   @"appid" : APPID};
    } else {
        param = @{ @"lat": [NSString stringWithFormat:@"%f",position.lat],
                   @"lon": [NSString stringWithFormat:@"%f",position.lon],
                   @"units" : @"metric",
                   @"appid" : APPID};
    }
    [NetworkService getData:url
                       parameter:param
                        complete:^(NSDictionary *data, NSError *error) {
                            ForecastModel *forecast = [[ForecastModel alloc]init:data];
                            completeBlock(forecast);
                        }];
}

@end
