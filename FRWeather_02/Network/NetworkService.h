//
//  NetworkService.h
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Config.h"
#import "Connection.h"


@interface NetworkService : NSObject

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) NSDictionary *parameter;
@property (strong, nonatomic) NSString *urlRequest;


-(void) getData: (NSString *)url parameter: (NSDictionary *)parameter complete: (void(^)(NSDictionary *data, NSError *error))handeBlock;


@end
