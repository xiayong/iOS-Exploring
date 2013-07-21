//
//  XYDeleteMeController.h
//  Nav
//
//  Created by Xia Yong on 13-7-22.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYSecondLevelController.h"

@interface XYDeleteMeController : XYSecondLevelController

@property (strong, nonatomic) NSMutableArray *list;
- (IBAction)toggleEdit:(id)sender;

@end
