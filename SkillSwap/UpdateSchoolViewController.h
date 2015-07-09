//
//  UpdateSchoolViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateSchoolViewControllerDelegate
- (void)updateSchoolDismissed;
@end

@interface UpdateSchoolViewController : UIViewController
@property (strong, nonatomic) NSString *school;
@property (weak, nonatomic) IBOutlet UILabel *schoolTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *schoolPicker;
@property(nonatomic, weak) id<UpdateSchoolViewControllerDelegate> schoolDelegate;

- (IBAction)savePressed:(id)sender;

- (IBAction)cancelPressed:(id)sender;

@end
