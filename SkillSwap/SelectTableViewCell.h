//
//  SelectTableViewCell.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/8/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectTableViewCell;

@protocol SelectTableViewCellDelegate
- (void)buttonChecked:(SelectTableViewCell *)cell;
- (void)buttonUnchecked:(SelectTableViewCell *)cell;
@end

@interface SelectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
- (IBAction)selectButtonPressed:(id)sender;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString *skillName;

@property(nonatomic, weak) id<SelectTableViewCellDelegate> myDelegate;


@end
