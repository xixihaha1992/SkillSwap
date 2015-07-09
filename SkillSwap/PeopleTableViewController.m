//
//  PeopleTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/13/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleTableViewController.h"
#import <Parse/Parse.h>
#import "PeopleDetailTableViewController.h"
#import "PeopleResultsTableViewController.h"
//#import "PeoplePopover.h"
#import "PeopleCell.h"
#import "AppDelegate.h"
#import "ActivityView.h"
#import "CellData.h"
#import "PeoplePopover.h"


#define MENU_POPOVER_FRAME  CGRectMake(fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.width)-130, 64, 120, 44)

@interface PeopleTableViewController ()<UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating,PeopleResultTableDelegate,PeoplePopoverDelegate>


@property (nonatomic, assign) BOOL activityViewVisible;
@property (nonatomic, strong) UIView *activityView;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) PeopleResultsTableViewController *resultsTableViewController;

@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;


@property(nonatomic,strong) PeopleResultsTableViewController *tableViewController;

@property(atomic,strong) NSMutableArray *cellDataArray;

@property(nonatomic,strong) PeoplePopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;

//- (IBAction)showMoreOption:(id)sender;
//@property(nonatomic,strong) EventPopover *menuPopover;

@end

@implementation PeopleTableViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.menuItems = [NSArray arrayWithObjects:@"Pick for Me!", nil];
    
    [self setActivityViewVisible:YES];
    
    self.cellDataArray = [[NSMutableArray alloc] init];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    self.resultsTableViewController = [[PeopleResultsTableViewController alloc] init];
    self.resultsTableViewController.resultTableDelegate = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableViewController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.resultsTableViewController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    UIColor *lightGray = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
    UIColor *pink = [UIColor colorWithRed:232/255.0 green:51/255.0 blue:102/255.0 alpha:1];
    
    self.searchController.searchBar.backgroundColor = [UIColor clearColor];
    self.searchController.searchBar.barTintColor = lightGray;
    self.searchController.searchBar.tintColor = pink;
    self.searchController.searchBar.placeholder = @"Search by skills";
    
    self.definesPresentationContext = YES;
    
    CGPoint offset = CGPointMake(0, self.searchController.searchBar.frame.size.height);
    self.tableView.contentOffset = offset;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setActivityViewVisible:YES];
    
    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        self.searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            self.searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
    if ([self.cellDataArray count] == 0) {
        [self findAllMatchedPeople];
        [self.tableView reloadData];
        
    }

    [self setActivityViewVisible:NO];
    self.tableView.userInteractionEnabled = YES;
    self.tableViewController.tableView.userInteractionEnabled = YES;
    
}



