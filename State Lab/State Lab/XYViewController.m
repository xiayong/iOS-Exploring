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
    [self.view addSubview:self.label];
    
    //[self rotatleLabelDown];
}

- (void)rotatleLabelUp {
    // 设置一个动画，设置此动画持续时间为0.5秒
    [UIView animateWithDuration:0.5 animations:^{
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
    [UIView animateWithDuration:0.5 animations:^{
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
