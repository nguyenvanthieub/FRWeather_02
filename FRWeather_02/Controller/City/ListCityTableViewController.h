//
//  CityTableViewController.h
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCityTableViewController.h"
#import "Position.h"
#import "Common.h"
@import GoogleMaps;

@protocol GetWeatherWithPositionDelegate <NSObject>
- (void)getWeatherPosition:(Position *)position;
@end

@interface ListCityTableViewController : UITableViewController
@property (weak, nonatomic) id<GetWeatherWithPositionDelegate> delegate;
@end
