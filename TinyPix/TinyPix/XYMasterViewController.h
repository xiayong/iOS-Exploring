//
//  XYMasterViewController.h
//  TinyPix
//
//  Created by Xia Yong on 13-8-21.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYMasterViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorControl;

- (IBAction)chooseColor:(UISegmentedControl *)sender;

@end
