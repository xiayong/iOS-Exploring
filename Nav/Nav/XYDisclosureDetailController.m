//
//  XYDisclosureDetailController.m
//  Nav
//
//  Created by Xia Yong on 13-7-16.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYDisclosureDetailController.h"

@interface XYDisclosureDetailController ()

@end

@implementation XYDisclosureDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.label.text = self.message;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    self.label = nil;
    self.message = nil;
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end
