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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    self.blueViewController = [[XYBlueViewController alloc] initWithNibName:@"BlueView" bundle:nil];
    [self.view insertSubview:self.blueViewController.view atIndex:0];
    [super viewDidLoad];
}

- (IBAction)switchViews:(id)sender {
    // 声明一个动画块
    [UIView beginAnimations:@"View Flip" context:nil];
    // 设置动画周期
    [UIView setAnimationDuration:1.25];
    // 设置动画曲线
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if(self.yellowViewController.view.superview == nil) {
        if(self.yellowViewController == nil)
            self.yellowViewController = [[XYYellowViewController alloc] initWithNibName:@"YellowView" bundle:nil];
        // 指定转换动画类型
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [self.blueViewController.view removeFromSuperview];
        [self.view insertSubview:self.yellowViewController.view atIndex:0];
    } else {
        if(self.blueViewController == nil)
            self.blueViewController = [[XYBlueViewController alloc] initWithNibName:@"BlueView" bundle:nil];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self.yellowViewController.view removeFromSuperview];
        [self.view insertSubview:self.blueViewController.view atIndex:0];
    }
    [UIView commitAnimations];
}

// 当收到操作系统内存警告时清理内存
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.blueViewController.view.superview == nil)
        self.blueViewController = nil;
    else
        self.yellowViewController = nil;
}

@end
