//
//  XYViewController.m
//  Persistance
//
//  Created by Xia Yong on 13-8-9.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"
#define kFilename       @"data.plist"

@interface XYViewController ()

- (NSString *)dataFilePath;
- (void)applicationWillResignActive:(NSNotification *)notification;

@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        for (int i = 0; i < [array count]; ++ i)
            [self setValue:[array objectAtIndex:i] forKeyPath:[NSString stringWithFormat:@"field%d.text", i + 1]];
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    // 注册UIApplicationWillResignActiveNotification通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)dataFilePath {
    // 搜索应用程序Documents文件夹
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:kFilename];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 1; i <= 4; i ++)
        [array addObject:[self valueForKeyPath:[NSString stringWithFormat:@"field%d.text", i]]];
    // 将应用程序数据写入文件
    [array writeToFile:[self dataFilePath] atomically:YES];
}

@end
