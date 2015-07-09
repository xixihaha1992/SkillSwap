//
//  GuideViewController6.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/8/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "GuideViewController6.h"
#import "SelectTableViewCell.h"
#import "GuideViewController7.h"

@interface GuideViewController6 () <UITableViewDataSource, UITableViewDelegate, SelectTableViewCellDelegate, Gvc7Delegate>
@property (nonatomic, strong) NSArray *skillArray;
@property (nonatomic, weak) GuideViewController7 *gvc7;

@end

@implementation GuideViewController6

- (void)viewDidLoad {
    self.selectedSkills = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    self.skillArray = @[@"Java",
                        @"JavaScript",
                        @"Python",
                        @"Big Data",
                        @"Data Science",
                        @"Database",
                        @"Interaction Design",
                        @"UI Design",
                        @"Prototyping",
                        @"Photoshop",
                        @"Football",
                        @"Cooking",
                        @"Mandarin"
];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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

- (IBAction)goButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.gvc7 = [storyboard instantiateViewControllerWithIdentifier:@"gvc7"];
    self.gvc7.gvc7Delegate = self;
    [self presentViewController:self.gvc7 animated:YES completion:nil];
}



#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.skillArray.count;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update the delete button's title based on how many items are selected.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update the delete button's title based on how many items are selected.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure a cell to show the corresponding string from the array.
    static NSString *kCellID = @"selectCell";
    SelectTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellID];
    cell.textLabel.text = [self.skillArray objectAtIndex:indexPath.row];
    cell.skillName = self.skillArray[indexPath.row];
    cell.myDelegate = self;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

# pragma mark SelectTableViewCellDelegate

- (void)buttonChecked:(SelectTableViewCell *)cell {
    [self.selectedSkills addObject:cell.skillName];
    NSLog(@"checked,%@",cell.skillName);
}
- (void)buttonUnchecked:(SelectTableViewCell *)cell {
    [self.selectedSkills removeObject:cell.skillName];
    NSLog(@"unchecked,%@",cell.skillName);
}

# pragma mark Gvc7Delegate
- (void)gvc7IsDismissed {
    self.myImage = self.gvc7.myImage;
    self.wantToLearn = [[NSArray alloc] initWithArray:self.gvc7.selectedSkills];
    [self.gvc6Delegate gvc6IsDismissed];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
