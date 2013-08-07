//
//  XYFlipsideViewController.m
//  AppSettings
//
//  Created by Xia Yong on 13-8-7.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYFlipsideViewController.h"
#import "XYMainViewController.h"

@interface XYFlipsideViewController ()

- (void)refreshFields;
// 当接受到UIApplicationWillEnterForegroundNotification通知时的回调方法
- (void)applicationWillEnterForeground:(NSNotification *)notification;

@end

@implementation XYFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self refreshFields];
    // 向通知中心注册UIApplicationWillEnterForegroundNotification通知
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:app];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshFields {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.engineSwitch.on = [defaults boolForKey:kWarpDriveKey];
    self.warpFactorSlider.value = [defaults floatForKey:kWarpFactorKey];
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [self refreshFields];
}


#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:sender.on forKey:kWarpDriveKey];
    [defaults synchronize];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:sender.value forKey:kWarpFactorKey];
    [defaults synchronize];
}
@end
