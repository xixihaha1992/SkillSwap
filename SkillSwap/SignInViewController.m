

#import "SignInViewController.h"
#import <Parse/Parse.h>
#import "ActivityView.h"
#import "SignUpViewController.h"
#import "GuideViewController1.h"

@interface SignInViewController ()
<UITextFieldDelegate,
UIScrollViewDelegate,
SignUpViewControllerDelegate,
Gvc1Delegate>

@property (nonatomic, assign) BOOL activityViewVisible;
@property (nonatomic, strong) UIView *activityView;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *backgroundView;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, weak) GuideViewController1 *gvc1;
@property (nonatomic, strong) SignUpViewController *signUpViewController;
@end

@implementation SignInViewController

#pragma mark -
#pragma mark Init

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Disable automatic adjustment, as we want to occupy all screen real estate
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(dismissKeyboard)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self registerForKeyboardNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	[self.scrollView flashScrollIndicators];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.activityView.frame = self.view.bounds;
    self.scrollView.contentSize = self.backgroundView.bounds.size;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark IBActions

- (IBAction)loginPressed:(id)sender {
    [self dismissKeyboard];
    [self processFieldEntries:self.usernameField.text andPassword:self.passwordField.text];
}

- (IBAction)signUpPressed:(id)sender {
    [self presentNewUserViewController];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    }
    if (textField == self.passwordField) {
        [self.passwordField resignFirstResponder];
        [self processFieldEntries:self.usernameField.text andPassword:self.passwordField.text];
    }

    return YES;
}

#pragma mark -
#pragma mark NewUserViewController

- (void)presentNewUserViewController {
    self.signUpViewController = [[SignUpViewController alloc] initWithNibName:nil bundle:nil];
    self.signUpViewController.delegate = self;
    [self presentViewController:self.signUpViewController animated:YES completion:nil];
}

#pragma mark Delegate

- (void)SignUpViewControllerDidSignup:(SignUpViewController *)controller {
    [self.delegate loginViewControllerDidLogin:self];
}

#pragma mark -
#pragma mark Private

#pragma mark Field validation

- (void)processFieldEntries:(NSString *)username andPassword:(NSString *)password {
    
    // Get the username text, store it in the app delegate for now
    NSString *noUsernameText = @"username";
    NSString *noPasswordText = @"password";
    NSString *errorText = @"No ";
    NSString *errorTextJoin = @" or ";
    NSString *errorTextEnding = @" entered";
    BOOL textError = NO;

    // Messaging nil will return 0, so these checks implicitly check for nil text.
    if (username.length == 0 || password.length == 0) {
        textError = YES;

        // Set up the keyboard for the first field missing input:
        if (password.length == 0) {
            [self.passwordField becomeFirstResponder];
        }
        if (username.length == 0) {
            [self.usernameField becomeFirstResponder];
        }
    }

    if ([username length] == 0) {
        textError = YES;
        errorText = [errorText stringByAppendingString:noUsernameText];
    }

    if ([password length] == 0) {
        textError = YES;
        if ([username length] == 0) {
            errorText = [errorText stringByAppendingString:errorTextJoin];
        }
        errorText = [errorText stringByAppendingString:noPasswordText];
    }

    if (textError) {
        errorText = [errorText stringByAppendingString:errorTextEnding];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
        return;
    }

    // Everything looks good; try to log in.

    // Set up activity view
    self.activityViewVisible = YES;

    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        // Tear down the activity view in all cases.
        

        if (user) {
            [self.delegate loginViewControllerDidLogin:self];
            self.activityViewVisible = NO;
            
        } else {
            // Didn't get a user.
            NSLog(@"%s didn't get a user!", __PRETTY_FUNCTION__);

            NSString *alertTitle = nil;

            if (error) {
                // Something else went wrong
                alertTitle = [error userInfo][@"error"];
            } else {
                // the username or password is probably wrong.
                alertTitle = @"Couldn’t log in:\nThe username or password were wrong.";
            }
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
            [alertView show];

            // Bring the keyboard back up, because they'll probably need to change something.
            [self.usernameField becomeFirstResponder];
            self.activityViewVisible = NO;
        }
    }];
}

