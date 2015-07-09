//
//  UpdateEmailViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "UpdateEmailViewController.h"
#import <Parse/Parse.h>

@interface UpdateEmailViewController () <UITextFieldDelegate>

@end

@implementation UpdateEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.emailTextField.text = self.email;
    self.emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.emailTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

- (IBAction)cancelPressed:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)savePressed:(id)sender {
    if (![self validateEmail:self.emailTextField.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please Enter Valid Email"message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    } else {
        [self.emailTextField resignFirstResponder];
        PFUser *user = [PFUser currentUser];
        [user setObject:self.emailTextField.text forKey:@"myEmail"];
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
