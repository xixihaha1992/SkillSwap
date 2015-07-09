//
//  GuideViewController4.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "GuideViewController4.h"
#import "GuideViewController5.h"

@interface GuideViewController4 () <UIPickerViewDelegate,Gvc5Delegate>
@property(nonatomic,strong) NSArray *majorArray;
@property(nonatomic,weak) GuideViewController5 *gvc5;
@end

@implementation GuideViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.majorPicker.delegate = self;
    
    if ([self.schoolName isEqualToString:@"The Information School"]) {
        self.majorArray = @[@"Informatics (INFO)",
                            @"Information Management and Technology (IMT)",
                            @"Information School Interdisciplinary (INFX)",
                            @"Information Science (INSC)",
                            @"Information Technology Applications (ITA)",
                            @"Library and Information Science (LIS)"];
    }
    else if ([self.schoolName isEqualToString:@"College of Built Environments"]) {
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
    else if ([self.schoolName isEqualToString:@"College of Education"]) {
        self.majorArray = @[@"Curriculum and Instruction (EDC&I)",
                            @"College of Education (EDUC)",
                            @"Early Childhood and Family Studies (ECFS)",
                            @"Education (Teacher Education Program) (EDTEP)",
                            @"Educational Leadership and Policy Studies (EDLPS)",
                            @"Educational Psychology (EDPSY)",
                            @"Special Education (EDSPE)"];
    }
    else if ([self.schoolName isEqualToString:@"College of Engineering"]) {
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
    else if ([self.schoolName isEqualToString:@"School of Business Administration"]) {
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
    else if ([self.schoolName isEqualToString:@"School of Nursing"]) {
        self.majorArray = @[@"Nursing (NSG)",
                            @"Nursing (NURS)",
                            @"Nursing Clinical (NCLIN)",
                            @"Nursing Methods (NMETH)"];
    }
    else if ([self.schoolName isEqualToString:@"School of Pharmacy"]) {
        self.majorArray = @[@"Medicinal Chemistry (MEDCH)",
                            @"Pharmaceutics (PCEUT)",
                            @"Pharmacy (PHARM)",
                            @"Pharmacy Practice (PHARMP)",
                            @"Pharmacy Regulatory Affairs (PHRMRA)"];
    }
    self.majorTextField.text = self.majorArray[0];
    
    
    
}

- (IBAction)goButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.gvc5 = [storyboard instantiateViewControllerWithIdentifier:@"gvc5"];
    self.gvc5.gvc5Delegate = self;

    [self presentViewController:self.gvc5 animated:YES completion:nil];
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
    return  [self.majorArray count];
}



-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.majorTextField.text = self.majorArray[row];
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


# pragma mark Gvc5Delegate
- (void)gvc5IsDismissed {
    self.myImage = self.gvc5.myImage;
    self.mySkills = self.gvc5.mySkills;
    self.wantToLearn = self.gvc5.wantToLearn;
    self.yearEnrolled = self.gvc5.yearTextField.text;
    
    [self.gvc4Delegate gvc4IsDismissed];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
