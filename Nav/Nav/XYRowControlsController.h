//
//  XYRowControlController.h
//  Nav
//
//  Created by Xia Yong on 13-7-19.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYSecondLevelController.h"

@interface XYRowControlsController : XYSecondLevelController

@property (strong, nonatomic) NSArray *list;

- (IBAction)buttonTapped:(id)sender;

@end
