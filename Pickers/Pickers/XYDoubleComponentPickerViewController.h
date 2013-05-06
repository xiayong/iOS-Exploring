//
//  XYDoubleComponentPickerViewController.h
//  Pickers
//
//  Created by Xia Yong on 13-5-6.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFillingComponent   0
#define kBreadComponent     1

@interface XYDoubleComponentPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *doublePicker;
@property (strong, nonatomic) NSArray *fillingTypes;
@property (strong, nonatomic) NSArray *breadTypes;
- (IBAction)buttonPressed:(UIButton *)sender;

@end
