//
//  XYSwitchViewController.m
//  View Switcher
//
//  Created by Xia Yong on 13-5-4.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYSwitchViewController.h"
#import "XYBlueViewController.h"
#import "XYYellowViewController.h"


@implementation XYSwitchViewController

- (void)viewDidLoad {
    self.blueViewController = [[XYBlueViewController alloc] initWithNibName:@"BlueView" bundle:nil];
    [self.view insertSubview:self.blueViewController.view atIndex:0];
    CGRect rect = self.view.frame;
    rect.size.height = 480;
    self.view.frame = rect;
    [super viewDidLoad];
}

- (IBAction)switchViews:(id)sender {
    if(self.yellowViewController.view.superview == nil) {
        if(self.yellowViewController == nil)
            self.yellowViewController = [[XYYellowViewController alloc] initWithNibName:@"YellowView" bundle:nil];
        [self.blueViewController.view removeFromSuperview];
        [self.view insertSubview:self.yellowViewController.view atIndex:0];
    } else {
        if(self.blueViewController == nil)
            self.blueViewController = [[XYBlueViewController alloc] initWithNibName:@"BlueView" bundle:nil];
        [self.yellowViewController.view removeFromSuperview];
        [self.view insertSubview:self.blueViewController.view atIndex:0];
    }
}

// 当收到操作系统内存警告时发送此消息
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.blueViewController.view.superview == nil)
        self.blueViewController = nil;
    else
        self.yellowViewController = nil;
}

@end
