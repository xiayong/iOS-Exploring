//
//  XYViewController.m
//  Swap
//
//  Created by Xia Yong on 13-5-3.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"

#define degreesToRadians(x) (M_PI * (x) / 180.0)

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

- (IBAction)buttonTapped:(UIButton *)sender {
    //NSString *message = nil;
    NSArray *buttonCollection = nil;
    if([self.foos containsObject:sender])
        //message = @"Foo button pressed !";
        buttonCollection = self.foos;
    else
        //message = @"Bar button pressed !";
        buttonCollection = self.bars;
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //[alert show];
    // 影藏Button
    for (UIButton *button in buttonCollection) {
        button.hidden = YES;
    }
}

// 当屏幕开始旋转，在旋转完成之前发送此消息
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"%d", toInterfaceOrientation);
    if(toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        // 朝上
        self.view = self.portrait;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
        self.view.bounds = CGRectMake(0.0, 0.0, 320.0, 460.0);
    } else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        self.view = self.landscape;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480, 300);
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view = self.landscape;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480, 300);
    }
}
@end
