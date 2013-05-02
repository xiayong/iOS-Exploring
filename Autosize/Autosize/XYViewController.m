//
//  XYViewController.m
//  Autosize
//
//  Created by Xia Yong on 13-5-3.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"

@interface XYViewController ()

@end

@implementation XYViewController

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

// 是否支持自动转屏
- (BOOL) shouldAutorotate {
    return YES;
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    CGSize buttonSize = CGSizeMake(125, 125);
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.buttonUL.frame = CGRectMake(20, 20, buttonSize.width, buttonSize.height);
        self.buttonUR.frame = CGRectMake(175, 20, buttonSize.width, buttonSize.height);
        self.buttonL.frame = CGRectMake(20, 168, buttonSize.width, buttonSize.height);
        self.buttonR.frame = CGRectMake(175, 168, buttonSize.width, buttonSize.height);
        self.buttonLL.frame = CGRectMake(20, 315, buttonSize.width, buttonSize.height);
        self.buttonLR.frame = CGRectMake(175, 315, buttonSize.width, buttonSize.height);
    } else {
        self.buttonUL.frame = CGRectMake(20, 20, buttonSize.width, buttonSize.height);
        self.buttonUR.frame = CGRectMake(20, 155, buttonSize.width, buttonSize.height);
        self.buttonL.frame = CGRectMake(177, 20, buttonSize.width, buttonSize.height);
        self.buttonR.frame = CGRectMake(177, 155, buttonSize.width, buttonSize.height);
        self.buttonLL.frame = CGRectMake(328, 20, buttonSize.width, buttonSize.height);
        self.buttonLR.frame = CGRectMake(328, 155, buttonSize.width, buttonSize.height);
    }
}

@end
