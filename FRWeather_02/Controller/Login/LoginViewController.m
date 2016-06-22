//
//  ViewController.m
//  FRWeather_02
//
//  Created by framgia on 6/14/16.
//  Copyright © 2016 framgia. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([FBSDKAccessToken currentAccessToken]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *name = [defaults stringForKey:@"name"];
        NSURL *url = [NSURL URLWithString:[defaults stringForKey:@"url"]];
        
        self.nameUser.text = name;
        [self.imageProfile sd_setImageWithURL:url];
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginFbAction:(id)sender {
    __block LoginViewController  *weakSelf = self;
    [FacebookService login:self completion:^(NSDictionary *userData) {
        if (userData) {
            NSString *name = [userData objectForKey:@"name"];
            NSString *urlAvartar = [[[userData objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:name forKey:@"name"];
            [defaults setObject:urlAvartar forKey:@"url"];
            [defaults synchronize];
            
            [weakSelf changeView];
        }
    }];
}

- (void)changeView {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"HomeViewController"];
    self.navigationController.viewControllers = @[vc];
}

@end
