//
//  GuideViewController5.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "GuideViewController5.h"
#import "GuideViewController6.h"

@interface GuideViewController5 () <UIPickerViewDelegate, Gvc6Delegate>
@property (nonatomic,strong) NSMutableArray *yearArray;
@property (nonatomic, weak) GuideViewController6 *gvc6;

@end

@implementation GuideViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.yearPicker.delegate = self;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearInString = [dateFormatter stringFromDate:[NSDate date]];
    self.yearTextField.text = yearInString;
    
    self.yearArray = [[NSMutableArray alloc] init];
    for (int i = 2000; i <= [yearInString intValue]; i++) {
        [self.yearArray addObject:[NSString stringWithFormat: @"%ld", (long)(i)]];
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    self.yearEnrolled =[dateFormatter stringFromDate:[NSDate date]];
    NSInteger yearInInteger = [self.yearEnrolled intValue];
    [self.yearPicker selectRow:(yearInInteger-2000) inComponent:0 animated:NO];
}



- (IBAction)goButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.gvc6 = [storyboard instantiateViewControllerWithIdentifier:@"gvc6"];
    self.gvc6.gvc6Delegate = self;
    
    [self presentViewController:self.gvc6 animated:YES completion:nil];
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

# pragma mark Gvc6Delegate
- (void)gvc6IsDismissed{
    self.myImage = self.gvc6.myImage;
    self.mySkills = [[NSArray alloc] initWithArray:self.gvc6.selectedSkills];
    self.wantToLearn = self.gvc6.wantToLearn;
    
    [self.gvc5Delegate gvc5IsDismissed];
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
