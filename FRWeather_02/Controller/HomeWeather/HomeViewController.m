//
//  HomeViewController.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "HomeViewController.h"
#define HEADER_HEIGHT 95
#define CELL_HEIGHT 45

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource> {
    GMSMapView *mapView;
    BOOL firstLocationUpdate;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareFacebook:)];
    
    self.apiWeather = [APIWeather new];
    [self loadGoogleMap];
    [self requestData];
}

- (IBAction)addCity:(id)sender {
    
}

- (IBAction)shareFacebook:(id)sender {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [FacebookService shareImage:screenImage message:@"Weather today"];
}

- (void)loadGoogleMap{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:21.016969
                                                            longitude:105.784196
                                                                 zoom:20];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.settings.compassButton = YES;
    mapView.settings.myLocationButton = YES;
    
    [mapView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView.myLocationEnabled = YES;
    });
    
}

- (void)dealloc {
    [mapView removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate) {
        firstLocationUpdate = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
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
        [weakSelf.weatherDays addObject:mapView];
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
    if (self.weatherDays != nil) {
        return self.weatherDays.count;
    }
    return 0;
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

@end
