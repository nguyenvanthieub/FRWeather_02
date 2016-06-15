//
//  Connection.h
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface Connection : NSObject

+(void)startNetworkReachabilityMonitoring;
+(BOOL)checkNetworkStatus;

@end
