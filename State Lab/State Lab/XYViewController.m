//
//  XYViewController.m
//  State Lab
//
//  Created by Xia Yong on 13-10-11.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"

@interface XYViewController ()

- (void)rotatleLabelUp;
- (void)rotatleLabelDown;
@property (assign, nonatomic) BOOL animate;

@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 从不活动状态切换到后台状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
    // 从后台状态切换到不活动状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
    
    
    // 从活动状态切换到不活动状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
    // 从不活动状态切换到活动状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication]];
    
    
    static NSString *lableText = @"Bazinga!";
    UIFont *lableFont = [UIFont fontWithName:@"Helvetica" size:70];
    CGSize lableSize =[lableText sizeWithFont:lableFont];
    CGRect bounds = self.view.bounds;
    CGRect lableFrame = CGRectMake(CGRectGetMidX(bounds) - lableSize.width / 2, CGRectGetMidY(bounds) - lableSize.height / 2, lableSize.width, lableSize.height);
    
    self.label = [[UILabel alloc] initWithFrame:lableFrame];
    //self.label = [[UILabel alloc] init];
    // self.label.center = self.view.center;
    self.label.text = lableText;
    self.label.font = lableFont;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor clearColor];
    
    CGRect smileyFrame = CGRectMake(CGRectGetMidX(bounds) - 42, CGRectGetMidY(bounds)/2 - 42, 84, 84);
    self.smileyView = [[UIImageView alloc] initWithFrame:smileyFrame];
    self.smileyView.contentMode = UIViewContentModeCenter;
    NSString *smileyPath = [[NSBundle mainBundle] pathForResource:@"smiley" ofType:@"png"];
    self.smiley = [UIImage imageWithContentsOfFile:smileyPath];
    self.smileyView.image = self.smiley;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"One", @"Two", @"Three", @"Fore", nil]];
    self.segmentedControl.frame = CGRectMake(bounds.origin.x + 20, CGRectGetMaxY(bounds) - 50, bounds.size.width - 20 * 2, 30);
    [self.view addSubview:self.segmentedControl];
    
    
    [self.view addSubview:self.smileyView];
    
    [self.view addSubview:self.label];
    
    NSNumber *selectedIndex = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedIndex"];
    if (selectedIndex) {
        self.segmentedControl.selectedSegmentIndex = [selectedIndex integerValue];
    }
    
    //[self rotatleLabelDown];
}

- (void)rotatleLabelUp {
    // 设置一个动画，设置此动画持续时间为0.5秒
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        // 动画执行内容
        // 将label的旋转角度恢复
        self.label.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        if (self.animate)
            // 继续旋转
            [self rotatleLabelDown];
    }];
}

- (void)rotatleLabelDown {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        // 将label的角度旋转至M_PI的值
        self.label.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        [self rotatleLabelUp];
    }];
}

- (void)applicationWillResignActive {
    NSLog(@"VC: %@", NSStringFromSelector(_cmd));
    self.animate = NO;
}

- (void)applicationDidBecomeActive {
    NSLog(@"VC: %@", NSStringFromSelector(_cmd));
    self.animate = YES;
    [self rotatleLabelDown];
}

- (void)applicationDidEnterBackground {
    NSLog(@"VC: %@", NSStringFromSelector(_cmd));
    // 获取共享的UIApplication实例
    UIApplication *app = [UIApplication sharedApplication];
    // 使用__block修饰符进行存储，确保该方法返回的标识符在此方法中创建的所有的程序块中共享
    __block UIBackgroundTaskIdentifier taskId;
    // 通过调用 beginBackgroundTaskWithExpirationHandler: 我们告诉了系统，我们需要更多时间来完成某件事，我们承认在完成后告诉它。如果系统断定我们运行了太长时间并决定停止运行，可以调用我们作为参数提供的程序块。
    taskId = [app beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Background task ran out of time and was terminated.");
        // 告诉系统我们完成了之前请求额外的时间来完成工作
        [app endBackgroundTask:taskId];
    }];
    
    if (taskId == UIBackgroundTaskInvalid) {
        NSLog(@"Failed to start background task!");
        return;
    }
    
    // 将我们在后台需要做的工作放入一个后台队列中，在程序块的末尾同样要告诉系统我们完成了之前请求额外的时间来完成工作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Starting background task with %f seconds remaining", app.backgroundTimeRemaining);
        self.smiley = nil;
        self.smileyView.image = nil;
        [[NSUserDefaults standardUserDefaults] setInteger:self.segmentedControl.selectedSegmentIndex forKey:@"selectedIndex"];
        // 模拟一个耗时很长的操作
        [NSThread sleepForTimeInterval:25];
        NSLog(@"Finishing background task with %f seconds remaining", app.backgroundTimeRemaining);
        [app endBackgroundTask:taskId];
    });
}

- (void)applicationWillEnterForeground {
    NSLog(@"VC: %@", NSStringFromSelector(_cmd));
    self.smiley = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"smiley" ofType:@"png"]];
    self.smileyView.image = self.smiley;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
