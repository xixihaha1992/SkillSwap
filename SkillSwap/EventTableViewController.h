//
//  EventTableViewController.h
//  SkillSwap
//
//  Created by Chen Zhu on 4/6/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventBaseTableViewController.h"

@interface EventTableViewController : EventBaseTableViewController

@property (nonatomic, copy) NSArray *events;
@property (nonatomic, copy) NSArray *myEvents;
@end
