//
//  XYCustomPickerViewController.h
//  Pickers
//
//  Created by Xia Yong on 13-5-6.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCustomPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property(strong, nonatomic) IBOutlet UIPickerView *picker;
@property(strong, nonatomic) IBOutlet UILabel *winLabel;
@property(strong, nonatomic) NSArray *column1;
@property(strong, nonatomic) NSArray *column2;
@property(strong, nonatomic) NSArray *column3;
@property(strong, nonatomic) NSArray *column4;
@property(strong, nonatomic) NSArray *column5;
- (IBAction)spin:(UIButton *)sender;
@end
