//
//  NetworkService.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "NetworkService.h"

@implementation NetworkService


+(void)getData:(NSString *)url parameter:(NSDictionary *)parameter complete:(void(^)(NSDictionary *data, NSError *error))handeBlock{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET: url
                  parameters: nil
                    progress: ^(NSProgress * _Nonnull downloadProgress) {
                        
                    } success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        handeBlock(responseObject,nil);
                    } failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        handeBlock(nil, error);
                    }];
    
}

@end
