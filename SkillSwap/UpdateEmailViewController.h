//
//  UpdateEmailViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateEmailViewController : UIViewController
@property (strong, nonatomic) NSString *email;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
- (IBAction)savePressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;

@end
