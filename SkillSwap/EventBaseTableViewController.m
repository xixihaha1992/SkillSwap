//
//  EventBaseTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/27/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventBaseTableViewController.h"

NSString *const kCellIdentifier = @"cellID";
NSString *const kTableCellNibName = @"EventCell";

@interface EventBaseTableViewController ()

@end

@implementation EventBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCell:(EventCell *)cell forPFObject:(PFObject *)object withFlag:(BOOL)isInMyEvent {
    cell.eventTitleLabel.text = [object objectForKey:@"eventName"];
    cell.eventLocationLabel.text = [object objectForKey:@"eventLocation"];
    cell.event = object;
    UIImage *btnImg = [UIImage imageNamed:@"heartEmpty.png"];
    [cell.likeButton setImage:btnImg forState:UIControlStateNormal];
    
    if (isInMyEvent) {
        UIImage *btnImage = [UIImage imageNamed:@"heartFilled.png"];
        [cell.likeButton setImage:btnImage forState:UIControlStateNormal];
        cell.user = [PFUser currentUser];
    }

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM dd hh:mma"];
    NSString *date = [dateFormat stringFromDate:[object objectForKey:@"eventDate"]];
    cell.eventCalendarLabel.text = date;
    
    UIImage *eventImage = [UIImage imageNamed:[object objectForKey:@"imageName"]];
    cell.eventImage.image = eventImage;
    cell.eventImage.layer.cornerRadius = 5.0;
    cell.eventImage.layer.masksToBounds = YES;
    
}


@end
