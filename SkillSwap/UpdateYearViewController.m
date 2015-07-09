//
//  UpdateYearViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "UpdateYearViewController.h"
#import <Parse/Parse.h>

@interface UpdateYearViewController () <UIPickerViewDelegate>
@property (nonatomic,strong) NSMutableArray *yearArray;

@end

@implementation UpdateYearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.yearPicker.delegate = self;
    self.yearTextField.text = self.year;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearInString = [dateFormatter stringFromDate:[NSDate date]];
    
    self.yearArray = [[NSMutableArray alloc] init];
    for (int i = 2000; i <= [yearInString intValue]; i++) {
        [self.yearArray addObject:[NSString stringWithFormat: @"%ld", (long)(i)]];
    }
    
    NSInteger yearInInteger = [self.year intValue];
    [self.yearPicker selectRow:yearInInteger-2000 inComponent:0 animated:NO];
    // Do any additional setup after loading the view.
}

#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return  [self.yearArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.yearArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.yearTextField.text = self.yearArray[row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)savePressed:(id)sender {
    PFUser *user = [PFUser currentUser];
    [user setObject:self.yearTextField.text forKey:@"enrollYear"];
    [user save];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
