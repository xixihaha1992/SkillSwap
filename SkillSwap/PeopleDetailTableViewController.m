//
//  PeopleDetailTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/14/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleDetailTableViewController.h"
#import "ProfileTableViewCell.h"
#import <MessageUI/MessageUI.h>
#import <Parse/Parse.h>

@interface PeopleDetailTableViewController () <MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSMutableArray *skills;
@property (nonatomic, strong) NSMutableArray *wants;


@end

@implementation PeopleDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFQuery *query = [PFUser query];
    self.user = (PFUser *)[query getObjectWithId:self.userId];
    
    UIImage *emailImage = [UIImage imageNamed:@"emailImg.png"];
    UIBarButtonItem *emailButton = [[UIBarButtonItem alloc] initWithImage:emailImage landscapeImagePhone:emailImage style:UIBarButtonItemStylePlain target:self action:@selector(emailTapped:)];
    self.navigationItem.rightBarButtonItem = emailButton;

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.tableFooterView.frame.size.width, 20)];
    self.tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
}

- (void)emailTapped:(id)sender {
    //Email Subject
    NSString *emailTitle = [NSString stringWithFormat:@"[SkillSwap] From %@",[[PFUser currentUser] objectForKey:@"realName"]];
    //Email Content
    NSString *messageBody = @"";
    //To address
    NSString *email = [self.user objectForKey:@"myEmail"];
    NSArray *toRecipients = [NSArray arrayWithObject:email];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipients];
    
    //present mail view controller on screen
    [self presentViewController:mc animated:YES completion: NULL];
    
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            
        default:
            break;
    }
    //close the mail interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"UserSkill"];
    [query1 whereKey:@"userId" equalTo:[self.user objectId]];
    [query1 whereKey:@"skillType" equalTo:@"known"];
    [query1 selectKeys:@[@"skillName",@"skillType",@"likes"]];
    
    self.skills = [[NSMutableArray alloc] initWithArray:[query1 findObjects]];
    [self sortByLikes:self.skills];
    
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"UserSkill"];
    [query2 whereKey:@"userId" equalTo:[self.user objectId]];
    [query2 whereKey:@"skillType" equalTo:@"toLearn"];
    [query2 selectKeys:@[@"skillName",@"skillType"]];
    
    PFFile *file = [self.user objectForKey:@"userImg"];
    
    
    self.wants = [[NSMutableArray alloc] initWithArray:[query2 findObjects]];
    self.image  = [UIImage imageWithData:[file getData]];
    
    
    [self.tableView reloadData];

}

