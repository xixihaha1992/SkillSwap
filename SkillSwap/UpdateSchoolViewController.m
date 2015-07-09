//
//  UpdateSchoolViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "UpdateSchoolViewController.h"
#import <Parse/Parse.h>

@interface UpdateSchoolViewController () <UIPickerViewDelegate>
@property(nonatomic,strong) NSArray *schoolArray;

@end

@implementation UpdateSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.schoolPicker.delegate = self;
    self.schoolArray = @[@"The Information School",
                         @"College of Built Environments",
                         @"College of Education",
                         @"College of Engineering",
                         @"School of Business Administration",
                         @"School of Nursing",
                         @"School of Pharmacy"];
    self.schoolTextField.text = self.school;
    
    NSInteger rowInt;
    for (NSInteger i = 0; i < [self.schoolArray count]; i++) {
        if ([self.schoolArray[i] isEqualToString:self.school]) {
            rowInt = i;
            break;
        }
    }
    [self.schoolPicker selectRow:rowInt inComponent:0 animated:NO];
}


- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return  [self.schoolArray count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.schoolTextField.text = self.schoolArray[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *text = (UILabel*)view;
    
    if (!text){
        text = [[UILabel alloc] init];
        text.textAlignment = NSTextAlignmentCenter;
        //Set label style
        text.font = [UIFont systemFontOfSize:16.0f];
    }
    
    //Set text value
    text.text =  self.schoolArray[row];
    
    return text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)savePressed:(id)sender {
    PFUser *user = [PFUser currentUser];
    [user setObject:self.schoolTextField.text forKey:@"school"];
    [user save];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.schoolDelegate updateSchoolDismissed];
    }];
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];

}


@end
