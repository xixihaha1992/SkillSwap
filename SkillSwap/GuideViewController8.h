//
//  GuideViewController8.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/8/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Gvc8Delegate
- (void)gvc8IsDismissed;
@end

@interface GuideViewController8 : UIViewController
- (IBAction)buttonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, weak) id<Gvc8Delegate> gvc8Delegate;
@property (weak, nonatomic) IBOutlet UIImageView *tapToChangeImg;

@end
