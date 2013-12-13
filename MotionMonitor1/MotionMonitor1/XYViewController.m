//
//  XYViewController.m
//  MotionMonitor1
//
//  Created by Xia Yong on 13-12-13.
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
    
    self.motionManager = [[CMMotionManager alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    if (self.motionManager.accelerometerAvailable) {
        self.motionManager.accelerometerUpdateInterval = 1.0 / 1.0;
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            NSString *labelText;
            if (error) {
                [self.motionManager stopAccelerometerUpdates];
                labelText = [NSString stringWithFormat:@"Accelerometer encountered error: %@", error];
            } else {
                labelText = [NSString stringWithFormat:@"Accelerometer\n----------\nx: %+.2f\ny: %+.2f\nz: %+.2f", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z];
            }
            [self.accelerometerLabel performSelectorOnMainThread:@selector(setText:) withObject:labelText waitUntilDone:NO];
        }];
    } else
        self.accelerometerLabel.text = @"This device has no accelerometer.";
    
    if (self.motionManager.gyroAvailable) {
        self.motionManager.gyroUpdateInterval = 1.0 / 1.0;
        [self.motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData *gyroData, NSError *error) {
            NSString *labelText;
            if (error) {
                [self.motionManager stopGyroUpdates];
                labelText = [NSString stringWithFormat:@"Gyroscope encountered error: %@", error];
            } else
                labelText = [NSString stringWithFormat:@"Gyroscope\n----------\nx: %+.2f\ny: %+.2f\nz: %+.2f", gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z];
            [self.gyroscopeLabel performSelectorOnMainThread:@selector(setText:) withObject:labelText waitUntilDone:NO];
        }];
    } else
        self.gyroscopeLabel.text = @"This device has no gyroscope";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
