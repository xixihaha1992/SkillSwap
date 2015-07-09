//
//  GuideViewController4.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Gvc4Delegate
- (void)gvc4IsDismissed;
@end
@interface GuideViewController4 : UIViewController

@property(nonatomic, weak) id<Gvc4Delegate> gvc4Delegate;
@property (weak, nonatomic) IBOutlet UILabel *majorTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *majorPicker;
- (IBAction)goButtonPressed:(id)sender;


@property (nonatomic, weak) NSString *schoolName;
@property (nonatomic, weak) NSString *yearEnrolled;
@property (nonatomic, weak) NSArray *mySkills;
@property (nonatomic, weak) NSArray *wantToLearn;
@property (nonatomic, weak) UIImage *myImage;

@end
