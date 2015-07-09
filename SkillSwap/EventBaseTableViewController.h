//
//  EventBaseTableViewController.h
//  SkillSwap
//
//  Created by Chen Zhu on 4/27/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <Parse/Parse.h>
#import "EventCell.h"

extern NSString *const kCellIdentifier;

@interface EventBaseTableViewController : UITableViewController

- (void)configureCell:(EventCell *)cell forPFObject:(PFObject *)object withFlag:(BOOL)isInMyEvent;

@end
