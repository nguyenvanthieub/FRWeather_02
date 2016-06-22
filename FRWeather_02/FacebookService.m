//
//  FacebookService.m
//  FRWeather_02
//
//  Created by framgia on 6/21/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "FacebookService.h"

@implementation FacebookService

+ (void)login:(UIViewController *)viewController completion:(void (^)(NSDictionary *userData))handlerBlock {
    FBSDKLoginManager *fbLoginManager = [[FBSDKLoginManager alloc] init];
    
    [fbLoginManager logInWithReadPermissions:@[@"email"] fromViewController:viewController handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            handlerBlock(nil);
        } else if (result.isCancelled) {
            handlerBlock(nil);
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                if ([FBSDKAccessToken currentAccessToken]) {
                    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                    [parameters setValue:@"name, picture.type(large), email" forKey:@"fields"];
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                        if (error) {
                            handlerBlock(nil);
                        } else {
                            NSDictionary *data = (NSDictionary *)result;
                            [fbLoginManager logInWithPublishPermissions:@[@"publish_actions"] fromViewController:viewController handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    handlerBlock(nil);
                                } else if (result.isCancelled) {
                                    handlerBlock(nil);
                                } else {
                                    handlerBlock(data);
                                }
                            }];
                        }
                    }];
                }
            }
        }
    }];
}

+ (void)shareImage:(UIImage *)image message:(NSString *)message {
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
        if ([FBSDKAccessToken currentAccessToken]) {
            NSLog(@"Share");
            NSData *imageData = UIImagePNGRepresentation(image);
            NSDictionary *params = @{@"source":imageData,@"message":message};
            NSString *graphPath = @"/me/photos/";
            FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:graphPath parameters:params HTTPMethod:@"POST"];
            [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                if (error) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not be Upload Image on facebook" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                    [alert show];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Photo Upload Successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    [alert show];
                }
            }];
        }
    } else {
        NSLog(@"No share");
    }
}

@end
