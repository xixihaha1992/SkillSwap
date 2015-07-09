//
//  GuideViewController5.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Gvc5Delegate
- (void)gvc5IsDismissed;
@end
@interface GuideViewController5 : UIViewController

@property(nonatomic, weak) id<Gvc5Delegate> gvc5Delegate;
@property (weak, nonatomic) IBOutlet UILabel *yearTextField;

- (IBAction)goButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *yearPicker;

@property (nonatomic, weak) NSString *yearEnrolled;
@property (nonatomic, strong) NSArray *mySkills;
@property (nonatomic, weak) NSArray *wantToLearn;
@property (nonatomic, weak) UIImage *myImage;


@end
