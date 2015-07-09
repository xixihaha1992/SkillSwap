//
//  EventCell.h
//  SkillSwap
//
//  Created by Chen Zhu on 4/27/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class EventCell;

@protocol EventCellDelegate

- (void)updateLikedEvents:(EventCell *)eventCell;

@end

@interface EventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;


@property (weak, nonatomic) IBOutlet UILabel *eventLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventCalendarLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (weak, nonatomic) PFObject *event;
@property (weak, nonatomic) PFUser *user;

- (IBAction)tapLikeButton:(id)sender;

@property(nonatomic,weak) id<EventCellDelegate> eventCellDelegate;

@end
