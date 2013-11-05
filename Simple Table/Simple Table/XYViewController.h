//
//  XYViewController.h
//  Simple Table
//
//  Created by Xia Yong on 13-7-7.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *listData;

- (IBAction)doWork:(UIButton *)sender;
@end
