//
//  SearchCityTableViewController.m
//  FRWeather_02
//
//  Created by framgia on 6/23/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "SearchCityTableViewController.h"

@interface SearchCityTableViewController () {
    NSMutableArray *searchResults;
}

@end

@implementation SearchCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchResults = [NSMutableArray new];
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"cellCity"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellCity" forIndexPath:indexPath];
    cell.textLabel.text = searchResults[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *correctedAddress = [searchResults[indexPath.row] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet symbolCharacterSet]];
    NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false",correctedAddress];
    [NetworkService getData:URL parameter:nil complete:^(NSDictionary *data, NSError *error) {
        if (data) {
            if (!error) {
                Position *position = [[Position alloc] initWithDictionary:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate locateWithLongitude:position.lon andLatitude:position.lat andAddress:position.address];
                });
            }
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)reloadDataWithArray:(NSMutableArray *)array {
    searchResults = array;
    [self.tableView reloadData];
}

@end
