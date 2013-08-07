//
//  XYFlipsideViewController.m
//  AppSettings
//
//  Created by Xia Yong on 13-8-7.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYFlipsideViewController.h"

@interface XYFlipsideViewController ()

@end

@implementation XYFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
