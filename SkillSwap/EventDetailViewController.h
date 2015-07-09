//
//  EventDetailViewController.h
//  SkillSwap
//
//  Created by Chen Zhu on 4/6/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EventDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *eventWebView;

@property (weak, nonatomic) PFObject *object;

@end
