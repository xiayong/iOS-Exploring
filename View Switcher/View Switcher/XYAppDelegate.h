//
//  XYAppDelegate.h
//  View Switcher
//
//  Created by Xia Yong on 13-5-4.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYSwitchViewController;

@interface XYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) XYSwitchViewController *switchViewController;

@end
