//
//  XYYellowViewController.m
//  View Switcher
//
//  Created by Xia Yong on 13-5-4.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYYellowViewController.h"

@interface XYYellowViewController ()

@end

@implementation XYYellowViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yellow View Button Pressed !" message:@"You pressed the button on the yellow view." delegate:nil cancelButtonTitle:@"Yes, I did." otherButtonTitles:nil];
    [alert show];
}
@end