#pragma mark Keyboard

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGRect keyboardFrame = [self.view convertRect:endFrame fromView:self.view.window];

    CGFloat scrollViewOffsetY = (CGRectGetHeight(keyboardFrame) -
                                 (CGRectGetMaxY(self.view.bounds) -
                                  CGRectGetMaxY(self.loginButton.frame) - 10.0f));

    if (scrollViewOffsetY < 0) {
        return;
    }

    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve << 16 | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.scrollView setContentOffset:CGPointMake(0.0f, scrollViewOffsetY) animated:NO];
                     }
                     completion:nil];

}

- (void)keyboardWillHide:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve << 16 | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.scrollView setContentOffset:CGPointZero animated:NO];
                     }
                     completion:nil];
}

#pragma mark ActivityView

- (void)setActivityViewVisible:(BOOL)visible {
    if (self.activityViewVisible == visible) {
        return;
    }

    _activityViewVisible = visible;

    if (_activityViewVisible) {
        ActivityView *activityView = [[ActivityView alloc] initWithFrame:self.view.bounds];
        activityView.label.text = @"Loading";
        activityView.label.font = [UIFont boldSystemFontOfSize:20.f];
        [activityView.activityIndicator startAnimating];

        _activityView = activityView;
        [self.view addSubview:_activityView];
    } else {
        [_activityView removeFromSuperview];
        _activityView = nil;
    }
}

#pragma mark 
- (void)newUserViewControllerDidSignup:(SignUpViewController *)controller {
    self.usernameField.text = controller.usernameField.text;
    self.passwordField.text = controller.passwordField.text;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.gvc1 = [storyboard instantiateViewControllerWithIdentifier:@"gvc1"];
    self.gvc1.gvc1Delegate = self;
    [self presentViewController:self.gvc1 animated:YES completion:nil];
    
    
}

# pragma mark Gvc1Delegate
- (void)gvc1IsDismissed {
    self.activityViewVisible = YES;
    [self.gvc1 dismissViewControllerAnimated:false completion:nil];
    [self updateUserInfo];
    [self processFieldEntries:self.usernameField.text andPassword:self.passwordField.text];
    self.activityViewVisible = NO;
}


-(void)updateUserInfo {
    PFUser *currUser = self.signUpViewController.user;
    [currUser setObject:self.gvc1.self.nameTextField.text forKey:@"realName"];
    [currUser setObject:self.gvc1.emailName forKey:@"myEmail"];
    [currUser setObject:self.gvc1.schoolName forKey:@"school"];
    [currUser setObject:self.gvc1.majorName forKey:@"major"];
    [currUser setObject:self.gvc1.yearEnrolled forKey:@"enrollYear"];
    [currUser setObject:@"" forKey:@"aboutMe"];
    
    for (NSString *knownSkill in self.gvc1.mySkills) {
        PFObject *userSkill = [PFObject objectWithClassName:@"UserSkill"];
        [userSkill setObject:knownSkill forKey:@"skillName"];
        [userSkill setObject:@"known" forKey:@"skillType"];
        [userSkill setObject:[currUser objectId] forKey:@"userId"];
        [userSkill save];
    }
    
    for (NSString *toLearnSkill in self.gvc1.wantToLearn) {
        PFObject *userSkill2 = [PFObject objectWithClassName:@"UserSkill"];
        [userSkill2 setObject:toLearnSkill forKey:@"skillName"];
        [userSkill2 setObject:@"toLearn" forKey:@"skillType"];
        [userSkill2 setObject:[currUser objectId] forKey:@"userId"];
        [userSkill2 save];
    }
    
    
    NSData* data = UIImageJPEGRepresentation(self.gvc1.myImage, 0.7f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    
    [imageFile save];
    [currUser setObject:imageFile forKey:@"userImg"];
    
    [currUser save];
}
@end
