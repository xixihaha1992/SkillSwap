//
//  GuideViewController3.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "GuideViewController3.h"
#import "GuideViewController4.h"
@interface GuideViewController3 () <UIPickerViewDelegate,Gvc4Delegate>
@property(nonatomic,strong) NSArray *schoolArray;
@property(nonatomic, weak) GuideViewController4 *gvc4;
@end

@implementation GuideViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.schoolPicker.delegate = self;
    self.schoolArray = @[@"The Information School",
                         @"College of Built Environments",
                         @"College of Education",
                         @"College of Engineering",
                         @"School of Business Administration",
                         @"School of Nursing",
                         @"School of Pharmacy"];
    self.schoolTextField.text = @"The Information School";
    


}

- (IBAction)goButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.gvc4 = [storyboard instantiateViewControllerWithIdentifier:@"gvc4"];
    self.gvc4.gvc4Delegate = self;
    self.gvc4.schoolName = self.schoolTextField.text;
    [self presentViewController:self.gvc4 animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return  [self.schoolArray count];
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return self.schoolArray[row];
//}

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

# pragma mark Gvc4Delegate
- (void)gvc4IsDismissed {
    self.myImage = self.gvc4.myImage;
    self.mySkills = self.gvc4.mySkills;
    self.wantToLearn = self.gvc4.wantToLearn;
    self.yearEnrolled = self.gvc4.yearEnrolled;
    self.majorName = self.gvc4.majorTextField.text;

    [self.gvc3Delegate gvc3IsDismissed];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
