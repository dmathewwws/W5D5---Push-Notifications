//
//  ProfileViewController.h
//  W5D5 - Push Notifications
//
//  Created by Daniel Mathews on 2015-06-04.
//  Copyright (c) 2015 ca.lighthouselabs. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController : ViewController

@property (nonatomic, strong) PFUser *user;

@end
