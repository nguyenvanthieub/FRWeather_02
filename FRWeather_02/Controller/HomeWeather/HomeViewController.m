//
//  HomeViewController.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.apiWeather = [APIWeather new];
    [self requestData];
}

- (void)requestData {
    
    __block HomeViewController  *weakSelf = self;
    
    [self.apiWeather getDataWeather:URL_API_WEATHER complete:^(WeatherModel *weather) {
        weakSelf.city.text = weather.nameCity;
        weakSelf.weatherDescription.text = weather.weatherName;
        weakSelf.weatherTmp.text = [NSString stringWithFormat:@"%@ °",weather.temp_min];
    }];
    
    
    [self.apiWeather getDataForecast:URL_API_FORECAST complete:^(ForecastModel *forecast) {
        weakSelf.weathers = forecast.weathers;
        [weakSelf.tableViewForecast reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weathers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    WeatherModel *weatherItem = [self.weathers objectAtIndex:indexPath.row];
    [cell setCellData:weatherItem];
    
    return  cell;
}

@end
