//
//  PeopleBaseTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/13/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleBaseTableViewController.h"
#import "AppDelegate.h"


@interface PeopleBaseTableViewController ()

@end

@implementation PeopleBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"PeopleCell" bundle:nil] forCellReuseIdentifier:@"peopleCellId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configureCell:(PeopleCell *)cell forCellData:(CellData *)cellData {
    cell.userImage.image = cellData.image;
    cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width / 2.0f;
    cell.userImage.layer.masksToBounds = YES;
    
    cell.nameLabel.text = cellData.realName;
    cell.majorLabel.text = cellData.major;
    cell.skillsLabel.text = cellData.knowns;
    cell.wantsLabel.text = cellData.wants;
}


@end