- (void) findAllMatchedPeople {
    self.cellDataArray = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    PFUser *user = [PFUser currentUser];
    
    NSArray *knowns = appDelegate.mySkills;
    NSArray *wantToLearns = appDelegate.wantToLearns;
    NSMutableArray *querys = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [wantToLearns count]; i++) {
        PFQuery *query = [PFQuery queryWithClassName:@"UserSkill"];
        NSString *skillName = [wantToLearns[i] objectForKey:@"skillName"];
        [query whereKey:@"skillName" equalTo:[skillName lowercaseString]];
        [query whereKey:@"skillName" equalTo:[skillName capitalizedString]];
        
        [query whereKey:@"skillType" equalTo:@"known"];
        [query whereKey:@"userId" notEqualTo:[user objectId]];
        [querys addObject:query];
    }
    
    for(int i = 0; i < [knowns count]; i++) {
        PFQuery *query = [PFQuery queryWithClassName:@"UserSkill"];
        NSString *skillName = [knowns[i] objectForKey:@"skillName"];
        [query whereKey:@"skillName" equalTo:[skillName lowercaseString]];
        [query whereKey:@"skillName" equalTo:[skillName capitalizedString]];
        
        [query whereKey:@"skillType" equalTo:@"toLearn"];
        [query whereKey:@"userId" notEqualTo:[user objectId]];
        [querys addObject:query];
    }
    
    PFQuery *queryPeers = [PFQuery orQueryWithSubqueries:querys];
    queryPeers.limit = 20;
    
    NSArray *matchedUserSkills = [queryPeers findObjects];
    
    appDelegate.matchedPeople = matchedUserSkills;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < [matchedUserSkills count]; i++) {
        NSString *userId = [matchedUserSkills[i] objectForKey:@"userId"];
        
        BOOL isKnown = false;
        if ([[matchedUserSkills[i] objectForKey:@"skillType"] isEqualToString:@"known"]) {
            isKnown = true;
        }
        
        NSInteger likeCount =[[matchedUserSkills[i] objectForKey:@"likes"] count];
        
        NSNumber *rating;
        
        if ([dict objectForKey:userId]) {
            rating = [dict objectForKey:userId];
            
            if (isKnown) {
                rating = [NSNumber numberWithInteger:([rating integerValue]+(likeCount+1)*5)];
            } else {
                rating = [NSNumber numberWithInteger:([rating integerValue]+3)];
            }
            [dict setValue:rating forKey:userId];
            
        } else {
            if (isKnown) {
                rating = [NSNumber numberWithInteger:(likeCount+1)*5];
            } else {
                rating = [NSNumber numberWithInteger:(likeCount+3)];
            }
            
            
            [dict setObject:rating forKey:userId];
        }
        
        
//        
//        if ([dict objectForKey:userId]) {
//            rating = [dict objectForKey:userId];
//            rating = [NSNumber numberWithInteger:([rating integerValue]+1)];
//            [dict setValue:rating forKey:userId];
//            
//        } else {
//            rating = [NSNumber numberWithInteger:1];
//            
//            [dict setObject:rating forKey:userId];
//        }
    }
    
    self.people = [dict keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] > [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    for (NSInteger i = 0; i < [self.people count]; i++) {
        NSString *usrId = self.people[i];
        CellData *cellData = [[CellData alloc] init];
        
        PFQuery *query = [PFUser query];
        PFUser *usr = (PFUser *)[query getObjectWithId:usrId];
        
        PFFile *file = [usr objectForKey:@"userImg"];
        cellData.image = [UIImage imageWithData:[file getData]];
        cellData.realName = [usr objectForKey:@"realName"];
        cellData.major = [usr objectForKey:@"major"];
        
        NSMutableString *skillsString = [NSMutableString stringWithString:@"Skills: "];
        NSMutableString *wantsString = [NSMutableString stringWithString:@"Wants: "];
        
        NSArray *userSkills = appDelegate.matchedPeople;
        for (int j = 0; j < [userSkills count]; j++) {
            if ([[userSkills[j] objectForKey:@"skillType"] isEqualToString:@"known"] && [[userSkills[j] objectForKey:@"userId"] isEqualToString:[usr objectId]]) {
                [skillsString appendString:[userSkills[j] objectForKey:@"skillName"]];
                [skillsString appendString:@", "];
            
            }
            else if ([[userSkills[j] objectForKey:@"skillType"] isEqualToString:@"toLearn"] && [[userSkills[j] objectForKey:@"userId"] isEqualToString:[usr objectId]]) {
                [wantsString appendString:[userSkills[j] objectForKey:@"skillName"]];
                [wantsString appendString:@", "];
            }
        }

        NSString *skills = [NSString stringWithString:skillsString];
        NSString *wants = [NSString stringWithString:wantsString];
        cellData.knowns = [skills substringToIndex:skills.length-2];
        cellData.wants = [wants substringToIndex:wants.length-2];
        
        [self.cellDataArray addObject:cellData];
    }
    
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}






#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];

    [self setActivityViewVisible:YES];
    
    NSString *searchText = searchBar.text;
    

    
    NSMutableArray *querys = [[NSMutableArray alloc] init];
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"UserSkill"];
    [query1 whereKey:@"skillType" equalTo:@"known"];
    [query1 whereKey:@"skillName" containsString:[searchText lowercaseString]];
    [querys addObject:query1];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"UserSkill"];
    [query2 whereKey:@"skillType" equalTo:@"known"];
    [query2 whereKey:@"skillName" containsString:[searchText capitalizedString]];
    [querys addObject:query2];
    
    PFQuery *queryPeers = [PFQuery orQueryWithSubqueries:querys];
    queryPeers.limit = 30;
    
    NSArray *searchedUserSkills = [queryPeers findObjects];
    
    self.tableViewController = (PeopleResultsTableViewController *)self.searchController.searchResultsController;
    self.tableViewController.tableView.rowHeight = 96.0;
    
    
    NSMutableArray *filteredCellData = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < [searchedUserSkills count]; i++) {
        NSString *usrId = [searchedUserSkills[i] objectForKey:@"userId"];
        CellData *cellData = [[CellData alloc] init];
        cellData.userId = usrId;
        PFQuery *query = [PFUser query];
        PFUser *usr = (PFUser *)[query getObjectWithId:usrId];
        
        PFFile *file = [usr objectForKey:@"userImg"];
        cellData.image = [UIImage imageWithData:[file getData]];
        cellData.realName = [usr objectForKey:@"realName"];
        cellData.major = [usr objectForKey:@"major"];
        
        
        PFQuery *querySkill = [PFQuery queryWithClassName:@"UserSkill"];
        [querySkill whereKey:@"userId" equalTo:usrId];
        [querySkill selectKeys:@[@"skillName",@"skillType"]];
        
        NSArray *mySkills = [querySkill findObjects];
        
        NSMutableString *skillsString = [NSMutableString stringWithString:@"Skills: "];
        NSMutableString *wantsString = [NSMutableString stringWithString:@"Wants: "];
        
        for (int i = 0; i < [mySkills count]; i++) {
            if ([[mySkills[i] objectForKey:@"skillType"] isEqualToString:@"known"]) {
                [skillsString appendString:[mySkills[i] objectForKey:@"skillName"]];
                [skillsString appendString:@", "];
                
            } else {
                [wantsString appendString:[mySkills[i] objectForKey:@"skillName"]];
                [wantsString appendString:@", "];
            }
        }
        NSString *skills = [NSString stringWithString:skillsString];
        NSString *wants = [NSString stringWithString:wantsString];
        cellData.knowns = [skills substringToIndex:skills.length-2];
        cellData.wants = [wants substringToIndex:wants.length-2];
        
        [filteredCellData addObject:cellData];
    }

    self.tableViewController.filteredCellDataArray = filteredCellData;
    
    self.tableViewController.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setActivityViewVisible:NO];
    [self.tableViewController.tableView reloadData];
    
    self.tableViewController.tableView.userInteractionEnabled = YES;
    
}

