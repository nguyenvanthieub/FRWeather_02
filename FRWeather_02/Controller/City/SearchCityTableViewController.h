//
//  SearchCityTableViewController.h
//  FRWeather_02
//
//  Created by framgia on 6/23/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "NetworkService.h"

@protocol LocateOnTheMapDelegate <NSObject>
- (void)locateWithLongitude:(double )lon andLatitude:(double )lat andAddress:(NSString *)address;
@end

@interface SearchCityTableViewController : UITableViewController
@property (weak, nonatomic) id<LocateOnTheMapDelegate> delegate;
- (void)reloadDataWithArray:(NSMutableArray *)array;
@end
