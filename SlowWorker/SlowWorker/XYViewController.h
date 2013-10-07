//
//  XYViewController.h
//  SlowWorker
//
//  Created by Xia Yong on 13-9-1.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UITextView *resultsTextView;
- (IBAction)doWork:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
