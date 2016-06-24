//
//  APIWeather.h
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkService.h"
#import "ForecastModel.h"
#import "WeatherModel.h"
#import "Position.h"

@interface APIWeather : NSObject

- (void)getDataWeather:(NSString *)url andPosition:(Position *)position complete:(void(^)(WeatherModel *weather))completeBlock;
- (void)getDataForecast:(NSString *)url andPosition:(Position *)position isForecast:(BOOL)isForecast complete: (void(^)(ForecastModel *forecast))completeBlock;

@end