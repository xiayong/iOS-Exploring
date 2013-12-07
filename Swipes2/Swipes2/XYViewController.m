//
//  XYViewController.m
//  Swipes2
//
//  Created by Xia Yong on 13-12-8.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"

@interface XYViewController ()
- (void)eraseText;
- (void)reportVerticalSwipe:(UIGestureRecognizer *)recognizer;
- (void)reportHorizontalSwipe:(UIGestureRecognizer *)recognier;
@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    for (NSUInteger touchCount = 1; touchCount <= 5; touchCount++) {
        UISwipeGestureRecognizer *vertical = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportVerticalSwipe:)];
        vertical.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
        vertical.numberOfTouchesRequired = touchCount;
        [self.view addGestureRecognizer:vertical];
        
        UISwipeGestureRecognizer *horizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe:)];
        horizontal.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
        horizontal.numberOfTouchesRequired = touchCount;
        [self.view addGestureRecognizer:horizontal];
    }
}

- (void)eraseText {
    self.label.text = @"";
}

- (void)reportVerticalSwipe:(UIGestureRecognizer *)recognizer {
    self.label.text = [NSString stringWithFormat:@"%@Vertical swipe detected", [self descriptionForTouchCount:[recognizer numberOfTouches]]];
    [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
}

- (void)reportHorizontalSwipe:(UIGestureRecognizer *)recognier {
    self.label.text = [NSString stringWithFormat:@"%@Horizontal swipe detected", [self descriptionForTouchCount:[recognier numberOfTouches]]];
    [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
}

- (NSString *)descriptionForTouchCount:(NSUInteger)touchCount {
    switch (touchCount) {
        case 2:
            return @"Double ";
            break;
        case 3:
            return @"Triple ";
            break;
        case 4:
            return @"Quadruple ";
            break;
        case 5:
            return @"Quintuple ";
            break;
        default:
            return @"";
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
