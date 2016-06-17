//
//  HeaderTableViewCell.h
//  FRWeather_02
//
//  Created by framgia on 6/16/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForecastModel.h"
#import "HeaderItem.h"
#import "WeatherModel.h"

@interface HeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewHeader;

- (void)setScrollData:(NSMutableArray *)scrollData;

@end
