//
//  GuideViewController3.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Gvc3Delegate
- (void)gvc3IsDismissed;
@end
@interface GuideViewController3 : UIViewController
@property(nonatomic, weak) id<Gvc3Delegate> gvc3Delegate;
@property (weak, nonatomic) IBOutlet UILabel *schoolTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *schoolPicker;
- (IBAction)goButtonPressed:(id)sender;

@property (nonatomic, weak) NSString *majorName;
@property (nonatomic, weak) NSString *yearEnrolled;
@property (nonatomic, weak) NSArray *mySkills;
@property (nonatomic, weak) NSArray *wantToLearn;
@property (nonatomic, weak) UIImage *myImage;

@end
