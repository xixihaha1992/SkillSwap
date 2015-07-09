//
//  MLKMenuPopover.h
//  MLKMenuPopover
//
//  Created by NagaMalleswar on 20/11/14.
//  Copyright (c) 2014 NagaMalleswar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventPopover;

@protocol EventPopoverDelegate

- (void)menuPopover:(EventPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex;

@end

@interface EventPopover : UIView <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign) id<EventPopoverDelegate> menuPopoverDelegate;
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
