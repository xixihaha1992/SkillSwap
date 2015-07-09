//
//  UpdateYearViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateYearViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *yearTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *yearPicker;
@property (nonatomic, strong) NSString *year;
- (IBAction)cancelPressed:(id)sender;
- (IBAction)savePressed:(id)sender;
@end
