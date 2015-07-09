//
//  ProfileTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/17/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "ProfileTableViewCell.h"
#import "AppDelegate.h"

@interface ProfileTableViewController () <UIAlertViewDelegate>

@end



@implementation ProfileTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.tableFooterView.frame.size.width, 20)];
    self.tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
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
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    // Return the number of rows in the section.
    if (section == 0) return 1;
    else if (section == 1) {
        NSString *aboutMe = [[PFUser currentUser] objectForKey:@"aboutMe"];
        if ([aboutMe isEqualToString:@""] || aboutMe == nil) {
            return 0;
        }
        return 1;
    }
    else if (section == 2) return [appDelegate.mySkills count];
    else if (section == 3) return [appDelegate.wantToLearns count];
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
        cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
        
        PFUser *user = [PFUser currentUser];
        cell.realname.text = [user objectForKey:@"realName"];
        cell.usermajor.text = [user objectForKey:@"major"];
        NSString *year = [user objectForKey:@"enrollYear"];
        cell.enrollyear.text = [NSString stringWithFormat:@"Enrolled in %@", year];
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        cell.userimage.image = appDelegate.userImage;
        cell.userimage.layer.cornerRadius = cell.userimage.frame.size.width / 2.0f;
        cell.userimage.layer.masksToBounds = YES;
        
    }
    else if (indexPath.section == 1) {
        PFUser *user = [PFUser currentUser];
        cell = [tableView dequeueReusableCellWithIdentifier:@"AboutCell" forIndexPath:indexPath];
        [cell setIndentationLevel:1];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = [user objectForKey:@"aboutMe"];

        
    }
    else if (indexPath.section == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"MySkillCell" forIndexPath:indexPath];
        
        NSArray *viewsToRemove = [cell subviews];
        for (UIView *v in viewsToRemove) {
            [v removeFromSuperview];
        }
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 44)];

        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        title.text = appDelegate.mySkills[indexPath.row][@"skillName"];
        [cell addSubview:title];
        
        UILabel *likeCount = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width -50, 0, 200, 44)];

        likeCount.textColor = [UIColor lightGrayColor];
        likeCount.font = [UIFont systemFontOfSize:14];
        
        likeCount.text = [NSString stringWithFormat: @"%ld", (long)[appDelegate.mySkills[indexPath.row][@"likes"] count]];
        
        [cell addSubview:likeCount];
        
        
        UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        likeButton.frame = CGRectMake(frame.size.width -86, 0, 44, 44);
        
        UIImage *image = [[UIImage imageNamed:@"thumbUpImg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [likeButton setImage:image forState:UIControlStateNormal];
        likeButton.tintColor = [UIColor blackColor];
        
        likeButton.imageEdgeInsets = UIEdgeInsetsMake(14,14,14,14);
        
        likeButton.enabled = NO;
        
        [cell addSubview:likeButton];
        
        
        
        
        
    }
    else if (indexPath.section == 3) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"ToLearnCell" forIndexPath:indexPath];
        
        NSArray *viewsToRemove = [cell subviews];
        for (UIView *v in viewsToRemove) {
            [v removeFromSuperview];
        }
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 44)];
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        title.text = appDelegate.wantToLearns[indexPath.row][@"skillName"];
        [cell addSubview:title];
        
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
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
            
            
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            addButton.frame = CGRectMake(frame.size.width -55, 8, 44, 44);
            addButton.frame = CGRectMake(94, 8, 44, 44);
            
            UIImage *image = [[UIImage imageNamed:@"editImg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [addButton setImage:image forState:UIControlStateNormal];
            addButton.tintColor = gray;
            
            addButton.imageEdgeInsets = UIEdgeInsetsMake(14,14,14,14);

            
            [addButton addTarget:self action:@selector(editAboutMe:) forControlEvents:UIControlEventTouchUpInside];
            
            [headerView addSubview:addButton];
            
            break;
        }
        case 2: {
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 8, 100, 44)];
            title.text = @"My Skills";
            title.font = [UIFont boldSystemFontOfSize:16.0f];
            title.textColor = gray;
            
            [headerView addSubview:title];
            
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            addButton.frame = CGRectMake(frame.size.width -55, 8, 44, 44);
            addButton.frame = CGRectMake(88, 8, 44, 44);
            addButton.imageEdgeInsets = UIEdgeInsetsMake(14,14,14,14);
            
            UIImage *image = [[UIImage imageNamed:@"addSkillImg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [addButton setImage:image forState:UIControlStateNormal];
            addButton.tintColor = gray;
            [addButton addTarget:self action:@selector(addKnownSkill:) forControlEvents:UIControlEventTouchUpInside];
            
            [headerView addSubview:addButton];

            break;
        
    }
        case 3: {

            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 8, 160, 44)];
            title.text = @"Want to Learn";
            title.font = [UIFont boldSystemFontOfSize:16.0f];
            title.textColor = gray;
            
            [headerView addSubview:title];

            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            addButton.frame = CGRectMake(frame.size.width -55, 8, 44, 44);
            addButton.frame = CGRectMake(126, 8, 44, 44);
            addButton.imageEdgeInsets = UIEdgeInsetsMake(14,14,14,14);
            
            UIImage *image = [[UIImage imageNamed:@"addSkillImg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [addButton setImage:image forState:UIControlStateNormal];
            addButton.tintColor = gray;
            [addButton addTarget:self action:@selector(addToLearnSkill:) forControlEvents:UIControlEventTouchUpInside];

            [headerView addSubview:addButton];
            break;
        }
        
    }
   
    return headerView;
}

