//
//  UpdateNameViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "UpdateNameViewController.h"
#import <Parse/Parse.h>

@interface UpdateNameViewController () <UITextFieldDelegate>

@end

@implementation UpdateNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.delegate = self;
    self.nameTextField.text = self.userName;
    self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.nameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelPressed:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)savePressed:(id)sender {
    if (self.nameTextField.text.length == 0) {
        [self.nameTextField becomeFirstResponder];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Username cannot be empty"message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    } else {
        [self.nameTextField resignFirstResponder];
        PFUser *user = [PFUser currentUser];
        [user setObject:self.nameTextField.text forKey:@"realName"];
        [user save];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

# pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self savePressed:nil];
    return true;
}

@end
