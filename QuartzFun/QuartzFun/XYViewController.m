//
//  XYViewController.m
//  QuartzFun
//
//  Created by Xia Yong on 13-11-5.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"
#import "XYConstants.h"
#import "XYQuartzFunView.h"

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
    XYQuartzFunView *quartzView = (XYQuartzFunView *)self.view;
    
    quartzView.useRandomColor = index == kRandomColorTab;
    
    switch (index) {
        case kRedColorTab:
            quartzView.currentColor = [UIColor redColor];
            break;
        case kBlueColorTab:
            quartzView.currentColor = [UIColor blueColor];
            break;
        case kYellowColorTab:
            quartzView.currentColor = [UIColor yellowColor];
            break;
        case kGreenColorTab:
            quartzView.currentColor = [UIColor greenColor];
            break;
        default:
            break;
    }
    
}

-(IBAction)changeShape:(UISegmentedControl *)sender {
    ((XYQuartzFunView *)self.view).shapeType = sender.selectedSegmentIndex;
    // 当选中image时，隐藏颜色分段控制控件
    _colorControl.hidden = sender.selectedSegmentIndex == kImageShape;
}

@end
