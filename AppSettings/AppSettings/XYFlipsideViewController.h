//
//  XYFlipsideViewController.h
//  AppSettings
//
//  Created by Xia Yong on 13-8-7.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYFlipsideViewController;

@protocol XYFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(XYFlipsideViewController *)controller;
@end

@interface XYFlipsideViewController : UIViewController

@property (weak, nonatomic) id <XYFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
