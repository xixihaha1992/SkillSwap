//
//  PAWLoginViewController.h
//  Anywall
//
//  Copyright (c) 2014 Parse Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignInViewController;

@protocol SignInViewControllerDelegate <NSObject>

- (void)loginViewControllerDidLogin:(SignInViewController *)controller;

@end

@interface SignInViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id<SignInViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;

@end
