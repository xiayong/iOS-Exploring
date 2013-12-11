//
//  XYViewController.m
//  PinchMe
//
//  Created by Xia Yong on 13-12-11.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"

@interface XYViewController ()

- (void)doPinch:(UIPinchGestureRecognizer *)pinchRecognizer;

@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 配置一个捏合手势识别器，此识别器在双指捏合期间反复调用自己的操作方法。
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(doPinch:)];
    [self.view addGestureRecognizer:pinchRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doPinch:(UIPinchGestureRecognizer *)pinchRecognizer {
    // 捏合手势识别器会经历多个状态。UIGestureRecognizerStateBegan是识别器在检测到双指捏合之后首次调用操作方法时所处的状态。这是，双指捏合手势识别器的scale属性为1.0，对于手势的其他状态该数值将上升或下降。
    if (pinchRecognizer.state == UIGestureRecognizerStateBegan)
        self.initialFontSize = self.label.font.pointSize;
    else
        self.label.font = [self.label.font fontWithSize:self.initialFontSize * pinchRecognizer.scale];
}

@end
