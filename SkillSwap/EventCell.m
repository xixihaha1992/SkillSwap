//
//  EventCell.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/27/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

@synthesize eventCellDelegate;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tapLikeButton:(id)sender {
    if (self.user == nil) {
        UIImage *btnImage = [UIImage imageNamed:@"heartFilled.png"];
        [self.likeButton setImage:btnImage forState:UIControlStateNormal];
        
        PFUser *currentUser = [PFUser currentUser];
        self.user = currentUser;
        PFRelation *relation = [currentUser relationForKey:@"myEvent"];
        [relation addObject:self.event];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self.eventCellDelegate updateLikedEvents:self];
            } else {
                NSLog(@"cannot update user_evnet %@",error);
            }
            
        }];
        
    } else {
        UIImage *btnImage = [UIImage imageNamed:@"heartEmpty.png"];
        [self.likeButton setImage:btnImage forState:UIControlStateNormal];
        
        self.user = nil;
        PFUser *currentUser = [PFUser currentUser];
        PFRelation *relation = [currentUser relationForKey:@"myEvent"];
        [relation removeObject:self.event];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self.eventCellDelegate updateLikedEvents:self];
            } else {
                NSLog(@"cannot update user_evnet %@",error);
            }
        }];
    }
}

@end
