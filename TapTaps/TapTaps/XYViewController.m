//
//  XYViewController.m
//  TapTaps
//
//  Created by Xia Yong on 13-12-10.
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
    
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
    // 触摸屏幕的轻击数
    singleTapRecognizer.numberOfTapsRequired = 1;
    // 同时触摸屏幕的手指数
    singleTapRecognizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:singleTapRecognizer];
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    // 告诉singleTapRecognizer，它应该在doubleTapRecognizer断定当前用户输入不是doubleTapRecognizer想要的手势时出发自己操作。
    // 视图中的单次轻击将立即让singleTapRecognizer认为这是它寻找的手势。于此同时doubleTapRecognizer将认为这看起来适合它，但它需要等待另一次的轻击，因为singleTapRecognizer设置为等待doubleTapRecognizer失败，所以singleTapRecognizer不会立即调用自己的操作方法，而是等待doubleTapRecognizer的结果。
    // 第一次轻击之后如果，立即发生了第二次轻击，doubleTapRecognizer会完全认为这是我需要的手势，并触发自己的操作。在这是，singleTapRecognizer将意识到所发生的事情，并放弃该手势。另一方面，如果经过了特定时间(系统规定的两次轻击之间最大的时间长度)，doubleTapRecognizer将放弃，singleTapRecognizer看到doubleTapRecognizer失败，最终将触发自己的操作。
    [singleTapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
    [self.view addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *tripleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3)];
    tripleTapRecognizer.numberOfTapsRequired = 3;
    tripleTapRecognizer.numberOfTouchesRequired = 1;
    // 每一个配置的手势都将依赖下一个手势的失败
    [doubleTapRecognizer requireGestureRecognizerToFail:tripleTapRecognizer];
    [self.view addGestureRecognizer:tripleTapRecognizer];
    
    UITapGestureRecognizer *quadrupleTapRecognier = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4)];
    quadrupleTapRecognier.numberOfTapsRequired = 4;
    quadrupleTapRecognier.numberOfTouchesRequired = 1;
    [tripleTapRecognizer requireGestureRecognizerToFail:quadrupleTapRecognier];
    [self.view addGestureRecognizer:quadrupleTapRecognier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tap1 {
    self.singleLabel.text = @"Single Tap Detected";
    [self performSelector:@selector(eraseMe:) withObject:self.singleLabel afterDelay:1.6f];
}

- (void)tap2 {
    self.doubleLabel.text = @"Double Tap Detected";
    [self performSelector:@selector(eraseMe:) withObject:self.doubleLabel afterDelay:1.6f];
}

- (void)tap3 {
    self.tripleLabel.text = @"Triple Tap Detected";
    [self performSelector:@selector(eraseMe:) withObject:self.tripleLabel afterDelay:1.6f];
}

- (void)tap4 {
    self.quadrupleLabel.text = @"Quadruple Tap Detected";
    [self performSelector:@selector(eraseMe:) withObject:self.quadrupleLabel afterDelay:1.6f];
}

- (void)eraseMe:(UILabel *)label {
    label.text = @"";
}

@end
