//
//  GuideViewController6.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/8/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Gvc6Delegate
- (void)gvc6IsDismissed;
@end

@interface GuideViewController6 : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)goButtonPressed:(id)sender;
@property(nonatomic, weak) id<Gvc6Delegate> gvc6Delegate;

@property (nonatomic, strong) NSMutableArray *selectedSkills;
@property (nonatomic, strong) NSArray *wantToLearn;
@property (nonatomic, weak) UIImage *myImage;

@end
