//
//  HomeViewController.h
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWeather.h"
#import "ForecastTableViewCell.h"
#import "HeaderTableViewCell.h"
#import "FacebookService.h"
@import GoogleMaps;

@interface HomeViewController : UIViewController

@property (strong, nonatomic) APIWeather *apiWeather;

@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescription;
@property (weak, nonatomic) IBOutlet UILabel *weatherTmp;

@property (weak, nonatomic) IBOutlet UITableView *tableViewForecast;

@property (strong, nonatomic) NSMutableArray *weatherDays;
@property (strong, nonatomic) NSMutableArray *weatherHours;



@end
