//
//  HomeViewController.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "HomeViewController.h"
#import "ListCityTableViewController.h"
#define HEADER_HEIGHT 95
#define CELL_HEIGHT 45

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, GetWeatherWithPositionDelegate> {
    GMSMapView *mapView;
    BOOL firstLocationUpdate;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"HOME";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareFacebook:)];
    self.apiWeather = [APIWeather new];
    [self requestData];
}

- (IBAction)addCity:(id)sender {
    [self goListCity];
}

-(void)goListCity {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListCityTableViewController *listCity = [sb instantiateViewControllerWithIdentifier:@"ListCityTableViewController"];
    listCity.delegate = self;
    [self.navigationController pushViewController:listCity animated:true];
}

- (IBAction)shareFacebook:(id)sender {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [FacebookService shareImage:screenImage message:@"Weather today"];
}

- (void)loadGoogleMap:(Position *)position {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:position.lat
                                                            longitude:position.lon
                                                                 zoom:10];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
}

- (void)requestData {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    double lat = [userDefault doubleForKey:@"currentLat"];
    double lon = [userDefault doubleForKey:@"currentLon"];
    Position *position = [Position new];
    position.lat = lat;
    position.lon = lon;
    [self requestDataPosition:position];
}

- (void)requestDataPosition:(Position *)position {
    __block HomeViewController  *weakSelf = self;
    [self.apiWeather getDataWeather:URL_WEATHER andPosition:position complete:^(WeatherModel *weather) {
        weakSelf.city.text = weather.nameCity;
        weakSelf.weatherDescription.text = weather.weatherName;
        weakSelf.weatherTmp.text = [NSString stringWithFormat:@"%@ °",weather.temp_min];
    }];
    
    [self.apiWeather getDataForecast:URL_FORECAST_DAY andPosition:position isForecast:TRUE complete:^(ForecastModel *forecast) {
        weakSelf.weatherDays = forecast.weathers;
        [weakSelf loadGoogleMap:position];
        [weakSelf.weatherDays addObject:mapView];
    }];
    
    [self.apiWeather getDataForecast:URL_FORECAST_HOUR andPosition:position isForecast:FALSE complete:^(ForecastModel *forecast) {
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
    ForecastTableViewCell *forecastCell = [tableView dequeueReusableCellWithIdentifier:@"forecastCell" forIndexPath:indexPath];
    
    if (indexPath.row == self.weatherDays.count - 1) {
        GMSMapView *view = (GMSMapView *)self.weatherDays[indexPath.row];
        view.frame = CGRectMake(0, 0, forecastCell.frame.size.width, CELL_HEIGHT + 200);
        view.layer.borderWidth = 2.0f;
        view.layer.borderColor = [UIColor blackColor].CGColor;
        [forecastCell.contentView addSubview:view];
    } else {
        WeatherModel *weatherItem = [self.weatherDays objectAtIndex:indexPath.row];
        [forecastCell setCellData:weatherItem];
    }
    return  forecastCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.weatherDays.count - 1) {
        return CELL_HEIGHT;
    }
    return CELL_HEIGHT + 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEADER_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    
    [headerCell setScrollData:self.weatherHours];
    return headerCell;
}

-(void)getWeatherPosition:(Position *)position {
    [self requestDataPosition:position];
}

@end
