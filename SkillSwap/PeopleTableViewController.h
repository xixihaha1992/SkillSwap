//
//  PeopleTableViewController.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/13/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleBaseTableViewController.h"

@interface PeopleTableViewController : PeopleBaseTableViewController
@property (nonatomic, strong) NSArray *people;
@property (nonatomic, strong) NSArray *filteredPeople;
- (IBAction)showMoreOption:(id)sender;

@end
