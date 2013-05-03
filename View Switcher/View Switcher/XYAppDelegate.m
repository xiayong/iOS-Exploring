//
//  XYAppDelegate.m
//  View Switcher
//
//  Created by Xia Yong on 13-5-4.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYAppDelegate.h"
#import "XYSwitchViewController.h"

@implementation XYAppDelegate

@synthesize switchViewController = _switchViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.switchViewController = [[XYSwitchViewController alloc] initWithNibName:@"SwitchView" bundle:nil];
    UIView *switchView = self.switchViewController.view;
    //CGRect switchViewFrame = switchView.frame;
    //NSLog(@"Window高度%f", self.window.frame.size.height);
    //NSLog(@"视图原高度%f", switchViewFrame.size.height);
    //switchViewFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height;
    
    //switchViewFrame.size.height -= [UIApplication sharedApplication].statusBarFrame.size.height + self.switchViewController.switchBar.frame.size.height + 4;
    //NSLog(@"状态栏高度%f", [UIApplication sharedApplication].statusBarFrame.size.height);
    //NSLog(@"控制栏高度%f", self.switchViewController.switchBar.frame.size.height);
    //NSLog(@"调整后视图高度%f", switchViewFrame.size.height);
    //switchView.frame = switchViewFrame;
    [self.window addSubview:switchView];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
