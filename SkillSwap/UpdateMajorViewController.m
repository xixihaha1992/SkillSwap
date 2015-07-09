//
//  UpdateMajorViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "UpdateMajorViewController.h"
#import <Parse/Parse.h>

@interface UpdateMajorViewController () <UIPickerViewDelegate>
@property(nonatomic,strong) NSArray *majorArray;

@end

@implementation UpdateMajorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.majorPicker.delegate = self;
    
    if ([self.school isEqualToString:@"The Information School"]) {
        self.majorArray = @[@"Informatics (INFO)",
                            @"Information Management and Technology (IMT)",
                            @"Information School Interdisciplinary (INFX)",
                            @"Information Science (INSC)",
                            @"Information Technology Applications (ITA)",
                            @"Library and Information Science (LIS)"];
    }
    else if ([self.school isEqualToString:@"College of Built Environments"]) {
        self.majorArray = @[@"Architecture (ARCH)",
                            @"Built Environment (B E)",
                            @"College of Architecture and Urban Planning (CAUP)",
                            @"Construction Management (CM)",
                            @"Landscape Architecture (L ARCH)",
                            @"Community, Environment, and Planning (CEP)",
                            @"Real Estate (R E)",
                            @"Strategic Planning for Critical Infrastructures (SPCI)",
                            @"Urban Planning (URBDP)"];
    }
    else if ([self.school isEqualToString:@"College of Education"]) {
        self.majorArray = @[@"Curriculum and Instruction (EDC&I)",
                            @"College of Education (EDUC)",
                            @"Early Childhood and Family Studies (ECFS)",
                            @"Education (Teacher Education Program) (EDTEP)",
                            @"Educational Leadership and Policy Studies (EDLPS)",
                            @"Educational Psychology (EDPSY)",
                            @"Special Education (EDSPE)"];
    }
    else if ([self.school isEqualToString:@"College of Engineering"]) {
        self.majorArray = @[@"Aeronautics and Astronautics (A A)",
                            @"Aerospace Engineering (A E)",
                            @"Chemical Engineering (CHEM E)",
                            @"Nanoscience and Molecular Engineering (NME)",
                            @"Civil and Environmental Engineering (CEE)",
                            @"Computer Science and Engineering (CSE)",
                            @"Computer Science and Engineering (CSE M)",
                            @"Computer Science and Engineering (CSE P)",
                            @"Electrical Engineering (E E)",
                            @"Engineering (ENGR)",
                            @"Human Centered Design and Engineering (HCDE)",
                            @"Technical Communication (T C)",
                            @"Industrial Engineering (IND E)",
                            @"Materials Science and Engineering (MS E)",
                            @"Mechanical Engineering (M E)",
                            @"Mechanical Engineering Industrial Engineering (MEIE)"];
    }
    else if ([self.school isEqualToString:@"School of Business Administration"]) {
        self.majorArray = @[@"Accounting (ACCTG)",
                            @"Administration (ADMIN)",
                            @"Business Administration (B A)",
                            @"Business Administration Research Methods (BA RM)",
                            @"Business Communications (B CMU)",
                            @"Business Economics (B ECON)",
                            @"Business Policy (B POL)",
                            @"Electronic Business (EBIZ)",
                            @"Entrepreneurship (ENTRE)",
                            @"Finance (FIN)",
                            @"Human Resources Management and Organizational Behavior (HRMOB)",
                            @"Information Systems (I S)",
                            @"Information Systems Master of Science (MSIS)",
                            @"International Business (I BUS)",
                            @"Management (MGMT)",
                            @"Marketing (MKTG)",
                            @"Operations Management (OPMGT)",
                            @"Organization and Environment (O E)",
                            @"Program on Entrepreneurial Innovation (PEI)",
                            @"Quantitative Methods (QMETH)",
                            @"Strategic Management (ST MGT)"];
    }
    else if ([self.school isEqualToString:@"School of Nursing"]) {
        self.majorArray = @[@"Nursing (NSG)",
                            @"Nursing (NURS)",
                            @"Nursing Clinical (NCLIN)",
                            @"Nursing Methods (NMETH)"];
    }
    else if ([self.school isEqualToString:@"School of Pharmacy"]) {
        self.majorArray = @[@"Medicinal Chemistry (MEDCH)",
                            @"Pharmaceutics (PCEUT)",
                            @"Pharmacy (PHARM)",
                            @"Pharmacy Practice (PHARMP)",
                            @"Pharmacy Regulatory Affairs (PHRMRA)"];
    }
    
    
    self.majorTextField.text = self.major;
    
    NSInteger rowInt;
    for (NSInteger i = 0; i < [self.majorArray count]; i++) {
        if ([self.majorArray[i] isEqualToString:self.major]) {
            rowInt = i;
            break;
        }
    }
    [self.majorPicker selectRow:rowInt inComponent:0 animated:NO];
    
}

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return  [self.majorArray count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.majorTextField.text = self.majorArray[row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    text.text =  self.majorArray[row];
    
    return text;
}



- (IBAction)savePressed:(id)sender {
    PFUser *user = [PFUser currentUser];
    [user setObject:self.majorTextField.text forKey:@"major"];
    [user save];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
