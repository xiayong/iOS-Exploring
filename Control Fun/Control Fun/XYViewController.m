//
//  XYViewController.m
//  Control Fun
//
//  Created by Xia Yong on 13-4-30.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"

@interface XYViewController ()

@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //self.segmentedControl.selectedSegmentIndex = 0;
    UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
    UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    UIImage *buttonImagePressed = [UIImage imageNamed:@"blueButton.png"];
    UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    // 设置Button在Normal状态下的可拉伸图像
    [self.doSomethingButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
    // 设置Button在Highlighted状态下的可拉伸图像
    [self.doSomethingButton setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDoneEditing:(id)sender {
    // 控件放弃第一响应者
    [sender resignFirstResponder];
}

// 当背景被触控的时候让两个文本字段都放弃第一响应者
- (IBAction)backgroundTab:(UIControl *)sender {
    [self.nameField resignFirstResponder];
    [self.numberField resignFirstResponder];
}

// 当Slider Bar改变时修改Label显示的值
- (IBAction)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.sliderLabel.text = [NSString stringWithFormat:@"%d", (int)roundf(slider.value)];
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    UISwitch *whichSwitch = (UISwitch *)sender;
    BOOL setting = whichSwitch.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}

// 显示操作表
- (IBAction)buttonPressed:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure?" delegate:self cancelButtonTitle:@"No way!" destructiveButtonTitle:@"Yes, I'm sure!" otherButtonTitles: nil];
    [actionSheet showInView:self.view];
}

- (IBAction)toggleControls:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0) {
        self.leftSwitch.hidden = NO;
        self.rightSwitch.hidden = NO;
        self.doSomethingButton.hidden = YES;
    } else {
        self.leftSwitch.hidden = YES;
        self.rightSwitch.hidden = YES;
        self.doSomethingButton.hidden = NO;
    }
}

// 当用户Dismiss操作表(按下操作表的按钮之后)，将向委托对象(实现UIActionSheetDelegate协议的对象)发送此消息
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *message = nil;
    if(self.nameField.text.length > 0) {
        message = [NSString stringWithFormat:@"You can breathe easy, %@, everything went OK.", self.nameField.text];
    } else {
        message = [NSString stringWithFormat:@"You can breathe easy, everything went OK."];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something was done." message:message delegate:self cancelButtonTitle:@"Phwe!" otherButtonTitles:nil];
    [alert show];
}
@end
