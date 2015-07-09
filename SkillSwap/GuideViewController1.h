//
//  GuideViewController1.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Gvc1Delegate
- (void)gvc1IsDismissed;
@end

@interface GuideViewController1 : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property(nonatomic, weak) id<Gvc1Delegate> gvc1Delegate;

@property (nonatomic, weak) NSString *realName;
@property (nonatomic, weak) NSString *emailName;
@property (nonatomic, weak) NSString *schoolName;
@property (nonatomic, weak) NSString *majorName;
@property (nonatomic, weak) NSString *yearEnrolled;
@property (nonatomic, weak) NSArray *mySkills;
@property (nonatomic, weak) NSArray *wantToLearn;
@property (nonatomic, weak) UIImage *myImage;

@end
