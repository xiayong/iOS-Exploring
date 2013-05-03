//
//  XYSwitchViewController.h
//  View Switcher
//
//  Created by Xia Yong on 13-5-4.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYBlueViewController;
@class XYYellowViewController;

@interface XYSwitchViewController : UIViewController

@property (strong, nonatomic) XYBlueViewController *blueViewController;
@property (strong, nonatomic) XYYellowViewController *yellowViewController;
@property (strong, nonatomic) IBOutlet UIToolbar *switchBar;
- (IBAction)switchViews:(id)sender;

@end
