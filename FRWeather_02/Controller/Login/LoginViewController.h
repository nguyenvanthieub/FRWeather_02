//
//  ViewController.h
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "FacebookService.h"
#import "HomeViewController.h"
#import "UIImageView+WebCache.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (weak, nonatomic) IBOutlet UILabel *nameUser;

- (IBAction)btnLoginFbAction:(id)sender;

@end

