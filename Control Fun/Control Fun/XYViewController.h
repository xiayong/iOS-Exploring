//
//  XYViewController.h
//  Control Fun
//
//  Created by Xia Yong on 13-4-30.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYViewController : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *numberField;
@property (strong, nonatomic) IBOutlet UILabel *sliderLabel;
@property (strong, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (strong, nonatomic) IBOutlet UIButton *doSomethingButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTab:(UIControl *)sender;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)switchValueChanged:(UISwitch *)sender;
- (IBAction)buttonPressed:(UIButton *)sender;
- (IBAction)toggleControls:(UISegmentedControl *)sender;

@end
