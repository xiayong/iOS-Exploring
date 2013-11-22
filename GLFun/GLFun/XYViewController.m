//
//  XYViewController.m
//  GLFun
//
//  Created by Xia Yong on 13-11-14.
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

- (IBAction)changeColor:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    XYGLFunView *glView = (XYGLFunView *)self.view;
    glView.useRandomColor = index == kRandomColorTab;
    switch (index) {
        case kRedColorTab:
            glView.currentColor = [UIColor redColor];
            break;
        case kBlueColorTab:
            glView.currentColor = [UIColor blueColor];
            break;
        case kYellowColorTab:
            glView.currentColor = [UIColor yellowColor];
            break;
        default:
            break;
    }
}
- (IBAction)changeShape:(UISegmentedControl *)sender {
    ((XYGLFunView *)self.view).shapeType = sender.selectedSegmentIndex;
    // 当选中image时，隐藏颜色分段控制控件
    _colorControl.hidden = sender.selectedSegmentIndex == kImageShape;
}

@end
