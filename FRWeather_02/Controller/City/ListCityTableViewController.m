//
//  CityTableViewController.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "ListCityTableViewController.h"

@interface ListCityTableViewController () <UISearchBarDelegate> {
    SearchCityTableViewController *tableviewSearchCity;
    NSMutableArray *resultsSearchArray;
    NSMutableArray *weatherCityArray;
}

@end

@implementation ListCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchCity:)];
    weatherCityArray = [NSMutableArray new];
    resultsSearchArray = [NSMutableArray new];
    
    //Lets decode it now
//    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
//    NSData *decodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"listCity"]];
    NSArray *listCity =[Common getListCity];
    for (Position *position in listCity) {
        [weatherCityArray addObject:position];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    tableviewSearchCity = [[SearchCityTableViewController alloc] init];
    tableviewSearchCity.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchCity:(id)sender {
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:tableviewSearchCity];
    searchController.searchBar.delegate = self;
    [self presentViewController:searchController animated:true completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return weatherCityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCellList" forIndexPath:indexPath];
    Position *item = weatherCityArray[indexPath.row];
    cell.textLabel.text = item.address;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Position *city = weatherCityArray[indexPath.row];
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setDouble:city.lat forKey:@"currentLat"];
//    [userDefault setDouble:city.lon forKey:@"currentLon"];
//    [userDefault synchronize];
    [Common setCurrentPosition:city];
    if (self.delegate && [self.delegate respondsToSelector:@selector(getWeatherPosition:)]) {
        [self.delegate getWeatherPosition:city];
    }
    [self.navigationController popViewControllerAnimated:true];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [weatherCityArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self refreshDataCity];
        [self.tableView setEditing:NO animated:YES];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    GMSPlacesClient *placeClient = [[GMSPlacesClient alloc] init];
    [placeClient autocompleteQuery:searchText bounds:nil filter:nil callback:^(NSArray<GMSAutocompletePrediction *> * _Nullable results, NSError * _Nullable error) {
        [resultsSearchArray removeAllObjects];
        if (!results) {
//            NSLog(@"Autocomplete error %@", [error localizedDescription]);
            return;
        }
        for (GMSAutocompletePrediction *result in results) {
            [resultsSearchArray addObject:result.attributedFullText.string];
        }
        [tableviewSearchCity reloadDataWithArray:resultsSearchArray];
    }];
}

- (void)locateWithLongitude:(double)lon andLatitude:(double)lat andAddress:(NSString *)address {
    Position *city = [Position new];
    city.address = address;
    city.lat = lat;
    city.lon = lon;
    [weatherCityArray addObject:city];
    [self.tableView reloadData];
    [Common saveListCity:weatherCityArray];
}

- (void)refreshDataCity {
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:weatherCityArray];
    [userDefault setObject:myEncodedObject forKey:[NSString stringWithFormat:@"listCity"]];
}

@end
