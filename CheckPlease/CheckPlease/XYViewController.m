//
//  XYViewController.m
//  CheckPlease
//
//  Created by Xia Yong on 13-12-11.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"
#import "XYCheckMarkRecognizer.h"

@interface XYViewController ()

- (void)eraseLabel;

- (void)doCheck:(XYCheckMarkRecognizer *)checkMarkRecognizer;

@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    XYCheckMarkRecognizer *checkMarkRecognizer = [[XYCheckMarkRecognizer alloc] initWithTarget:self action:@selector(doCheck:)];
    [self.view addGestureRecognizer:checkMarkRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)eraseLabel {
    self.label.text = @"";
}

- (void)doCheck:(XYCheckMarkRecognizer *)checkMarkRecognizer {
    self.label.text = @"CheckMark";
    [self performSelector:@selector(eraseLabel) withObject:nil afterDelay:1.6f];
}

@end