#pragma mark - UISearchControllerDelegate

- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
    
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
    
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (tableView == self.tableView) ? self.people.count : self.resultsTableViewController.filteredCellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"peopleCellId" forIndexPath:indexPath];
    
//    NSString *userId = self.people[indexPath.row];
    [self configureCell:cell forCellData:self.cellDataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *theUserId = (tableView == self.tableView) ?
    self.people[indexPath.row] : [(CellData *)self.resultsTableViewController.filteredCellDataArray[indexPath.row] userId];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PeopleDetailTableViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"peopleTableId"];
    detailVC.userId = theUserId;
    [self.navigationController pushViewController:detailVC animated:YES];
    tableView.userInteractionEnabled = NO;
    
}

#pragma mark - UISearchResultsUpdating


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text
    
    
    
}


#pragma mark - UIStateRestoration

// we restore several items for state restoration:
//  1) Search controller's active state,
//  2) search text,
//  3) first responder

NSString *const ViewControllerTitleKey1 = @"ViewControllerTitleKey";
NSString *const SearchControllerIsActiveKey1 = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey1 = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey1 = @"SearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the view state so it can be restored later
    
    // encode the title
    [coder encodeObject:self.title forKey:ViewControllerTitleKey1];
    
    UISearchController *searchController = self.searchController;
    
    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey1];
    
    // encode the first responser status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey1];
    }
    
    // encode the search bar text
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey1];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the title
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey1];
    
    // restore the active state:
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey1];
    
    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey1];
    
    // restore the text in the search field
    self.searchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey1];
}




#pragma mark ActivityView

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.activityView.frame = self.view.bounds;
}

- (void)setActivityViewVisible:(BOOL)visible {
    if (self.activityViewVisible == visible) {
        return;
    }
    
    _activityViewVisible = visible;
    
    if (_activityViewVisible) {
        ActivityView *activityView = [[ActivityView alloc] initWithColorAndFrame:self.navigationController.view.bounds
                                      ];
        activityView.label.text = @"Loading";
        activityView.label.font = [UIFont boldSystemFontOfSize:20.f];
        [activityView.activityIndicator startAnimating];
        activityView.alpha = 1.0f;
        
        _activityView = activityView;
        [self.navigationController.view addSubview:_activityView];
    } else {
        [_activityView removeFromSuperview];
        _activityView = nil;
    }
}



- (IBAction)showMoreOption:(id)sender {
    // Hide already showing popover
    [self.menuPopover dismissMenuPopover];
    self.tableView.scrollEnabled = NO;
    [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
    self.menuPopover = [[PeoplePopover alloc] initWithFrame:MENU_POPOVER_FRAME menuItems:self.menuItems menuIsSelected:[[NSMutableArray alloc] initWithArray:@[@"N"]]];
    
    self.menuPopover.menuPopoverDelegate = self;
    [self.menuPopover showInView:self.view];
    self.menuPopover.tableView = self.tableView;
    self.menuPopover.alpha = 1.0f;
}

#pragma mark -
#pragma mark MLKMenuPopoverDelegate

- (void)menuPopover:(PeoplePopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex
{
    [self.menuPopover dismissMenuPopover];

    
    switch (selectedIndex) {
        case 0: {
            [self spawn];
            break;
        }
        default:
            break;
    }
}

-(void) spawn
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self findAllMatchedPeople];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
        
        
    });
}

@end
