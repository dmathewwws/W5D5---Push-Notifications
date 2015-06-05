//
//  ViewController.m
//  W5D5 - Push Notifications
//
//  Created by Daniel Mathews on 2015-06-03.
//  Copyright (c) 2015 ca.lighthouselabs. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "ProfileViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"goToProfile"]){
        ProfileViewController *pVC = segue.destinationViewController;
        pVC.user = [PFUser currentUser];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
