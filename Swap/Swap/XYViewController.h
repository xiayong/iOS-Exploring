//
//  XYViewController.h
//  Swap
//
//  Created by Xia Yong on 13-5-3.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *portrait;
- (IBAction)changeColor:(UISegmentedControl *)sender;
- (IBAction)changeColor:(UISegmentedControl *)sender;
@property (strong, nonatomic) IBOutlet UIView *landscape;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *foos;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *bars;
- (IBAction)buttonTapped:(UIButton *)sender;
@end
