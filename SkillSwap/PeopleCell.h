//
//  PeopleTableViewCell.h
//  SkillSwap
//
//  Created by Xiao Tong on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeopleCell;

@interface PeopleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *skillsLabel;
@property (weak, nonatomic) IBOutlet UILabel *wantsLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;

@end
