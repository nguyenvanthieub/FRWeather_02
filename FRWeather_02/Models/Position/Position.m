//
//  Position.m
//  FRWeather_02
//
//  Created by framgia on 6/23/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "Position.h"

@implementation Position

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeDouble:self.lat forKey:@"lat"];
    [encoder encodeDouble:self.lon forKey:@"lon"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self != nil) {
        self.address = [decoder decodeObjectForKey:@"address"];
        self.lat = [decoder decodeDoubleForKey:@"lat"];
        self.lon = [decoder decodeDoubleForKey:@"lon"];
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self != nil) {
        Position *position = self;
        double lat = [[[[[[dic valueForKey:@"results"] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"] objectAtIndex:0] doubleValue];
        double lon = [[[[[[dic valueForKey:@"results"] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"] objectAtIndex:0] doubleValue];
        NSString *address = [[[dic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"formatted_address"];
        position.lat = lat;
        position.lon = lon;
        position.address = address;
    }
    return self;
}

@end
