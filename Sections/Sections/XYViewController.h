//
//  XYViewController.h
//  Sections
//
//  Created by Xia Yong on 13-7-12.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSDictionary *names;
@property (strong, nonatomic) NSArray *keys;

@end
