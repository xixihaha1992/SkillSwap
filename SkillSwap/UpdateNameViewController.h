//
//  UpdateNameViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateNameViewController : UIViewController

@property (strong, nonatomic) NSString *userName;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
- (IBAction)cancelPressed:(id)sender;
- (IBAction)savePressed:(id)sender;

@end
