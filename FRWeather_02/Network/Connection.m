//
//  Connection.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "Connection.h"

@implementation Connection

+(void)startNetworkReachabilityMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+(BOOL)checkNetworkStatus {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
