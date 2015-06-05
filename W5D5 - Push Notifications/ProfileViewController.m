//
//  ProfileViewController.m
//  W5D5 - Push Notifications
//
//  Created by Daniel Mathews on 2015-06-04.
//  Copyright (c) 2015 ca.lighthouselabs. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.usernameLabel.text = self.user.username;
    
    [self.user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        PFFile *profileImageFile = [object objectForKey:@"photo"];
        [profileImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                self.profileImageView.image= [UIImage imageWithData:imageData];
            }else{
                NSLog(@"error is %@", error);
            }
        }];
    }];
    
}
- (IBAction)followUserPressed:(UIButton *)sender {
    
    PFObject *follow = [PFObject objectWithClassName:@"Activity"];
    [follow setObject:[PFUser currentUser].objectId forKey:@"fromUser"];
    [follow setObject:self.user.objectId forKey:@"toUser"];
    [follow saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            
            NSDictionary *pushData = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSString stringWithFormat:@"You have been followed by %@", [PFUser currentUser].username], @"alert",
                                      [PFUser currentUser].objectId ,@"u",
                                      @"Increment" ,@"badge",
                                      nil];
            
            PFPush *sendToFollowee = [[PFPush alloc] init];
            [sendToFollowee setChannel:self.user.objectId];
            [sendToFollowee setData:pushData];
            [sendToFollowee sendPushInBackground];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
