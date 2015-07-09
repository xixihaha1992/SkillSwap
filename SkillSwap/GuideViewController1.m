//
//  GuideViewController1.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "GuideViewController1.h"
#import "GuideViewController2.h"
#import "ActivityView.h"


@interface GuideViewController1 () <UITextFieldDelegate, Gvc2Delegate>
@property (nonatomic,weak) GuideViewController2 *gvc2;

@property (nonatomic, assign) BOOL activityViewVisible;
@property (nonatomic, strong) UIView *activityView;

@end

@implementation GuideViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.delegate = self;
    [self.nameTextField becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.nameTextField.text.length == 0) {
        [self.nameTextField becomeFirstResponder];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Username cannot be empty"message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.gvc2 = [storyboard instantiateViewControllerWithIdentifier:@"gvc2"];
        self.gvc2.gvc2Delegate = self;
        [self presentViewController:self.gvc2 animated:YES completion:nil];
    }
    return true;
}

# pragma mark Gvc2Delegate
- (void) gvc2IsDismissed {
    
    self.activityViewVisible = YES;
    [self setActivityViewVisible:self.activityViewVisible];
    
    self.myImage = self.gvc2.myImage;
    self.mySkills = self.gvc2.mySkills;
    self.wantToLearn = self.gvc2.wantToLearn;
    self.yearEnrolled = self.gvc2.yearEnrolled;
    self.majorName = self.gvc2.majorName;
    self.schoolName = self.gvc2.schoolName;
    self.emailName = self.gvc2.emailName;
    
    [self.gvc1Delegate gvc1IsDismissed];
}

#pragma mark ActivityView

- (void)setActivityViewVisible:(BOOL)visible {
    if (self.activityViewVisible == visible) {
        return;
    }
    
    _activityViewVisible = visible;
    
    if (_activityViewVisible) {
        ActivityView *activityView = [[ActivityView alloc] initWithFrame:self.view.bounds];
        activityView.label.text = @"Logging in";
        activityView.label.font = [UIFont boldSystemFontOfSize:20.f];
        [activityView.activityIndicator startAnimating];
        
        _activityView = activityView;
        [self.view addSubview:_activityView];
    } else {
        [_activityView removeFromSuperview];
        _activityView = nil;
    }
}




@end
