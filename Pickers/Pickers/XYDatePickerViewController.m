//
//  XYDatePickerViewController.m
//  Pickers
//
//  Created by Xia Yong on 13-5-6.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYDatePickerViewController.h"

@interface XYDatePickerViewController ()

@end

@implementation XYDatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSDate *now = [NSDate date];
    //[self.datePicker setDate:now animated:NO];
    self.datePicker.date = now;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.datePicker = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSDate *selectedDate = [self.datePicker date];
    NSString *message = [NSString stringWithFormat:@"The date and time you selected is: %@", selectedDate];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Date and Time selected" message:message delegate:self cancelButtonTitle:@"Yes, I did." otherButtonTitles:nil];
    [alert show];
}
@end
