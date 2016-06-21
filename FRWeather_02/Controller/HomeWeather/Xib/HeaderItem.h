//
//  HeaderCell.h
//  FRWeather_02
//
//  Created by framgia on 6/16/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface HeaderItem : UIView

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *iconWeather;
@property (weak, nonatomic) IBOutlet UILabel *temp;

- (void)setHeaderData:(WeatherModel *)weatherModel;

@end
