//
//  SettingsViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/3/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "SettingsViewController.h"

#import "ProfileTableViewController.h"
#import "AppDelegate.h"

//@interface SettingsViewController () <SignInViewControllerDelegate, ProfileTableViewControllerDelegate> {}
@interface SettingsViewController ()  {}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)signOut:(id)sender {
    [PFUser logOut];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate resetWindowToInitialView];    
}


//#pragma mark LoginViewController
//
//- (void)presentLoginViewController {
//    // Go to the welcome screen and have them log in or create an account.
//    SignInViewController *viewController = [[SignInViewController alloc] initWithNibName:nil bundle:nil];
//    viewController.delegate = self;
//    [self presentViewController:viewController animated:YES completion:NULL];
//    
//    //    [self.navigationController setViewControllers:@[ viewController ] animated:NO];
//}
//
//#pragma mark Delegate
//
//- (void)loginViewControllerDidLogin:(SignInViewController *)controller {
//    
//    [self dismissViewControllerAnimated:YES completion:NULL];
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}

//- (void)presentProfileTableViewController {
//    ProfileTableViewController *viewController = [[ProfileTableViewController alloc] initWithNibName:nil bundle:nil];
//    viewController.delegate = self;
//    [self presentViewController:viewController animated:YES completion:NULL];
//}


@end