- (void) editAboutMe:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil
                                                     message:@"About me"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    alert.tag = 1;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField1 = [alert textFieldAtIndex:0];
    alertTextField1.keyboardType = UIKeyboardTypeDefault;
    alertTextField1.text = [[PFUser currentUser] objectForKey:@"aboutMe"];
    [alertTextField1 becomeFirstResponder];
    
    [alert show];
}

- (void) addKnownSkill:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil
                                                     message:@"Add a skill"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    alert.tag = 2;
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField1 = [alert textFieldAtIndex:0];
    alertTextField1.autocapitalizationType = UITextAutocapitalizationTypeWords;
    alertTextField1.keyboardType = UIKeyboardTypeDefault;
    [alertTextField1 becomeFirstResponder];
    
    [alert show];
}

- (void) addToLearnSkill:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil
                                                     message:@"Add a skill"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    alert.tag = 3;
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField1 = [alert textFieldAtIndex:0];
    alertTextField1.autocapitalizationType = UITextAutocapitalizationTypeWords;
    alertTextField1.keyboardType = UIKeyboardTypeDefault;
    [alertTextField1 becomeFirstResponder];
    [alert show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        if (alertView.tag == 1) {
            NSString *aboutMe = [alertView textFieldAtIndex:0].text;
            PFUser *user = [PFUser currentUser];
            [user setObject:aboutMe forKey:@"aboutMe"];
            [user saveInBackground];
            [self.tableView reloadData];

        }
        
        else if (alertView.tag == 2) {
            NSString *skill = [alertView textFieldAtIndex:0].text;
            
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            
            BOOL isDuplicated = false;
            for (int i = 0; i < [appDelegate.mySkills count]; i++) {
                if ([[[appDelegate.mySkills[i] objectForKey:@"skillName"] lowercaseString] isEqualToString:[skill lowercaseString]]
                    &&
                    [[appDelegate.mySkills[i] objectForKey:@"skillType"] isEqualToString:@"known"])
                {
                    isDuplicated = true;
                    break;
                }
            }
            if (!isDuplicated) {
                PFObject *userSkill = [PFObject objectWithClassName:@"UserSkill"];
                PFUser *user = [PFUser currentUser];
                
                [userSkill setObject:skill forKey:@"skillName"];
                [userSkill setObject:@"known" forKey:@"skillType"];
                [userSkill setObject:[user objectId] forKey:@"userId"];
                [appDelegate.mySkills addObject:userSkill];
                [userSkill saveInBackground];
                
                [self.tableView reloadData];
            }
            
        } else if (alertView.tag == 3) {
            NSString *skill = [alertView textFieldAtIndex:0].text;
            
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            
            BOOL isDuplicated = false;
            for (int i = 0; i < [appDelegate.wantToLearns count]; i++) {
                if ([[[appDelegate.wantToLearns[i] objectForKey:@"skillName"] lowercaseString] isEqualToString:[skill lowercaseString]]
                    &&
                    [[appDelegate.wantToLearns[i] objectForKey:@"skillType"] isEqualToString:@"toLearn"])
                {
                    isDuplicated = true;
                    break;
                }
            }
            if (!isDuplicated) {
                PFObject *userSkill = [PFObject objectWithClassName:@"UserSkill"];
                PFUser *user = [PFUser currentUser];
                
                [userSkill setObject:skill forKey:@"skillName"];
                [userSkill setObject:@"toLearn" forKey:@"skillType"];
                [userSkill setObject:[user objectId] forKey:@"userId"];
                [appDelegate.wantToLearns addObject:userSkill];
                [userSkill saveInBackground];
                
                [self.tableView reloadData];
            }
        }
    }
}



// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if (indexPath.section == 0 || indexPath.section == 1) {
        return NO;
    } else {
        return YES;
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        if (indexPath.section == 2) {
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            
            PFObject *object = [appDelegate.mySkills objectAtIndex:indexPath.row];
            [object deleteInBackground];
            [appDelegate.mySkills removeObjectAtIndex:indexPath.row];
            
            [self.tableView reloadData];
            
        } else if (indexPath.section == 3) {
            
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            
            PFObject *object = [appDelegate.wantToLearns objectAtIndex:indexPath.row];
            [object deleteInBackground];
            [appDelegate.wantToLearns removeObjectAtIndex:indexPath.row];

            [self.tableView reloadData];
            
        }

    }

}




@end
