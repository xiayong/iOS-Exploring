//
//  XYViewController.h
//  State Lab
//
//  Created by Xia Yong on 13-10-11.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) UIImage *smiley;
@property (strong, nonatomic) UIImageView *smileyView;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@end
