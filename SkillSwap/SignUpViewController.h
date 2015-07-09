

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class SignUpViewController;

@protocol SignUpViewControllerDelegate <NSObject>

- (void)newUserViewControllerDidSignup:(SignUpViewController *)controller;

@end

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@property (nonatomic, weak) id<SignUpViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet UITextField *passwordAgainField;
@property (nonatomic, strong) PFUser *user;

@end
