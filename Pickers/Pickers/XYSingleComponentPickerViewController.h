//
//  XYSingleComponentPickerViewController.h
//  Pickers
//
//  Created by Xia Yong on 13-5-6.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSingleComponentPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) IBOutlet UIPickerView *singlePicker;
- (IBAction)buttonPressed:(UIButton *)sender;

@end
