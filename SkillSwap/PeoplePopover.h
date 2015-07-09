//
//  PeoplePopover.h
//  SkillSwap
//
//  Created by Chen Zhu on 5/24/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PeoplePopover;

@protocol PeoplePopoverDelegate

- (void)menuPopover:(PeoplePopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex;

@end

@interface PeoplePopover : UIView <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign) id<PeoplePopoverDelegate> menuPopoverDelegate;
@property(nonatomic,retain) NSMutableArray *menuIsSelected;
- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems menuIsSelected:(NSMutableArray *)menuIsSelected;
- (void)showInView:(UIView *)view;
- (void)dismissMenuPopover;
- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
@property(weak, nonatomic) UITableView *tableView;

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net
