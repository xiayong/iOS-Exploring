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
    self.startButton.enabled = NO;
    self.startButton.alpha = 0.5;
    [self.spinner startAnimating];
    
    NSDate *statTime = [NSDate date];
    // 将一个程序块传递给dispatch_async()函数
    // dispatch_get_global_queue()函数用于抓取一个已经存在并始终可用的全局队列，第一个参数用于指定优先级，第二个参数目前还没有使用并且应该始终为0。
    // dispatch_get_global_queue()函数的取值为别为DISPATCH_QUEUE_PRIORITY_LOW,DISPATCH_QUEUE_PRIORITY_HIGH,DISPATCH_QUEUE_PRIORITY_DEFAULT,DISPATCH_QUEUE_PRIORITY_BACKGROUND.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *feathcedData = [self fatchSomethingFromServer];
        NSString *processedData = [self processData:feathcedData];
        // NSString *firstResult = [self calculateFirstResult:processedData];
        // NSString *secondResult = [self calculateSecondResult:processedData];
        
        // __block修饰的变量可以直接被程序块里面的代码访问，且程序块里面的代码不会保存此变量
        __block NSString *firstResult;
        __block NSString *secondResult;
        // 创建一个分担组
        dispatch_group_t group = dispatch_group_create();
        // 将在一个分担组的上下文中通过dispatch_group_async()函数异步分派的所有程序块设置为松散的，以尽可能快的执行，如果可能将它们分发给多个线程来执行
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            firstResult = [self calculateFirstResult:processedData];
        });
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            secondResult = [self calculateSecondResult:processedData];
        });
        // 使用dispatch_group_notify()函数指定一个额外的程序块，该程序块将在分担组中所有的程序块执行完完成时执行
        dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // UIKit是线程安全的，所以任何后台线程都不能联系GUI对象
            // 再一次调用dispatch_async()函数，将工作传回主线程
            // dispatch_get_main_queue()函数总是提供存在于主线程上的特殊队列，并准备执行需要执行的主线程程序块
            dispatch_async(dispatch_get_main_queue(), ^{
                self.startButton.enabled = YES;
                self.startButton.alpha = 1.0;
                [self.spinner stopAnimating];
                // 这里比较奇怪的是，上面创建的firstResult和secondResult既然没有被retian，那不会过早的被release么？
                _resultsTextView.text = [NSString stringWithFormat:@"First :[%@]\nSecond: [%@]", firstResult, secondResult];
            });
            
            NSDate *endTime = [NSDate date];
            // 程序块要访问外部变量statTime，那么当程序块在被创建的时候会复制外部变量(普通的C类型变量)或者保存外部变量(向指针类型发送一条retian信息)
            NSLog(@"Completed in %f seconds", [endTime timeIntervalSinceDate:statTime]);
        });
    });
}

@end
