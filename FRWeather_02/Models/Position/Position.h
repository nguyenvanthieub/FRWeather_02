//
//  Position.h
//  FRWeather_02
//
//  Created by framgia on 6/23/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject

@property(nonatomic) double lat;
@property(nonatomic) double lon;
@property(strong, nonatomic) NSString *address;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
