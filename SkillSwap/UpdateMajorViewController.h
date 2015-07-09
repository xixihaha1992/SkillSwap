//
//  UpdateMajorViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateMajorViewControllerDelegate
- (void)majorViewIsDismissed;
@end





@interface UpdateMajorViewController : UIViewController

@property(nonatomic, weak) id<UpdateMajorViewControllerDelegate> majorDelegate;

@property (strong ,nonatomic) NSString *major;
@property (nonatomic, strong) NSString *school;

@property (weak, nonatomic) IBOutlet UILabel *majorTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *majorPicker;
- (IBAction)savePressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;

@end
