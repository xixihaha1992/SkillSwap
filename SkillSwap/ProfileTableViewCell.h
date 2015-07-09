//
//  ProfileTableViewCell.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 4/22/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *realname;
//@property (weak, nonatomic) IBOutlet UILabel *usertitle;
@property (weak, nonatomic) IBOutlet UILabel *usermajor;
@property (weak, nonatomic) IBOutlet UILabel *enrollyear;
@property (weak, nonatomic) IBOutlet UIImageView *userimage;



@end
