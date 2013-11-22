//
//  XYViewController.h
//  GLFun
//
//  Created by Xia Yong on 13-11-14.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYGLFunView.h"

@interface XYViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *colorControl;

- (IBAction)changeColor:(UISegmentedControl *)sender;
- (IBAction)changeShape:(UISegmentedControl *)sender;
@end
