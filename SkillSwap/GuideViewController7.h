//
//  GuideViewController6.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/8/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Gvc7Delegate
- (void)gvc7IsDismissed;
@end

@interface GuideViewController7 : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)goButtonPressed:(id)sender;
@property(nonatomic, weak) id<Gvc7Delegate> gvc7Delegate;

@property (nonatomic, strong) NSMutableArray *selectedSkills;
@property (nonatomic, weak) UIImage *myImage;

@end
