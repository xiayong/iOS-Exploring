//
//  XYViewController.m
//  WhereAmI
//
//  Created by Xia Yong on 13-12-12.
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
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"%d", locations.count);
    NSLog(@"%@", locations.description);
    
    
    CLLocation *location = [locations lastObject];
    if (!self.startingPoint)
        self.startingPoint = location;
    // 经度
    self.latutudeLabel.text = [NSString stringWithFormat:@"%g\u00B0", location.coordinate.latitude];
    // 维度
    self.longitudeLabel.text = [NSString stringWithFormat:@"%g\u00B0", location.coordinate.longitude];
    // 当前位置位于以location.coordinate为圆形的多大半径内，若此数值为负数则表示Core Location无法确定你的位置
    self.horizontalAccuracyLabel.text = [NSString stringWithFormat:@"%gm", location.horizontalAccuracy];
    // 海拔
    self.altitudeLabel.text = [NSString stringWithFormat:@"%gm", location.altitude];
    // 当前海拔位于以location.altitude为基准的多大范围内，若此数值为负数则表示Core Location无法确定你的海拔
    self.verticalAccuracyLabel.text = [NSString stringWithFormat:@"%gm", location.verticalAccuracy];
    // 使用大圆计算 计算出当前位置与起始点的距离
    self.distanceTraveledLabel.text = [NSString stringWithFormat:@"%gm", [location distanceFromLocation:self.startingPoint]];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSString *errorType = error.code == kCLErrorDenied ? @"Access Denied" : @"Unknow Error";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting Location" message:errorType delegate:nil cancelButtonTitle:@"OKay" otherButtonTitles:nil];
    [alert show];
}

@end
