//
//  PAWActivityView.h
//  Anywall
//
//  Copyright (c) 2014 Parse Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIView
- (instancetype)initWithColorAndFrame:(CGRect)frame;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end
