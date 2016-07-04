//
//  ForecastTableViewCell.m
//  FRWeather_02
//
//  Created by framgia on 6/15/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "ForecastTableViewCell.h"

@implementation ForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(WeatherModel *)weatherModel {
    self.dayForecast.text = weatherModel.timeDay;
    self.imageForecast.image = [UIImage imageNamed:weatherModel.weatherIcon];
    if (weatherModel.temp_max) {
        self.tempMax.text = [NSString stringWithFormat:@"%@°",weatherModel.temp_max];
    }
    if (weatherModel.temp_min) {
        self.tempMin.text = [NSString stringWithFormat:@"%@°",weatherModel.temp_min];
    }
}

@end
