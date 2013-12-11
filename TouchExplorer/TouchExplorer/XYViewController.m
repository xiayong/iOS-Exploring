//
//  XYViewController.m
//  TouchExplorer
//
//  Created by Xia Yong on 13-11-23.
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

- (void)updateLabelsFromTouches:(NSSet *)touches {
    self.tapsLabel.text = [NSString stringWithFormat:@"%lu taps detected", (long)[[touches anyObject] tapCount]];
    
    self.touchesLabel.text = [NSString stringWithFormat:@"%lu touches detected", (long)touches.count];
}

#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"Touches Began";
    [self updateLabelsFromTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"Drag Detected";
    [self updateLabelsFromTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"Touches Ended";
    [self updateLabelsFromTouches:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"Touches Cancelled";
    [self updateLabelsFromTouches:touches];
}

@end
