//
//  GuideViewController2.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Gvc2Delegate
- (void)gvc2IsDismissed;
@end

@interface GuideViewController2 : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property(nonatomic, weak) id<Gvc2Delegate> gvc2Delegate;

@property (nonatomic, strong) NSString *emailName;
@property (nonatomic, weak) NSString *schoolName;
@property (nonatomic, weak) NSString *majorName;
@property (nonatomic, weak) NSString *yearEnrolled;
@property (nonatomic, weak) NSArray *mySkills;
@property (nonatomic, weak) NSArray *wantToLearn;
@property (nonatomic, weak) UIImage *myImage;

@end

