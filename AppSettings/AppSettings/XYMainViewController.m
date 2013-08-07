//
//  XYMainViewController.m
//  AppSettings
//
//  Created by Xia Yong on 13-8-7.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYMainViewController.h"

@interface XYMainViewController ()

- (void)refreshFields;
// 当接受到UIApplicationWillEnterForegroundNotification通知时的回调方法
- (void)applicationWillEnterForeground:(NSNotification *)notification;

@end

@implementation XYMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 向通知中心注册UIApplicationWillEnterForegroundNotification通知
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:app];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View
// 当用户在flipside视图中完成对首选项的修改之后，控制器将获取该通知
- (void)flipsideViewControllerDidFinish:(XYFlipsideViewController *)controller
{
    [self refreshFields];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshFields];
}

// 强制刷新用户设置
- (void)applicationWillEnterForeground:(NSNotification *)notification {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [self refreshFields];
}

// 加载用户默认设置
- (void)refreshFields {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.usernameLabel.text = [defaults objectForKey:kUsernameKey];
    self.passwordLabel.text = [defaults objectForKey:kPasswordKey];
    self.protocolLabel.text = [defaults objectForKey:kProtocolKey];
    self.warpDriveLabel.text = [defaults boolForKey:kWarpDriveKey] ? @"Engaged" : @"Disable";
    self.warpFactorLabel.text = [[defaults objectForKey:kWarpFactorKey] stringValue];
    self.favoriteTeaLabel.text = [defaults objectForKey:kFavoriteTeaKey];
    self.favoriteCandyLabel.text = [defaults objectForKey:kFavoriteCandyKey];
    self.favoriteGameLabel.text = [defaults objectForKey:kFavoriteGameKey];
    self.favoriteExcuseLabel.text = [defaults objectForKey:kFavoriteExcuseKey];
    self.favoriteSinLabel.text = [defaults objectForKey:kFavoriteSinKey];
}

@end