- (void)sortByLikes:(NSMutableArray *)likes {
    
    for (NSInteger i = 1 ; i < [likes count]; i++) {
        PFObject *temp = likes[i];
        NSInteger j;
        for (j = i - 1; j >= 0 && [[temp objectForKey:@"likes"] count] > [[likes[j] objectForKey:@"likes"] count]; j--) {
            likes[j+1] = likes[j];
        }
        likes[j+1] = temp;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) return 1;
    else if (section == 1) {
        NSString *aboutMe = [self.user objectForKey:@"aboutMe"];
        if ([aboutMe isEqualToString:@""] || aboutMe == nil) {
            return 0;
        }
        return 1;
    }
    
    else if (section == 2) return [self.skills count];
    else if (section == 3) return [self.wants count];
    else return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return CGFLOAT_MIN;
    return 52.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 230.0f;
    }
    else {
        return 44.0f;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileTableViewCell *cell;
    CGRect frame = tableView.frame;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell1" forIndexPath:indexPath];
        
        cell.realname.text = [self.user objectForKey:@"realName"];
        cell.usermajor.text = [self.user objectForKey:@"major"];
        NSString *year = [self.user objectForKey:@"enrollYear"];
        cell.enrollyear.text = [NSString stringWithFormat:@"Enrolled in %@", year];
        
        cell.userimage.image = self.image;
        cell.userimage.layer.cornerRadius = cell.userimage.frame.size.width / 2.0f;
        cell.userimage.layer.masksToBounds = YES;
        
    }
    else if (indexPath.section == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"AboutCell1" forIndexPath:indexPath];
        
        [cell setIndentationLevel:1];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = [self.user objectForKey:@"aboutMe"];
        
    }
    else if (indexPath.section == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"MySkillCell1" forIndexPath:indexPath];
        
        NSArray *viewsToRemove = [cell subviews];
        for (UIView *v in viewsToRemove) {
            [v removeFromSuperview];
        }
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 44)];
        
        title.text = self.skills[indexPath.row][@"skillName"];
        [cell addSubview:title];
        
        
        UILabel *likeCount = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width -50, 0, 200, 44)];
        
        likeCount.textColor = [UIColor lightGrayColor];
        likeCount.font = [UIFont systemFontOfSize:14];
        
        likeCount.text = [NSString stringWithFormat: @"%ld", (long)[self.skills[indexPath.row][@"likes"] count]];
        
        [cell addSubview:likeCount];
        
        
        UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        likeButton.frame = CGRectMake(frame.size.width -86, 0, 44, 44);
        
        UIImage *image = [[UIImage imageNamed:@"thumbUpImg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [likeButton setImage:image forState:UIControlStateNormal];
        
        if ([self isInLikes:self.skills[indexPath.row]]) {
            UIColor *pink = [UIColor colorWithRed:232/255.0 green:51/255.0 blue:102/255.0 alpha:1];
            likeButton.tintColor = pink;
        } else {
            likeButton.tintColor = [UIColor blackColor];
        }
        
        
        
        likeButton.imageEdgeInsets = UIEdgeInsetsMake(14,14,14,14);
        
        [likeButton addTarget:self action:@selector(likeTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:likeButton];
        
    }
    else if (indexPath.section == 3) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"ToLearnCell1" forIndexPath:indexPath];
        
        NSArray *viewsToRemove = [cell subviews];
        for (UIView *v in viewsToRemove) {
            [v removeFromSuperview];
        }
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 44)];
        
        title.text = self.wants[indexPath.row][@"skillName"];
        [cell addSubview:title];
        
        
        
    }
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGRect frame = tableView.frame;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIColor *gray = [UIColor lightGrayColor];
    
    switch (section) {
        case 1: {
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 8, 100, 44)];
            title.text = @"About Me";
            title.font = [UIFont boldSystemFontOfSize:16.0f];
            title.textColor = gray;
            
            [headerView addSubview:title];
            
            
            break;
        }
        case 2: {
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 8, 100, 44)];
            title.text = @"Skills";
            title.font = [UIFont boldSystemFontOfSize:16.0f];
            title.textColor = gray;
            
            [headerView addSubview:title];
            
            break;
        }
        case 3: {
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 8, 160, 44)];
            title.text = @"Want to Learn";
            title.font = [UIFont boldSystemFontOfSize:16.0f];
            title.textColor = gray;
            
            [headerView addSubview:title];
            
    
            break;
        }
            
    }
//    headerView.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
    
    return headerView;
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return NO;
}


- (void)likeTapped:(id)sender {
    CGPoint buttonOriginInTableView = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonOriginInTableView];
    UIButton *thisButton = (UIButton *)sender;
    
    NSString *currUserId = [[PFUser currentUser] objectId];
    
    if ([self isInLikes:self.skills[indexPath.row]]) {
        thisButton.tintColor = [UIColor blackColor];
        
//        NSMutableArray *userIds =[self.skills[indexPath.row] objectForKey:@"likes"];
//        for(NSString *userId in userIds) {
//            if([userId isEqualToString:currUserId]) {
//                [userIds removeObject:userId];
//                break;
//            }
//        }
        [self.skills[indexPath.row] removeObjectsInArray:@[currUserId] forKey:@"likes"];
        [self.skills[indexPath.row] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self.tableView reloadData];
            } else {
                NSLog(@"%@", error);
            }
        }];
    } else {
        UIColor *pink = [UIColor colorWithRed:232/255.0 green:51/255.0 blue:102/255.0 alpha:1];
        thisButton.tintColor = pink;
        
        [self.skills[indexPath.row] addObject:currUserId forKey:@"likes"];
        [self.skills[indexPath.row] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self.tableView reloadData];
            } else {
                NSLog(@"%@", error);
            }
        }];
    }
}

- (BOOL)isInLikes:(PFObject *)userSkill {
    for (NSInteger i = 0; i < [[userSkill objectForKey:@"likes"] count]; i++) {
        if ([[userSkill objectForKey:@"likes"][i] isEqualToString:[[PFUser currentUser] objectId]]) {
            return true;
        }
    }
    return false;
}

@end
