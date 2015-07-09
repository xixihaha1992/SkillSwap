//
//  PeopleResultsTableViewController.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/13/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleBaseTableViewController.h"
@class PeopleResultsTableViewController;

@protocol PeopleResultTableDelegate

//- (void)updateResultCell:(PeopleResultsTableViewController *)resultTableViewController;

@end

@interface PeopleResultsTableViewController : PeopleBaseTableViewController

@property (nonatomic, strong) NSArray *filteredCellDataArray;

@property (nonatomic, weak) id<PeopleResultTableDelegate> resultTableDelegate;

@end
