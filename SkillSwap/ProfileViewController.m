//
//  ProfileViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 4/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
@interface ProfileViewController ()

@end

@implementation ProfileViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserProfile"];
    [query whereKey:@"userId" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            PFObject *object = [objects objectAtIndex:0];
            self.welcomeLabel.text = object[@"userName"];
//            NSLog(@"%@", self.welcomeLabel.text);
        } else {
            
        }
    }];
    
    
    
    
    
//    if ([PFUser currentUser]) {
//        self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
//    } else {
//        self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
//    }
    
//    [[PFUser currentUser] setObject:UserName forKey:@"UserId"];
    
//    self.nameLabel.text = [[PFUser currentUser] objectForKey:@"UserName"];
//
//    (PFObject *)object {
//        static NSString *CellIdentifier = @"EventCell";
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        }
//        
//        cell.textLabel.text = [object objectForKey:@"eventName"];
//        
//        return cell;
//    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//[someUser setObject:someOccupation forKey:@"occupation"]





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addBtnPressed:(id)sender {
    if (![self.realName.text isEqualToString:@""]) {
        
        // update user real name
        
        PFQuery *query = [PFQuery queryWithClassName:@"UserProfile"];
        [query whereKey:@"userId" equalTo:[PFUser currentUser]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                PFObject *object = [objects objectAtIndex:0];
                object[@"userName"] = self.realName.text;
                [object saveInBackground];
                NSLog(@"1, %@", object[@"userName"]);
            } else {
                
            }
        }];

        // query and display user real name
        
        PFQuery *queryback = [PFQuery queryWithClassName:@"UserProfile"];
        [queryback whereKey:@"userId" equalTo:[PFUser currentUser]];
        [queryback findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                PFObject *objectback = [objects objectAtIndex:0];
                self.welcomeLabel.text = objectback[@"userName"];
                NSLog(@"2, %@", objectback[@"userName"]);
            } else {
                
            }
        }];

    }
}
@end
