//
//  PeopleBaseTableViewController.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/13/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleCell.h"
#import <Parse/Parse.h>
#import "CellData.h"


@interface PeopleBaseTableViewController : UITableViewController

- (void)configureCell:(PeopleCell *)cell forCellData:(CellData *)cellData;


@property (nonatomic, strong) NSArray *skills;
@end
