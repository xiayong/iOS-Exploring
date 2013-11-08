//
//  XYViewController.h
//  QuartzFun
//
//  Created by Xia Yong on 13-11-5.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *colorControl;
- (IBAction)changeColor:(UISegmentedControl *)sender;
- (IBAction)changeShape:(UISegmentedControl *)sender;
@end
