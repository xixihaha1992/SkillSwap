//
//  SettingsTableViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "AppDelegate.h"
#import "UpdateNameViewController.h"
#import "UpdateEmailViewController.h"
#import "UpdateSchoolViewController.h"
#import "UpdateMajorViewController.h"
#import "UpdateYearViewController.h"

@interface SettingsTableViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UpdateSchoolViewControllerDelegate>
@property (nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFUser *user = [PFUser currentUser];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (user) {
        
        
        self.schoolLabel.text = [user objectForKey:@"school"];
        self.majorLabel.text = [user objectForKey:@"major"];
        self.userImg.image = appDelegate.userImage;
        
        self.userImg.layer.cornerRadius = self.userImg.frame.size.width / 2.0f;
        self.userImg.layer.masksToBounds = YES;
        self.userName.text = [NSString stringWithFormat:@"Username: %@",[user objectForKey:@"username"]];
        self.realNameTop.text = [user objectForKey:@"realName"];
        self.realNameLabel.text = [user objectForKey:@"realName"];
        self.emailLabel.text = [user objectForKey:@"myEmail"];
        self.yearLabel.text = [user objectForKey:@"enrollYear"];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Do whatever you like with indexpath.row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3 && indexPath.row == 0) {
        
        
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        // Create the actions.
        UIAlertAction *signOut = [UIAlertAction actionWithTitle:@"Sign Out" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
                [PFUser logOut];
                AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                [appDelegate resetWindowToInitialView];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            }];
        
        // Add the actions.
        [alertController addAction:signOut];

        [alertController addAction:cancel];
        
        // Configure the alert controller's popover presentation controller if it has one.
        UIPopoverPresentationController *popoverPresentationController = [alertController popoverPresentationController];
        if (popoverPresentationController) {
            popoverPresentationController.sourceView = self.view;
            popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        }
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15.0f;
    }
    return 5.0f;
}




# pragma mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segueName"]) {
        UINavigationController *nav = segue.destinationViewController;
        NSArray *viewControllers = nav.viewControllers;
        UpdateNameViewController *destination = [viewControllers objectAtIndex:0];
        destination.userName = self.realNameLabel.text;
    }
    else if ([segue.identifier isEqualToString:@"segueEmail"]) {
        UINavigationController *nav = segue.destinationViewController;
        NSArray *viewControllers = nav.viewControllers;
        UpdateEmailViewController *destination = [viewControllers objectAtIndex:0];
        destination.email = self.emailLabel.text;
    }
    else if ([segue.identifier isEqualToString:@"segueSchool"]) {
        UINavigationController *nav = segue.destinationViewController;
        NSArray *viewControllers = nav.viewControllers;
        UpdateSchoolViewController *destination = [viewControllers objectAtIndex:0];
        destination.school = self.schoolLabel.text;
        destination.schoolDelegate = self;
    }
    else if ([segue.identifier isEqualToString:@"segueMajor"]) {
        UINavigationController *nav = segue.destinationViewController;
        NSArray *viewControllers = nav.viewControllers;
        UpdateMajorViewController *destination = [viewControllers objectAtIndex:0];
        destination.school = self.schoolLabel.text;
        destination.major = self.majorLabel.text;
    }
    else if ([segue.identifier isEqualToString:@"segueYear"]) {
        UINavigationController *nav = segue.destinationViewController;
        NSArray *viewControllers = nav.viewControllers;
        UpdateYearViewController *destination = [viewControllers objectAtIndex:0];
        destination.year = self.yearLabel.text;
    }
    
}





- (IBAction)changeImagePressed:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *choosePhoto = [UIAlertAction actionWithTitle:@"Choose from Photos" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    // Add the actions.
    [alertController addAction:takePhoto];
    [alertController addAction:choosePhoto];
    [alertController addAction:cancel];
    
    
    // Configure the alert controller's popover presentation controller if it has one.
    UIPopoverPresentationController *popoverPresentationController = [alertController popoverPresentationController];
    if (popoverPresentationController) {
        popoverPresentationController.sourceView = self.view;
        popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    
    self.tabBarController.tabBar.hidden = YES;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    imagePickerController.delegate = self;
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImage *croppedImage = [self squareImageWithImage:image scaledToSize:CGSizeMake(80.0f,80.0f)];
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.imagePickerController = nil;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.userImage = croppedImage;
    
    NSData* data = UIImageJPEGRepresentation(croppedImage, 0.7f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    [imageFile save];
    [[PFUser currentUser] setObject:imageFile forKey:@"userImg"];
    [[PFUser currentUser] save];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.tabBarController.tabBar.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * image.size.width) + delta,
                                 (ratio * image.size.height) + delta);
    
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

# pragma mark UpdateSchoolDelegate 
- (void) updateSchoolDismissed {
    NSArray *majorArray;
    PFUser *user = [PFUser currentUser];
    NSString *school = [user objectForKey:@"school"];
    NSString *major = [user objectForKey:@"major"];
    
    if ([school isEqualToString:@"The Information School"]) {
        majorArray = @[@"Informatics (INFO)",
                       @"Information Management and Technology (IMT)",
                       @"Information School Interdisciplinary (INFX)",
                       @"Information Science (INSC)",
                       @"Information Technology Applications (ITA)",
                       @"Library and Information Science (LIS)"];
    }
    else if ([school isEqualToString:@"College of Built Environments"]) {
        majorArray = @[@"Architecture (ARCH)",
                       @"Built Environment (B E)",
                       @"College of Architecture and Urban Planning (CAUP)",
                       @"Construction Management (CM)",
                       @"Landscape Architecture (L ARCH)",
                       @"Community, Environment, and Planning (CEP)",
                       @"Real Estate (R E)",
                       @"Strategic Planning for Critical Infrastructures (SPCI)",
                       @"Urban Planning (URBDP)"];
    }
    else if ([school isEqualToString:@"College of Education"]) {
        majorArray = @[@"Curriculum and Instruction (EDC&I)",
                       @"College of Education (EDUC)",
                       @"Early Childhood and Family Studies (ECFS)",
                       @"Education (Teacher Education Program) (EDTEP)",
                       @"Educational Leadership and Policy Studies (EDLPS)",
                       @"Educational Psychology (EDPSY)",
                       @"Special Education (EDSPE)"];
    }
    else if ([school isEqualToString:@"College of Engineering"]) {
        majorArray = @[@"Aeronautics and Astronautics (A A)",
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
    else if ([school isEqualToString:@"School of Business Administration"]) {
        majorArray = @[@"Accounting (ACCTG)",
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
    else if ([school isEqualToString:@"School of Nursing"]) {
        majorArray = @[@"Nursing (NSG)",
                       @"Nursing (NURS)",
                       @"Nursing Clinical (NCLIN)",
                       @"Nursing Methods (NMETH)"];
    }
    else if ([school isEqualToString:@"School of Pharmacy"]) {
        majorArray = @[@"Medicinal Chemistry (MEDCH)",
                       @"Pharmaceutics (PCEUT)",
                       @"Pharmacy (PHARM)",
                       @"Pharmacy Practice (PHARMP)",
                       @"Pharmacy Regulatory Affairs (PHRMRA)"];
    }
    
    BOOL flag = false;
    
    for (NSInteger i = 0; i < [majorArray count]; i++) {
        if ([majorArray[i] isEqualToString:major]) {
            flag = true;
            break;
        }
    }
    
    if (flag) {
        self.majorLabel.text = major;
    } else {
        self.majorLabel.text = majorArray[0];
        [user setObject:majorArray[0] forKey:@"major"];
        [user save];
    }
    [self.tableView reloadData];
}




@end
