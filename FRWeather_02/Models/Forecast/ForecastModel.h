//
//  Forecase.h
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherModel.h"

@interface ForecastModel : NSObject

@property (strong, nonatomic) NSMutableArray *weathers;


-(instancetype)init : (NSDictionary *)jsonDataForecast;


@end
