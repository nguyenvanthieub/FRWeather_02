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
    self.time.text = weatherModel.timeHour;
    self.iconWeather.image = [UIImage imageNamed:weatherModel.weatherIcon];
    self.temp.text = weatherModel.temp;
}

@end
