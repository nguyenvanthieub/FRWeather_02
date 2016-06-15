//
//  ForecastTableViewCell.h
//  FRWeather_02
//
//  Created by framgia on 6/15/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForecastModel.h"

@interface ForecastTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayForecast;
@property (weak, nonatomic) IBOutlet UIImageView *imageForecast;
@property (weak, nonatomic) IBOutlet UILabel *tempMax;
@property (weak, nonatomic) IBOutlet UILabel *tempMin;

- (void)setCellData:(WeatherModel *)weatherModel;

@end
