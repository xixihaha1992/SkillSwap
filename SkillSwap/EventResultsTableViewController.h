//
//  EventResultsTableViewController.h
//  SkillSwap
//
//  Created by Chen Zhu on 4/27/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventBaseTableViewController.h"
@class EventResultsTableViewController;

@protocol ResultTableDelegate

- (void)updateResultCell:(EventResultsTableViewController *)resultTableViewController;

@end

@interface EventResultsTableViewController : EventBaseTableViewController

@property (nonatomic, strong) NSArray *filteredEvents;
@property (nonatomic, strong) NSArray *myEvents;
@property (nonatomic, weak) id<ResultTableDelegate> resultTableDelegate;

@end
