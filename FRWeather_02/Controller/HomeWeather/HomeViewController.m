//
//  HomeViewController.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "HomeViewController.h"
#define CELL_HEIGHT 95
#define FOOTER_HEIGHT 300

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource> {
    GMSMapView *mapView;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.apiWeather = [APIWeather new];
    [self requestData];
}

- (UIView *)setupGoogleMap {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:21.016969
                                                            longitude:105.784196
                                                                 zoom:20];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.settings.compassButton = YES;
    mapView.settings.myLocationButton = YES;
    
    // Listen to the myLocation property of GMSMapView.
    [mapView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView.myLocationEnabled = YES;
    });
    
    return mapView;
}



- (void)requestData {
    
    __block HomeViewController  *weakSelf = self;
    
    [self.apiWeather getDataWeather:URL_API_WEATHER complete:^(WeatherModel *weather) {
        weakSelf.city.text = weather.nameCity;
        weakSelf.weatherDescription.text = weather.weatherName;
        weakSelf.weatherTmp.text = [NSString stringWithFormat:@"%@ °",weather.temp_min];
    }];
    
    [self.apiWeather getDataForecast:URL_API_FORECAST_DAY complete:^(ForecastModel *forecast) {
        weakSelf.weatherDays = forecast.weathers;
    }];
    
    [self.apiWeather getDataForecast:URL_API_FORECAST_HOUR complete:^(ForecastModel *forecast) {
        weakSelf.weatherHours = forecast.weathers;
        [weakSelf.tableViewForecast reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weatherDays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forecastCell" forIndexPath:indexPath];
    
    WeatherModel *weatherItem = [self.weatherDays objectAtIndex:indexPath.row];
    [cell setCellData:weatherItem];
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    
    [headerCell setScrollData:self.weatherHours];
    return headerCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FOOTER_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *mapView = [UIView new];
    
    
    
    return mapView;
}

@end
