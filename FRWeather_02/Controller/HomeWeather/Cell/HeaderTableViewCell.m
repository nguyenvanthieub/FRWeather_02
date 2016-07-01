//
//  HeaderTableViewCell.m
//  FRWeather_02
//
//  Created by framgia on 6/16/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setScrollData:(NSMutableArray *)scrollData {
    
    CGFloat viewWidth = 70;
    CGFloat viewHeight = self.scrollViewHeader.frame.size.height;
    CGFloat xPosition = 0;
    CGFloat scrollViewContentSize = 0;
    CGFloat space = 5;
    
    NSUInteger count = scrollData.count;
    scrollViewContentSize += (viewWidth + space) * (count);
    self.scrollViewHeader.contentSize = CGSizeMake(scrollViewContentSize, viewHeight);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollViewContentSize, viewHeight)];
    [self.scrollViewHeader addSubview:view];
    for (int index = 0; index < count; index++) {
        NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"HeaderItem" owner:self options:nil];
        HeaderItem *headerCell = xib[0];
        WeatherModel *weatherModel = [scrollData objectAtIndex:index];
        [headerCell setFrame:CGRectMake(xPosition, 0, viewWidth, viewHeight)];
        [headerCell setHeaderData:weatherModel];
        [view addSubview:headerCell];
        
        xPosition += viewWidth + space;
    };
}

@end
