//
//  GuideViewController2.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "GuideViewController2.h"
#import "GuideViewController3.h"

@interface GuideViewController2 () <UITextFieldDelegate,Gvc3Delegate>
@property (nonatomic, weak) GuideViewController3 *gvc3;
@end

@implementation GuideViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.emailTextField becomeFirstResponder];
    self.emailTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![self validateEmail:self.emailTextField.text]) {
        [self.emailTextField becomeFirstResponder];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please Enter a Valid Email"message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    } else {
        self.emailName = self.emailTextField.text;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.gvc3 = [storyboard instantiateViewControllerWithIdentifier:@"gvc3"];
        self.gvc3.gvc3Delegate = self;
        [self presentViewController:self.gvc3 animated:YES completion:nil];
    }
    return true;
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

# pragma mark Gvc3Delegate
- (void)gvc3IsDismissed {
    self.myImage = self.gvc3.myImage;
    self.mySkills = self.gvc3.mySkills;
    self.wantToLearn = self.gvc3.wantToLearn;
    self.yearEnrolled = self.gvc3.yearEnrolled;
    self.majorName = self.gvc3.majorName;
    self.schoolName = self.gvc3.schoolTextField.text;
    
    [self.gvc2Delegate gvc2IsDismissed];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
