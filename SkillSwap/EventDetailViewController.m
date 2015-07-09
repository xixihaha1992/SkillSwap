//
//  EventDetailViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/6/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlString = [self.object objectForKey:@"eventUrl"];
    [self.eventWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    self.eventWebView.scalesPageToFit = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
