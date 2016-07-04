//
//  HeaderCell.m
//  FRWeather_02
//
//  Created by framgia on 6/16/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "HeaderItem.h"

@implementation HeaderItem

- (void)setHeaderData:(WeatherModel *)weatherModel {
    if (weatherModel.timeHour) {
        self.time.text = [NSString stringWithFormat:@"%@h",weatherModel.timeHour];
    }
    if (weatherModel.weatherIcon) {
        self.iconWeather.image = [UIImage imageNamed:weatherModel.weatherIcon];
    }
    
    if (weatherModel.temp) {
        self.temp.text = [NSString stringWithFormat:@"%@°",weatherModel.temp];
    }
}

@end
