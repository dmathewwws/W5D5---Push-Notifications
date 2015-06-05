//
//  AppDelegate.m
//  W5D5 - Push Notifications
//
//  Created by Daniel Mathews on 2015-06-03.
//  Copyright (c) 2015 ca.lighthouselabs. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "ProfileViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"aK9HrWo7lXePSw28ZO2cTVNzZIGPImNB3gED7wJ1"
                  clientKey:@"UEYYFmOpOYrUTzgjk0Kcg5SlsUGgmSACTakL7lCc"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    PFUser *currentUser = [PFUser currentUser];

    if (currentUser){
        PFInstallation *currentInstallation = [PFInstallation currentInstallation];
        [currentInstallation setDeviceTokenFromData:deviceToken];
        currentInstallation.channels = @[ currentUser.objectId , @"premium"];
        [currentInstallation saveInBackground];
    }
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [PFPush handlePush:userInfo];
    
    if (userInfo){
        
        NSString *userId = [userInfo objectForKey:@"u"];

        PFObject *targetUser = [PFUser objectWithoutDataWithObjectId:userId];
        
        // Fetch photo object
        [targetUser fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            // Show photo view controller
            if (!error) {
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                vc.user = (PFUser*)object;
                [self.window.rootViewController presentViewController:vc animated:YES completion:NULL];
                
            }
        }];

    }
    
}

@end
