//
//  XYViewController.m
//  Persistance
//
//  Created by Xia Yong on 13-8-9.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"
#import "XYFourLines.h"

// #define kFilename       @"data.plist"
#define kFilename       @"archive"
#define kDataKey        @"Data"

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
        // 从文件中读取数据
        //NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        //for (int i = 0; i < [array count]; ++ i)
        //    [self setValue:[array objectAtIndex:i] forKeyPath:[NSString stringWithFormat:@"field%d.text", i + 1]];
        
        // 从归档文件中解密出数据
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        XYFourLines *fourLines = [unarchiver decodeObjectForKey:kDataKey];
        [unarchiver finishDecoding];
        for (int i = 1; i <= 4; i ++) {
            NSString *valye = [fourLines valueForKey:[NSString stringWithFormat:@"field%d", i]];
            [self setValue:valye forKeyPath:[NSString stringWithFormat:@"field%d.text", i]];
        }
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
    //NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:4];
    //for (int i = 1; i <= 4; i ++)
    //    [array addObject:[self valueForKeyPath:[NSString stringWithFormat:@"field%d.text", i]]];
    
    // 将应用程序数据写入文件
    //[array writeToFile:[self dataFilePath] atomically:YES];
    
    
    XYFourLines *fourLines = [[XYFourLines alloc] init];
    for (int i = 1; i <= 4; i ++) {
        NSString *value = [self valueForKeyPath:[NSString stringWithFormat:@"field%d.text", i]];
        [fourLines setValue:value forKey:[NSString stringWithFormat:@"field%d", i]];
    }
    // 归档数据
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:fourLines forKey:kDataKey];
    [archiver finishEncoding];
    // 将归档后的数据写入文件
    [data writeToFile:[self dataFilePath] atomically:YES];
}

@end
