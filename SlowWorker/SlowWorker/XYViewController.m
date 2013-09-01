//
//  XYViewController.m
//  SlowWorker
//
//  Created by Xia Yong on 13-9-1.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.startButton = nil;
    self.resultsTextView = nil;
}

- (NSString *)fatchSomethingFromServer {
    [NSThread sleepForTimeInterval:1];
    return @"Hi there";
}

- (NSString *)processData:(NSString *)data {
    [NSThread sleepForTimeInterval:2];
    return [data uppercaseString];
}

- (NSString *)calculateFirstResult:(NSString *)data {
    [NSThread sleepForTimeInterval:3];
    return [NSString stringWithFormat:@"Number of chars: %d", data.length];
}

- (NSString *)calculateSecondResult:(NSString *)data {
    [NSThread sleepForTimeInterval:4];
    return [data stringByReplacingOccurrencesOfString:@"E" withString:@"e"];
}

- (IBAction)doWork:(UIButton *)sender {
    NSDate *statTime = [NSDate date];
    NSString *feathcedData = [self fatchSomethingFromServer];
    NSString *processedData = [self processData:feathcedData];
    NSString *firstResult = [self calculateFirstResult:processedData];
    NSString *secondResult = [self calculateSecondResult:processedData];
    _resultsTextView.text = [NSString stringWithFormat:@"First :[%@]\nSecond: [%@]", firstResult, secondResult];
    NSDate *endTime = [NSDate date];
    NSLog(@"Completed in %f seconds", [endTime timeIntervalSinceDate:statTime]);
}

@end
